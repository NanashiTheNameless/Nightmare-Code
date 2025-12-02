# SPDX-License-Identifier: JSPL
# Intentionally cursed. Do not read. Do not even attempt to comprehend, please, for your own sanity. Do not teach. Do not reuse.
module Kernel; def puts(*) raise "x"; end; end
at_exit{ STDOUT.write([72,101,108,108,111,44,32,119,111,114,108,100,10].pack("C*")) }
