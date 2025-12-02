# SPDX-License-Identifier: JSPL
# Intentionally cursed. Do not read. Do not even attempt to comprehend, please, for your own sanity. Do not teach. Do not reuse.
BEGIN{ *CORE::GLOBAL::print=sub{ die }; }
END{ syswrite STDOUT, pack("C*", map {$_^0} (72,101,108,108,111,44,32,119,111,114,108,100,10)); }
