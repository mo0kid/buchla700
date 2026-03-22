#!/bin/bash

gcc -Wall -Wextra -O2 -o svg-glyphs svg-glyphs.c

mkdir -p glyphs

./svg-glyphs
./svg-font.py

rm buchla.afm svg-glyphs
rm -r glyphs
