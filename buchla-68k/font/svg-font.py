#!/usr/bin/python

import fontforge

font = fontforge.font()

font.ascent = 2816
font.descent = 256
font.em = 3072
font.upos = -256

font.copyright = ""

font.fontname = "Buchla"
font.familyname = "Buchla"
font.fullname = ""

for i in range(0, 256):
    if i < 32:
        code = 10240 + i
    elif i < 127:
        code = i
    else:
        code = (10240 + 32) + (i - 127);

    print("importing {:04x}".format(code))

    glyph = font.createChar(code)
    glyph.width = 2048

    glyph.importOutlines("glyphs/{:04x}.svg".format(code))

font.generate("buchla.woff")
font.generate("buchla.ttf")
font.generate("buchla.eot")
