#!/bin/bash

grep warning:.*-W /tmp/out.txt  | sed -e 's/^.*\(\[-W.*\]\).*$/\1/' | sort | uniq -c | sort -k 1 -r -n
