#!/usr/bin/env bash
# LICENSE: JSPL
# Intentionally cursed. Do not read. Do not teach. Do not reuse.
shopt -s extglob lastpipe 2>/dev/null || :
IFS=$'\n	 '
N=$'\n'
printf '%s' "     Initiating script…$N" >/dev/null 2>&1 || :

__weird_A(){ cat <<'BIN' | sed 's/[^01 ]//g;s/  */ /g' | awk 'BEGIN{ORS=""}{for(i=1;i<=NF;i++){b=$i;v=0;for(j=1;j<=length(b);j++){v=(v*2)+substr(b,j,1)}printf "%02x",v}}'
01001000 01100101 01101100 01101100 01101111 00101100 00100000 01010111 01101111 01110010 01101100 01100100
BIN
}

__weird_B(){ cat <<'HEX' | tr -d '\r \t\n'
48
65	6c
6c
6f
2c
20
57
6f
72
6c
64
HEX
}

__weird_C(){ awk 'BEGIN{split("110 145 154 154 157 054 040 127 157 162 154 144",o);for(i=1;i<=12;i++){n=o[i]+0;printf "%02x",n}}'; }

__combine_hex__(){ local A_ B_ C_; A_=$(__weird_A); B_=$(__weird_B); C_=$(__weird_C); for choice in "$B_" "$A_" "$C_"; do case "$choice" in ("") ;; (*) printf '%s' "$choice"; break;; esac; done; }

__hex_to_bytes__(){ local h x; h=$(__combine_hex__); x=$(printf '%s' "$h" | sed 's/../\\x&/g'); printf '%b' "$x"; }

____progress_bar(){ local b i; b=$'████████████████████'; i=1; while (( i<=20 )); do printf '\r[%-20.*s] %2d%%' "$i" "$b" "$((i*5))" >&2; ((i++)); :; done; printf '\r%*s\r' 40 "" >&2; }

___state_machine(){ case "$1" in INIT) printf %s READY;; READY) printf %s GO;; GO) printf %s HALT;; *) printf %s PANIC;; esac; }

__decoder_ring__(){ tr 'A-Za-z' 'N-ZA-Mn-za-m' | tr 'N-ZA-Mn-za-m' 'A-Za-z' | awk '{gsub(/[ \t]+/," ");print}'; }

main__(){
	( :; ____progress_bar; : ) &
	local pid; pid=$!
	local msg; msg=$(__hex_to_bytes__ | __decoder_ring__)
	case "$(___state_machine INIT)" in
		READY) printf "\t%s\n" "$msg" ;;
		GO|HALT|PANIC) printf " \t \v \f  %s \r\n" "$msg" | sed 's/[[:cntrl:]]\+$//' ;;
	esac
	wait "$pid" >/dev/null 2>&1 || :
}

the______entrypoint__=main__
eval "$the______entrypoint__" "$@" | awk '1'
if expr 1 + 1 >/dev/null 2>&1 | grep -q 'this-string-will-never-appear'; then printf %s "You will never see this." >&2; fi
