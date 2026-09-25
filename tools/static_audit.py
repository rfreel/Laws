from pathlib import Path
import json, re, sys

root = Path(__file__).resolve().parents[1]
inv = json.loads((root / "INVENTORY.json").read_text())
src = (root / "laws.bend").read_text()
proof = (root / "PROOF.bend").read_text()
laws = (root / "LAWS.bend").read_text()
errors = []

SKIP_DIR_NAMES = {".bend-prefix", ".git", "__pycache__", "node_modules"}

def iter_bend_files():
    for p in root.rglob("*.bend"):
        if any(part in SKIP_DIR_NAMES for part in p.parts):
            continue
        yield p

for block in inv["source_blocks"]:
    if f"  {block}{{}}" not in src:
        errors.append(f"missing SourceBlock constructor: {block}")

if len(inv["source_blocks"]) != 74:
    errors.append(f"inventory count is {len(inv['source_blocks'])}, expected 74")

for term in inv["core_interpretive_terms"]:
    if f"  {term}{{}}" not in src:
        errors.append(f"missing InterpretiveTerm constructor: {term}")

for pat in (r"@unsafe", r"\?TODO", r"(?m)^\s*def\s+[A-Za-z0-9_.]+\?"):
    for p in iter_bend_files():
        if re.search(pat, p.read_text()):
            errors.append(f"proof escape {pat!r} in {p.relative_to(root)}")

if "import ./LAWS.bend as Laws" not in proof:
    errors.append("PROOF.bend does not import LAWS.bend as Laws")

for name in re.findall(r"(?m)^law\s+([A-Za-z0-9_]+):", laws):
    if f"def Laws.{name}(" not in proof:
        errors.append(f"missing proof def for law {name}")

# --- TASKS.md item 5: clause -> transcript source map (sourcemap.json) ---
# Every check below fails loudly: any mismatch is appended to errors and the
# audit exits nonzero naming the offender. The map is checked against
# laws.bend itself (constructors + clause_source/clause_index matches), so a
# clause added to the code without a map entry, or a map entry drifting from
# the code, breaks the gate.
ARCHIVE_URLS = {
    "https://www.archives.gov/founding-docs/constitution-transcript",
    "https://www.archives.gov/founding-docs/bill-of-rights-transcript",
    "https://www.archives.gov/founding-docs/amendments-11-27",
}
REQUIRED_FIELDS = {"clause", "index", "source_block", "transcript",
                   "transcript_section", "effect", "kind", "text"}

smap_path = root / "sourcemap.json"
try:
    smap = json.loads(smap_path.read_text())
    map_entries = smap["clauses"]
except Exception as exc:
    errors.append(f"sourcemap.json unreadable: {exc}")
    map_entries = []

if isinstance(map_entries, list):
    # Parse the code side: clause constructors and the source/index matches.
    code_ctors = re.findall(r"(?m)^  (CL_[A-Za-z0-9_]+)\{\}$", src.split("def clause_source")[0])
    def match_arms(fn, val):
        body = re.search(r"def %s\(.*?\n(.*?)(?=\ndef |\Z)" % fn, src, re.S).group(1)
        return dict(re.findall(r"case (CL_[A-Za-z0-9_]+)\{\}:\n(?:      #[^\n]*\n)*      (%s)" % val, body))
    code_source = {c: v[:-2] for c, v in match_arms("clause_source", r"[A-Za-z0-9_]+\{\}").items()}
    code_index = {c: int(v[:-1]) for c, v in match_arms("clause_index", r"\d+n").items()}

    seen, entry_by_clause = set(), {}
    for i, e in enumerate(map_entries):
        tag = f"sourcemap entry {i}"
        if not isinstance(e, dict) or set(e) != REQUIRED_FIELDS:
            errors.append(f"{tag}: fields must be exactly {sorted(REQUIRED_FIELDS)}, got {sorted(e) if isinstance(e, dict) else type(e).__name__}")
            continue
        c = e["clause"]
        if c in seen:
            errors.append(f"duplicate sourcemap entry for clause {c}")
        seen.add(c)
        entry_by_clause[c] = e
        if e["kind"] not in ("quote", "paraphrase"):
            errors.append(f"sourcemap entry for {c}: kind must be quote|paraphrase, got {e['kind']!r}")
        if e["transcript"] not in ARCHIVE_URLS:
            errors.append(f"sourcemap entry for {c}: transcript is not an Archives URL: {e['transcript']!r}")
        if not e["transcript_section"] or not e["text"]:
            errors.append(f"sourcemap entry for {c}: empty transcript_section or text")
        if c in code_ctors:
            if e["source_block"] != code_source.get(c):
                errors.append(f"sourcemap entry for {c}: source_block {e['source_block']!r} != laws.bend clause_source {code_source.get(c)!r}")
            if e["index"] != code_index.get(c):
                errors.append(f"sourcemap entry for {c}: index {e['index']!r} != laws.bend clause_index {code_index.get(c)!r}")
        else:
            errors.append(f"sourcemap entry references nonexistent clause: {c}")
        if e["source_block"] not in inv["source_blocks"]:
            errors.append(f"sourcemap entry for {c}: unknown source_block {e['source_block']!r}")

    for c in code_ctors:
        if c not in seen:
            errors.append(f"clause {c} has no sourcemap.json entry")

    if sorted(code_index.values()) != list(range(len(code_ctors))):
        errors.append("clause_index arms are not a contiguous 0..n-1 range")
    if sorted(e["index"] for e in entry_by_clause.values()) != list(range(len(code_ctors))):
        errors.append("sourcemap indices are not a contiguous 0..n-1 range")

    covered_blocks = {e["source_block"] for e in entry_by_clause.values()}
    for block in inv["source_blocks"]:
        if block not in covered_blocks:
            errors.append(f"source block {block} has no clause in sourcemap.json")

if errors:
    print("\n".join(errors), file=sys.stderr)
    raise SystemExit(1)

print(f"static audit ok: {len(inv['source_blocks'])} source blocks, {len(inv['core_interpretive_terms'])} explicit interpretive terms, {len(map_entries) if isinstance(map_entries, list) else 0} sourcemap entries")
