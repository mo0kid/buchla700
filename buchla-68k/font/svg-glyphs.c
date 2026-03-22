#include <assert.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>

#include "cg2.c"

int32_t main(int32_t argc, char *argv[])
{
    (void)argc;
    (void)argv;

    for (int32_t glyph = 0; glyph < 256; ++glyph) {
        int32_t code;

        if (glyph < 32) {
            code = 10240 + glyph;
        }
        else if (glyph < 127) {
            code = glyph;
        }
        else {
            code = (10240 + 32) + (glyph - 127);
        }

        char name[16];

        snprintf(name, sizeof(name), "glyphs/%04x.svg", code);

        FILE *fh = fopen(name, "w");
        assert(fh != NULL);

        fprintf(fh, "<?xml version=\"1.0\"?>\n");
        fprintf(fh, "<svg width=\"2048\" height=\"3072\" viewBox=\"0 0 2048 3072\" xmlns=\"http://www.w3.org/2000/svg\">\n");

        for (int32_t row = 0; row < cg_rows; ++row) {
            int32_t y = row * 256 + 8;
            int32_t bits = cgtable[cg_rows - 1 - row][glyph];
            int32_t mask = 0x01;

            for (int32_t col = 0; col < 8; ++col) {
                if ((bits & mask) != 0) {
                    int32_t x = col * 256 + 8;

                    fprintf(fh, "  <path d=\"M %d %d l 240 0 l 0 240 l -240 0 z\"/>\n", x, y);
                }

                mask <<= 1;
            }
        }

        fprintf(fh, "</svg>\n");

        fclose(fh);
    }

    return 0;
}
