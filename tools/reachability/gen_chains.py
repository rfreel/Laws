#!/usr/bin/env python3
"""Generate the reachability gate: a balanced Bool.and tree of the key
8-state amendment-reachability claims, as Bend defs.

Reads laws.bend (hand-written reachability model + machine-check helpers)
and emits `reachability_gate()`, the conjunction of the key claims:
  - the 2-step dictatorship witness (ArticleVProcedure then OrdinaryAmendment
    at max votes) reaches code 0 with self_amendment_ok=True and code 5
    ({T,F,T}) with self_amendment_ok=False — the conditional both ways;
  - the three 1-step targets cannot reach dictatorship (codes 2, 5, 7);
  - the three documented 3-step chains stay blocked at code 5 when
    self-amendment is denied.

Mechanical guards (fail loudly rather than silently mis-generate):
  1. `const_state_bits` must enumerate exactly the 8 abstract states: the
     generator symbolically evaluates its nested-match tree over all 8
     (p, r, s) inputs and asserts the codes come out 4p+2r+s, so
     dictatorship CState{False,False,False} is code 0.
  2. `const_state_code` must project the three CState fields into
     const_state_bits in (proviso, rights, self_rule) order.
  3. `amendment_step`'s target match must have exactly the three
     AmendmentTarget arms; `apply_ordinary`/`apply_articleV` exactly the
     True{}/False{} validity arms.
  4. `self_amendment_ok` must be an explicit caller Bool in the signatures
     of amendment_step, amendment_valid and amendment_permissible, and as
     per-step okN Bools in reach_chain_2/reach_chain_3 (Bend 2.0.27 uses
     each variable at most once, so one Bool per step is the honest form).
  5. `const_init()` must be the all-intact state.
  6. reach_chain_2/reach_chain_3 must call amendment_step exactly 2/3 times.

Usage:
  python3 tools/reachability/gen_chains.py >> laws.bend   # append the block
  python3 tools/reachability/gen_chains.py --check        # block is fresh
(The emitted block is delimited by BEGIN/END markers so it can be replaced:
delete the old block between the markers, then re-append.)
"""

import re
import sys

REPO = __file__.rsplit("/tools/reachability/gen_chains.py", 1)[0]
LAWS = REPO + "/laws.bend"

BEGIN = "# === BEGIN GENERATED reachability chains (tools/reachability/gen_chains.py) ==="
END = "# === END GENERATED reachability chains ==="

# Max-vote step arguments shared by every generated leaf (attacker's best
# case: thresholds monotone in yes-votes, so max votes dominate).
MAXV = "435n, ChamberCount{435n, 435n}, 100n, ChamberCount{100n, 100n}, 50n, StatesCount{50n}, True{}"


def fail(msg: str) -> "sys.NoReturn":
    raise SystemExit(f"gen_chains: {msg}")


def extract_def(text: str, name: str) -> str:
    m = re.search(rf"^def {name}\(.*?\n(?=^def |\Z)", text, re.M | re.S)
    if not m:
        fail(f"def {name} not found in laws.bend")
    return m.group(0)


def header_of(defn: str) -> str:
    return defn.split("\n", 1)[0]


# ---------------------------------------------------------------------------
# Guard 1+2: the state enumeration. Parse const_state_bits' nested matches
# into a decision tree, then evaluate all 8 (p, r, s) combos.
# ---------------------------------------------------------------------------

def _indent_of(line: str) -> int:
    return len(line) - len(line.lstrip(" "))


def _parse_match(lines, i: int, match_indent: int):
    """Parse `match <var>:` at lines[i]; return ((var, branches), next_i)."""
    m = re.match(r"\s*match (\w+):\s*$", lines[i])
    if not m or _indent_of(lines[i]) != match_indent:
        fail(f"const_state_bits: expected 'match <var>:' at indent {match_indent}, got {lines[i]!r}")
    var = m.group(1)
    i += 1
    branches: dict[bool, object] = {}
    while i < len(lines):
        line = lines[i]
        if not line.strip():
            i += 1
            continue
        if _indent_of(line) != match_indent + 2:
            break
        m = re.match(r"\s*case (True|False)\{\}:(.*)$", line)
        if not m:
            break
        val = m.group(1) == "True"
        rest = m.group(2).strip()
        i += 1
        if rest:
            lm = re.fullmatch(r"(\d+)n", rest)
            if not lm:
                fail(f"const_state_bits: bad leaf {line!r}")
            branches[val] = int(lm.group(1))
        else:
            subtree, i = _parse_match(lines, i, match_indent + 4)
            branches[val] = subtree
    if set(branches) != {True, False}:
        fail(f"const_state_bits: match on {var} lacks a True/False arm")
    return (var, branches), i


def _eval_tree(tree, env: dict) -> int:
    var, branches = tree
    nxt = branches[env[var]]
    return nxt if isinstance(nxt, int) else _eval_tree(nxt, env)


def _count_leaves(tree) -> int:
    _, branches = tree
    n = 0
    for nxt in branches.values():
        n += 1 if isinstance(nxt, int) else _count_leaves(nxt)
    return n


def check_state_enumeration(text: str) -> None:
    defn = extract_def(text, "const_state_bits")
    lines = [ln for ln in defn.split("\n")[1:] if ln.strip()]
    tree, _ = _parse_match(lines, 0, 2)
    if _count_leaves(tree) != 8:
        fail(f"const_state_bits: expected 8 leaf arms, found {_count_leaves(tree)}")
    seen: dict[int, tuple] = {}
    for p in (False, True):
        for r in (False, True):
            for s in (False, True):
                code = _eval_tree(tree, _env(tree, p, r, s))
                want = 4 * p + 2 * r + s
                if code != want:
                    fail(
                        f"const_state_bits: ({p},{r},{s}) codes to {code}, "
                        f"expected bit-order code {want}"
                    )
                seen[code] = (p, r, s)
    if set(seen) != set(range(8)):
        fail(f"const_state_bits: codes are not 0..7, got {sorted(seen)}")
    # Guard 2: the wrapper must feed (proviso, rights, self_rule) in order.
    wrap = extract_def(text, "const_state_code")
    if "const_state_bits(proviso_intact, rights_intact, self_rule_intact)" not in wrap:
        fail("const_state_code: field order into const_state_bits changed")


def _env(tree, p: bool, r: bool, s: bool) -> dict:
    # Bind by position: the tree matches three Bool vars in nesting order;
    # collect the var names in first-visit order and zip with (p, r, s).
    order: list[str] = []

    def visit(t):
        var, branches = t
        if var not in order:
            order.append(var)
        for nxt in branches.values():
            if not isinstance(nxt, int):
                visit(nxt)

    visit(tree)
    if len(order) != 3:
        fail(f"const_state_bits: expected 3 matched vars, got {order}")
    return dict(zip(order, (p, r, s)))


# ---------------------------------------------------------------------------
# Guards 3-6: transition arms, caller-Bool threading, init, chain shapes.
# ---------------------------------------------------------------------------

def check_transitions(text: str) -> None:
    step = extract_def(text, "amendment_step")
    arms = set(re.findall(r"^\s*case (OrdinaryAmendment|EqualSuffrageDeprivation|ArticleVProcedure)\{\}:", step, re.M))
    expected = {"OrdinaryAmendment", "EqualSuffrageDeprivation", "ArticleVProcedure"}
    if arms != expected:
        fail(f"amendment_step: target arms {sorted(arms)} != {sorted(expected)}")
    for name in ("apply_ordinary", "apply_articleV"):
        d = extract_def(text, name)
        arms = set(re.findall(r"^\s*case (True|False)\{\}:", d, re.M))
        if arms != {"True", "False"}:
            fail(f"{name}: validity arms {sorted(arms)} != [False, True]")


def check_caller_bool_threading(text: str) -> None:
    for name in ("amendment_step", "amendment_valid", "amendment_permissible"):
        if "self_amendment_ok: Bool" not in header_of(extract_def(text, name)):
            fail(f"{name}: self_amendment_ok is no longer an explicit caller Bool")
    h2 = header_of(extract_def(text, "reach_chain_2"))
    if not ("ok1: Bool" in h2 and "ok2: Bool" in h2):
        fail("reach_chain_2: per-step caller Bools ok1/ok2 missing")
    h3 = header_of(extract_def(text, "reach_chain_3"))
    if not ("ok1: Bool" in h3 and "ok2: Bool" in h3 and "ok3: Bool" in h3):
        fail("reach_chain_3: per-step caller Bools ok1/ok2/ok3 missing")


def check_init_and_chains(text: str) -> None:
    init = extract_def(text, "const_init")
    if "CState{True{}, True{}, True{}}" not in init:
        fail("const_init is no longer the all-intact state")
    c2 = extract_def(text, "reach_chain_2")
    if c2.count("amendment_step(") != 2:
        fail(f"reach_chain_2: expected 2 amendment_step calls, found {c2.count('amendment_step(')}")
    c3 = extract_def(text, "reach_chain_3")
    if c3.count("amendment_step(") != 3:
        fail(f"reach_chain_3: expected 3 amendment_step calls, found {c3.count('amendment_step(')}")


# ---------------------------------------------------------------------------
# Block generation.
# ---------------------------------------------------------------------------

def _code(expr: str, want: int) -> str:
    return f"Nat.is_eq(const_state_code({expr}), {want}n)"


def _step1(target: str, self_ok: str) -> str:
    return f"amendment_step(const_init(), {target}{{}}, {MAXV}, {self_ok}{{}})"


def _chain2(t1: str, o1: str, t2: str, o2: str) -> str:
    return f"reach_chain_2({t1}{{}}, {o1}{{}}, {t2}{{}}, {o2}{{}})"


def _chain3(t1: str, o1: str, t2: str, o2: str, t3: str, o3: str) -> str:
    return f"reach_chain_3({t1}{{}}, {o1}{{}}, {t2}{{}}, {o2}{{}}, {t3}{{}}, {o3}{{}})"


def leaves() -> list[str]:
    return [
        # 2-step dictatorship witness, conditional both ways on the caller's
        # self-amendment judgment (codes: 0 = {F,F,F}, 5 = {T,F,T}).
        _code(_chain2("ArticleVProcedure", "True", "OrdinaryAmendment", "True"), 0),
        _code(_chain2("ArticleVProcedure", "False", "OrdinaryAmendment", "False"), 5),
        # 1-step: no single target reaches dictatorship, even at max votes
        # with self-amendment held valid (2 = {F,T,F}, 7 = {T,T,T}).
        _code(_step1("ArticleVProcedure", "True"), 2),
        _code(_step1("OrdinaryAmendment", "True"), 5),
        _code(_step1("EqualSuffrageDeprivation", "True"), 7),
        # 3-step chains blocked when self-amendment is denied (all land {T,F,T}).
        _code(_chain3("OrdinaryAmendment", "False", "OrdinaryAmendment", "False", "OrdinaryAmendment", "False"), 5),
        _code(_chain3("ArticleVProcedure", "False", "OrdinaryAmendment", "False", "ArticleVProcedure", "False"), 5),
        _code(_chain3("EqualSuffrageDeprivation", "False", "OrdinaryAmendment", "False", "EqualSuffrageDeprivation", "False"), 5),
    ]


def balanced(items: list[str]) -> str:
    if len(items) == 1:
        return items[0]
    mid = len(items) // 2
    return f"Bool.and({balanced(items[:mid])}, {balanced(items[mid:])})"


def generate() -> str:
    text = open(LAWS).read()
    check_state_enumeration(text)
    check_transitions(text)
    check_caller_bool_threading(text)
    check_init_and_chains(text)

    ls = leaves()
    print(f"# gen_chains: {len(ls)} key reachability claims", file=sys.stderr)

    out = [
        BEGIN,
        "# Do not hand-edit: regenerate with `python3 tools/reachability/gen_chains.py`.",
        "# Balanced Bool.and tree over the key 8-state amendment-reachability claims,",
        "# at the attacker's max-vote configuration (435/435, 100/100, 50/50).",
        "# State codes are proviso*4 + rights*2 + self_rule: 0 = dictatorship {F,F,F},",
        "# 2 = {F,T,F}, 5 = {T,F,T}, 7 = {T,T,T} (all-intact start).",
        "# Claim: reachability_gate() == True{} establishes the headline results —",
        "# the 2-step dictatorship witness conditional both ways on the caller's",
        "# self-amendment judgment, the three 1-step impossibilities, and the three",
        "# 3-step chains blocked when self-amendment is denied.",
        "# What this does NOT establish: universality over vote configurations",
        "# (rests on the documented vote-monotonicity argument), unbounded-step",
        "# reachability (the Python sweep in tools/reachability/check.py covers the",
        "# fixpoint), or anything about the real Constitution — every claim is",
        "# about the abstract 8-state ConstState model, which OVER-approximates",
        "# attacker power, so unreachability here is strong and reachability is",
        "# existential (one model-permitted path, not a prediction).",
        "def reachability_gate() -> Bool:",
        f"  {balanced(ls)}",
        END,
    ]
    return "\n".join(out) + "\n"


def check_fresh() -> int:
    want = generate()
    text = open(LAWS).read()
    i, j = text.find(BEGIN), text.find(END)
    if i < 0 or j < 0:
        print("gen_chains --check: generated block missing from laws.bend", file=sys.stderr)
        return 1
    have = text[i : j + len(END)] + "\n"
    if have != want:
        print("gen_chains --check: laws.bend block is STALE (regenerate and re-append)", file=sys.stderr)
        return 1
    print("gen_chains --check: generated block is fresh", file=sys.stderr)
    return 0


def main() -> int:
    if len(sys.argv) > 1 and sys.argv[1] == "--check":
        return check_fresh()
    if len(sys.argv) > 1:
        print(f"gen_chains: unknown arg {sys.argv[1]}", file=sys.stderr)
        return 2
    text = open(LAWS).read()
    if BEGIN in text or "def reachability_gate(" in text:
        fail("laws.bend already contains a reachability block; delete it before re-appending")
    sys.stdout.write(generate())
    return 0


if __name__ == "__main__":
    sys.exit(main())
