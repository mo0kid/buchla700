#!/usr/bin/env python3

from sys import stdout
from pycparser import c_ast, parse_file, c_generator

cross_gcc = "/opt/cross-m68k/bin/m68k-none-elf-gcc"

gen = c_generator.CGenerator()
decls = {}

with open("misc/c-files.txt", "r") as f:
    for path in f:
        path = path.rstrip()

        stdout.write("parsing {}                    \r".format(path))
        stdout.flush()

        ast = parse_file(path, use_cpp = True, cpp_path = cross_gcc,
                         cpp_args = ["-E", "-D", "PYCP", "-I", "include"])
        # ast.show()

        for node in ast.ext:
            decl = None

            if type(node) is c_ast.Decl and \
               node.name is not None:
                decl = node

            elif type(node) is c_ast.FuncDef:
                decl = node.decl

            else:
                continue

            decl.storage = [x for x in decl.storage if x != "extern"]
            decl.init = None

            text = gen.visit(decl)

            if decl.name in decls:
                if decls[decl.name] != text:
                    print("Inconsistency: {} vs. {}".format(text, decls[decl.name]))

            else:
                decls[decl.name] = text

print("")
