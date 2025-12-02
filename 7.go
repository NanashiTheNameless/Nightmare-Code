// SPDX-License-Identifier: JSPL
// Intentionally cursed. Do not read. Do not even attempt to comprehend, please, for your own sanity. Do not teach. Do not reuse.
package main

import (
	"os"
	"sync/atomic"
)

var d int32

func main() {
	defer func() {
		if atomic.SwapInt32(&d, 1) == 1 {
			return
		}
		os.Stdout.Write([]byte{72, 101, 108, 108, 111, 44, 32, 119, 111, 114, 108, 100, 10})
	}()
	select {}
}
