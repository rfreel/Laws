#!/usr/bin/env python3
"""Differential test runner: evaluate every LAWS.bend law in the independent
Python model (tools/differential/model.py) and compare with the stated
expected value.

Usage:  python3 tools/differential/run.py [--laws LAWS.bend]

Exit codes: 0 = all laws pass; 1 = at least one mismatch; 2 = a law could
not be evaluated (parse gap or missing model function) — a harness gap,
never a silent pass.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.differential.model import (  # noqa: E402
    CLAUSES,
    SOURCE_BLOCKS,
    Data,
    REGISTRY,
)


# --------------------------------------------------------------------------
# Expression parser for the LAWS.bend statement subset
# --------------------------------------------------------------------------
# expr   := primary
# primary:= NAT | 'True{}' | 'False{}'
#         | 'C.' NAME '(' args ')'      (function call)
#         | 'C.' NAME '{' fields '}'   (data constructor, positional fields)
#         | 'C.' NAME '{}'             (nullary constructor)
#         | 'Bool.' NAME '(' args ')'  (Bool.and / Bool.or / Bool.not)
#         | VAR                        (quantified variable: block, c)
# args   := expr (',' expr)*

class ParseError(Exception):
    pass


class Skip(Exception):
    """A law the harness cannot evaluate — must be explained, never hidden."""


class Parser:
    def __init__(self, s: str):
        self.s = s
        self.i = 0

    def ws(self):
        while self.i < len(self.s) and self.s[self.i] in " \t":
            self.i += 1

    def peek(self) -> str:
        return self.s[self.i] if self.i < len(self.s) else ""

    def expect(self, ch: str):
        self.ws()
        if self.peek() != ch:
            raise ParseError(f"expected {ch!r} at {self.i} in {self.s!r}")
        self.i += 1

    def parse_expr(self):
        self.ws()
        c = self.peek()
        if c.isdigit():
            return self.parse_nat()
        if self.s.startswith("True{}", self.i):
            self.i += len("True{}")
            return ("bool", True)
        if self.s.startswith("False{}", self.i):
            self.i += len("False{}")
            return ("bool", False)
        if self.s.startswith("C.", self.i):
            self.i += 2
            return self.parse_qualified("C")
        if self.s.startswith("Bool.", self.i):
            self.i += 5
            return self.parse_qualified("Bool")
        m = re.match(r"[A-Za-z_][A-Za-z0-9_]*", self.s[self.i :])
        if m:
            self.i += len(m.group(0))
            return ("var", m.group(0))
        raise ParseError(f"unexpected char {c!r} at {self.i} in {self.s!r}")

    def parse_nat(self):
        m = re.match(r"\d+n", self.s[self.i :])
        if not m:
            raise ParseError(f"bad Nat literal at {self.i} in {self.s!r}")
        self.i += len(m.group(0))
        return ("nat", int(m.group(0)[:-1]))

    def parse_qualified(self, ns: str):
        m = re.match(r"[A-Za-z_][A-Za-z0-9_]*", self.s[self.i :])
        if not m:
            raise ParseError(f"expected name at {self.i} in {self.s!r}")
        name = m.group(0)
        self.i += len(name)
        self.ws()
        if self.peek() == "(":
            self.i += 1
            args = self.parse_list(")")
            return ("call" if ns == "C" else "prim", name, args)
        if self.peek() == "{":
            self.i += 1
            self.ws()
            if self.peek() == "}":
                self.i += 1
                if ns != "C":
                    raise ParseError("Bool. constructor?")
                return ("ctor", name, [])
            fields = self.parse_list("}")
            if ns != "C":
                raise ParseError("Bool. constructor?")
            return ("ctor", name, fields)
        raise ParseError(f"expected '(' or '{{' at {self.i} in {self.s!r}")

    def parse_list(self, closer: str):
        items = []
        self.ws()
        if self.peek() == closer:
            self.i += 1
            return items
        while True:
            items.append(self.parse_expr())
            self.ws()
            if self.peek() == ",":
                self.i += 1
                continue
            if self.peek() == closer:
                self.i += 1
                return items
            raise ParseError(
                f"expected ',' or {closer!r} at {self.i} in {self.s!r}"
            )

    def parse_top(self):
        node = self.parse_expr()
        self.ws()
        if self.i != len(self.s):
            raise ParseError(f"trailing text at {self.i} in {self.s!r}")
        return node


# --------------------------------------------------------------------------
# Evaluator
# --------------------------------------------------------------------------

def ev(node, env: dict):
    kind = node[0]
    if kind == "nat":
        return node[1]
    if kind == "bool":
        return node[1]
    if kind == "var":
        try:
            return env[node[1]]
        except KeyError:
            raise Skip(f"unbound variable {node[1]}")
    if kind == "ctor":
        return Data(node[1], tuple(ev(a, env) for a in node[2]))
    if kind == "prim":
        name, args = node[1], [ev(a, env) for a in node[2]]
        if name == "and" and len(args) == 2:
            return args[0] and args[1]
        if name == "or" and len(args) == 2:
            return args[0] or args[1]
        if name == "not" and len(args) == 1:
            return not args[0]
        raise Skip(f"unknown Bool primitive {name}/{len(args)}")
    if kind == "call":
        name, raw = node[1], node[2]
        fn = REGISTRY.get(name)
        if fn is None:
            raise Skip(f"no Python model for C.{name}")
        args = [ev(a, env) for a in raw]
        try:
            return fn(*args)
        except TypeError as e:
            raise Skip(f"C.{name} arity/type error: {e}")
    raise ParseError(f"bad node {node!r}")


# --------------------------------------------------------------------------
# Law file parsing
# --------------------------------------------------------------------------

_LAW_RE = re.compile(r"^law (\w+):\s*$")
_FOR_RE = re.compile(r"^\s*for (\w+): C\.(\w+)\s*$")

_CONSTRUCTORS = {"SourceBlock": SOURCE_BLOCKS, "Clause": CLAUSES}


def parse_laws(path: Path):
    """Yield (name, var, type_name_or_None, lhs_src, rhs_src, annotation)."""
    laws = []
    name, for_var, for_type, stmt = None, None, None, None
    for lineno, line in enumerate(path.read_text().splitlines(), 1):
        m = _LAW_RE.match(line)
        if m:
            if name is not None:
                laws.append((name, for_var, for_type, stmt, lineno))
            name, for_var, for_type, stmt = m.group(1), None, None, None
            continue
        if name is None:
            continue
        s = line.strip()
        if not s or s.startswith("#"):
            continue
        fm = _FOR_RE.match(line)
        if fm:
            for_var, for_type = fm.group(1), fm.group(2)
            continue
        if s.startswith("{"):
            if stmt is not None:
                raise ParseError(f"{name}: two statements (line {lineno})")
            stmt = s
            continue
        raise ParseError(f"{name}: unexpected line {lineno}: {line!r}")
    if name is not None:
        laws.append((name, for_var, for_type, stmt, lineno))
    out = []
    for name, for_var, for_type, stmt, lineno in laws:
        if stmt is None:
            raise ParseError(f"{name}: no statement")
        inner = stmt.strip()
        if not (inner.startswith("{") and inner.endswith("}")):
            raise ParseError(f"{name}: statement not wrapped in {{}}")
        inner = inner[1:-1]
        # Split `LHS == RHS : ANN`. The annotation is the last `: X` part;
        # `==` never appears inside these expressions.
        if "==" not in inner:
            raise ParseError(f"{name}: no == in statement")
        lhs_src, rest = inner.split("==", 1)
        if ":" not in rest:
            raise ParseError(f"{name}: no type annotation")
        rhs_src, ann = rest.rsplit(":", 1)
        out.append(
            (name, for_var, for_type, lhs_src.strip(), rhs_src.strip(), ann.strip())
        )
    return out


def check_annotation(ann: str, value) -> bool:
    if ann == "Bool":
        return isinstance(value, bool)
    # Any Data-typed annotation: the value must be a Data constructor.
    return isinstance(value, Data)


# --------------------------------------------------------------------------
# Main
# --------------------------------------------------------------------------

def main() -> int:
    laws_path = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("LAWS.bend")
    if not laws_path.is_absolute():
        laws_path = Path.cwd() / laws_path
    laws = parse_laws(laws_path)

    passed, failed, skipped = 0, 0, 0
    failures, skips = [], []
    for name, for_var, for_type, lhs_src, rhs_src, ann in laws:
        try:
            lhs = Parser(lhs_src).parse_top()
            rhs = Parser(rhs_src).parse_top()
        except ParseError as e:
            skipped += 1
            skips.append((name, f"parse error: {e}"))
            continue
        if for_var is not None:
            ctors = _CONSTRUCTORS.get(for_type)
            if ctors is None:
                skipped += 1
                skips.append((name, f"unknown quantified type C.{for_type}"))
                continue
            bindings = [(for_var, Data(c)) for c in ctors]
        else:
            bindings = [(None, None)]
        ok = True
        detail = None
        for var, val in bindings:
            env = {var: val} if var else {}
            try:
                got = ev(lhs, env)
                want = ev(rhs, env)
            except Skip as e:
                ok, detail = "skip", str(e)
                break
            except Exception as e:  # model crash = finding, not silence
                ok, detail = False, f"model raised {type(e).__name__}: {e}"
                break
            if not check_annotation(ann, got):
                ok, detail = False, f"annotation :{ann} but got {got!r}"
                break
            if got != want:
                where = f" ({for_type}.{val.name})" if var else ""
                ok, detail = False, f"{where} got {got!r}, want {want!r}"
                break
        if ok is True:
            passed += 1
        elif ok == "skip":
            skipped += 1
            skips.append((name, detail))
        else:
            failed += 1
            failures.append((name, detail))

    print(f"laws parsed : {len(laws)}")
    print(f"passed      : {passed}")
    print(f"failed      : {failed}")
    print(f"skipped     : {skipped}")
    for name, detail in failures:
        print(f"FAIL {name}: {detail}")
    for name, detail in skips:
        print(f"SKIP {name}: {detail}")

    if failed:
        return 1
    if skipped:
        return 2
    print("differential ok: Python model agrees with every LAWS.bend statement")
    return 0


if __name__ == "__main__":
    sys.exit(main())
