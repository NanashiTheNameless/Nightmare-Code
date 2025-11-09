#!/usr/bin/env bash
# LICENSE: JSPL
# Intentionally cursed. Do not read. Do not teach. Do not reuse.
p=$'\160\162\151\156\164\146';s=;for i in 1001000 1100101 1101100 1101100 1101111 101100 100000 1010111 1101111 1110010 1101100 1100100;do s+="\\x$(printf %02x "$((2#$i))")";done; "$p" "%b\n" "$s"
