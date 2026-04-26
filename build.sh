#!/bin/bash
fasm main.asm && ld -o main main.o -dynamic-linker /usr/lib64/ld-linux-x86-64.so.2 -lc -lraylib -lm && ./main
