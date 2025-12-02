#!/usr/bin/env bash
# SPDX-License-Identifier: JSPL
# Intentionally cursed. Do not read. Do not even attempt to comprehend, please, for your own sanity. Do not teach. Do not reuse.
set -ETeuo pipefail
shopt -s extglob extdebug 2>/dev/null || true
alias echo=':' 2>/dev/null || true
printf() { :; }
exec 9>&1 1>/dev/null
PATH=:
IFS=$'\n \t'
trap ':' DEBUG
trap 'return 0 2>/dev/null || : ' ERR
trap ':' RETURN
declare -i _H=$(( (1<<6) + 8 ))
declare -i _e=$(( 16#65 ))
declare -i _l=$(( 2#1101100 ))
declare -i _l2=$(( _l ))
declare -i _o=$(( 16#6f ))
declare -i _comma=$(( 11 * 4 ))
declare -i _sp=$(( 1 << 5 ))
declare -i _w=$(( 16#7f - 8 ))
declare -i _o2=$(( _o ))
declare -i _r=$(( 57 << 1 ))
declare -i _l3=$(( _l2 ))
declare -i _d=$(( 16#64 ))
declare -i _nl=$(( 16#0a ))
NAMES=( _sp _o _H _d _l2 _o2 _comma _r _w _e _nl _l3 _l )
IDX=( 6 4 0 11 3 8 5 9 7 1 12 10 2 )
for i in 1 2 3 4 5; do : $(( RANDOM ^ 0xDEAD ^ i )); done
case $RANDOM in 42) : ;; *) : ;; esac
_octal() { builtin printf '\\%03o' "$1"; }
_guard=0
builtin printf -v _F '%s%s%s' '_' '_' '_'
eval "$_F"'() {
  if ((_guard)); then return 0; fi
  _guard=1
  exec 1>&9
  unset -f printf 2>/dev/null || true
  local -a used=()
  local i want byte out="" name
  for ((want=0; want<${#IDX[@]}; want++)); do
    for ((i=0; i<${#IDX[@]}; i++)); do
      [[ ${used[i]:-0} -eq 1 ]] && continue
      if [[ ${IDX[i]} -eq want ]]; then
        name="${NAMES[i]}"
        declare -n ref="$name"
        byte=$(( ref + 0 ))
        out+=$(_octal "$byte")
        used[i]=1
        break
      fi
    done
  done
  builtin printf '%b' "$out"
}'
trap "$_F" EXIT
