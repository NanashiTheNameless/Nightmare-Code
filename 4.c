// SPDX-License-Identifier: JSPL
// Intentionally cursed. Do not read. Do not even attempt to comprehend, please, for your own sanity. Do not teach. Do not reuse.
#define _GNU_SOURCE
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdint.h>

static int K=-1; static volatile int D=0;
__attribute__((constructor)) static void I(void){
    K=dup(1); int z=open("/dev/null",O_WRONLY); if(z!=-1) dup2(z,1);
    atexit( (void(*)(void)) (uintptr_t) ({
        static void *_[1]; _[0]=(void*)({
            static void F(void){
                if(__sync_lock_test_and_set(&D,1)) return;
                if(K!=-1) dup2(K,1);
                unsigned x[]={0x48454C4C,0x4F2C2057,0x4F524C44,0x0A};
                char s[13]; for(int i=0,j=0;i<3;i++){ uint32_t v=x[i]; s[j++]=(v>>24)&255; s[j++]=(v>>16)&255; s[j++]=(v>>8)&255; s[j++]=v&255; }
                s[12]='\n'; write(1,s,sizeof s);
            }
            F;
        });
        _[0];
    }) );
}
int main(){ for(volatile int i=0;i<1;i++); }
