from pathlib import Path
import json, re, sys

root = Path(__file__).resolve().parents[1]
inv = json.loads((root / "INVENTORY.json").read_text())
src = (root / "laws.bend").read_text()
proof = (root / "PROOF.bend").read_text()
laws = (root / "LAWS.bend").read_text()
errors = []

for block in inv["source_blocks"]:
    if f"  {block}{{}}" not in src:
        errors.append(f"missing SourceBlock constructor: {block}")

if len(inv["source_blocks"]) != 74:
    errors.append(f"inventory count is {len(inv['source_blocks'])}, expected 74")

for term in inv["core_interpretive_terms"]:
    if f"  {term}{{}}" not in src:
        errors.append(f"missing InterpretiveTerm constructor: {term}")

for pat in (r"@unsafe", r"\?TODO", r"(?m)^\s*def\s+[A-Za-z0-9_.]+\?"):
    for p in root.rglob("*.bend"):
        if re.search(pat, p.read_text()):
            errors.append(f"proof escape {pat!r} in {p.relative_to(root)}")

if "import ./LAWS.bend as Laws" not in proof:
    errors.append("PROOF.bend does not import LAWS.bend as Laws")

for name in re.findall(r"(?m)^law\s+([A-Za-z0-9_]+):", laws):
    if f"def Laws.{name}(" not in proof:
        errors.append(f"missing proof def for law {name}")

if errors:
    print("\n".join(errors), file=sys.stderr)
    raise SystemExit(1)

print(f"static audit ok: {len(inv['source_blocks'])} source blocks, {len(inv['core_interpretive_terms'])} explicit interpretive terms")
