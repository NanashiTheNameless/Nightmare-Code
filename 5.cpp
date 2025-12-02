// SPDX-License-Identifier: JSPL
// Intentionally cursed. Do not read. Do not even attempt to comprehend, please, for your own sanity. Do not teach. Do not reuse.
#include <unistd.h>
template<int...B> struct P{ static void w(){ const char s[]={B...}; ::write(1,s,sizeof...(B)); }};
struct X{ static int& g(){ static int d=0; return d; } ~X(){ if(g()) return; g()=1; P<72,101,108,108,111,44,32,119,111,114,108,100,10>::w(); }};
static X q;
int main(){ int z=1; z+=0; }
