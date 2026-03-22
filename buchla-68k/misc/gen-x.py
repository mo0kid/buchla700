#!/usr/bin/env python3

from sys import stdout
from pycparser import c_ast, parse_file, c_generator
from re import escape, subn, search

cross_gcc = "/opt/cross-m68k/bin/m68k-none-elf-gcc"

class InclVis(c_ast.NodeVisitor):
    def __init__(self, path):
        self.path = path
        self.typs = set()

    def visit_Typedef(self, node):
        if node.coord.file == self.path:
            self.typs.add(node.name)

        self.generic_visit(node)

    def visit_Struct(self, node):
        if node.coord.file == self.path and \
           node.name is not None and node.decls is not None:
            self.typs.add(node.name)

        self.generic_visit(node)

    def get_typs(self):
        return self.typs

typ_map = {
    "void": None
}

with open("misc/c-files.txt", "r") as f:
    for path in f:
        path = path.rstrip()

        if len(path) < 8 or path[:8] != "include/":
            continue

        stdout.write("parsing {}                    \r".format(path))
        stdout.flush()

        ast = parse_file(path, use_cpp = True, cpp_path = cross_gcc,
                         cpp_args = ["-E", "-I", "include"])
        # ast.show()

        vis = InclVis(path)
        vis.visit(ast)

        for typ in vis.get_typs():
            if typ in typ_map:
                raise Exception("redefinition of {}".format(typ))

            typ_map[typ] = path[8:]

class DeclVis(c_ast.NodeVisitor):
    def __init__(self, typ_map):
        self.typ_map = typ_map
        self.typs = set()

    def visit_IdentifierType(self, node):
        if node.names[0] not in self.typ_map:
            raise Exception("unknown type {} in {}:{}". \
                            format(node.names[0], node.coord.file, node.coord.line))

        self.typs.add(node.names[0])
        self.generic_visit(node)

    def visit_Struct(self, node):
        if node.name not in self.typ_map:
            raise Exception("unknown struct {} in {}:{}". \
                            format(node.name, node.coord.file, node.coord.line))

        self.typs.add(node.name)
        self.generic_visit(node)

    def get_typs(self):
        return self.typs

def fix(text, path):
    with open(path, "r") as f:
        cont = f.read()

    (pat, n) = subn(r"\[[0-9]+\]", "[@]", text[7:])

    if n == 0:
        return text

    rex = escape(pat). \
         replace("\@", "([0-9A-Z_]+)"). \
         replace("\ ", "[\t\n ]+")

    m = search(rex, cont)

    if not m:
        raise Exception("error while matching {}".format(re))

    pats = pat.split("@")
    vals = m.groups()

    if len(pats) != len(vals) + 1:
        raise Exception("length mismatch: {} vs. {}". \
                        format(len(pats), len(vals)))

    out = pats[0]
    pats = pats[1:]

    while len(pats) > 0:
        out += vals[0] + pats[0]
        vals = vals[1:]
        pats = pats[1:]

    return "extern " + out

gen = c_generator.CGenerator()

with open("misc/c-files.txt", "r") as f:
    for path in f:
        path = path.rstrip()

        if len(path) >= 8 and path[:8] == "include/":
            continue

        if path == "ram/wdfield.c": # breaks pycparser
            continue

        stdout.write("reading {}                    \r".format(path))
        stdout.flush()

        ast = parse_file(path, use_cpp = True, cpp_path = cross_gcc,
                         cpp_args = ["-E", "-I", "include"])
        # ast.show()

        incs = set()
        funs = {}
        vars = {}

        for node in ast.ext:
            if type(node) is c_ast.Decl and \
               (type(node.type) is c_ast.TypeDecl or \
                type(node.type) is c_ast.PtrDecl or \
                type(node.type) is c_ast.ArrayDecl):
                decl = node
                dest = vars

            elif type(node) is c_ast.FuncDef:
                decl = node.decl
                dest = funs

            else:
                continue

            if "extern" in decl.storage or \
               "static" in decl.storage:
                continue

            vis = DeclVis(typ_map)
            vis.visit(decl)

            for typ in vis.get_typs():
                if typ_map[typ] is not None:
                    incs.add(typ_map[typ])

            decl.storage = ["extern"]
            decl.init = None

            text = gen.visit(decl)
            text = fix(text, decl.coord.file)

            toks = text.split(" ")
            alig = ""

            alig += toks[0] + "\t"
            toks = toks[1:]

            if toks[0] == "struct":
                if len(toks[1]) > 7:
                    raise Exception("identifier too long: {}".format(toks[1]))

                alig += toks[0] + "\t" + toks[1] + "\t"
                toks = toks[2:]

            else:
                alig += toks[0] + ("\t\t" if len(toks[0]) < 8 else "\t")
                toks = toks[1:]

            dest[decl.name] = alig + " ".join(toks) + ";"

        if len(vars) == 0 and len(funs) == 0:
            continue

        file = path.split("/")[-1]
        glob = []

        glob.append("/*")
        glob.append("   =============================================================================")
        glob.append("\t" + file + " -- external declarations")
        glob.append("   =============================================================================")
        glob.append("*/")
        glob.append("")

        glob.append("#pragma once")
        glob.append("")

        if len(incs) > 0:
            for inc in sorted(incs):
                glob.append("#include \"{}\"".format(inc))

            glob.append("")

        if len(vars) > 0:
            glob.append("/*")
            glob.append("   =============================================================================")
            glob.append("\texternal variables")
            glob.append("   =============================================================================")
            glob.append("*/")
            glob.append("")

            for _, out in sorted(vars.items()):
                glob.append(out)

            glob.append("")

        if len(funs) > 0:
            glob.append("/*")
            glob.append("   =============================================================================")
            glob.append("\texternal functions")
            glob.append("   =============================================================================")
            glob.append("*/")
            glob.append("")

            for _, out in sorted(funs.items()):
                glob.append(out)

            glob.append("")

        with open(path[:-2] + ".x", "w") as f:
            f.write("\n".join(glob))

    print("")
