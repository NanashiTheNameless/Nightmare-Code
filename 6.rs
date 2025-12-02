// SPDX-License-Identifier: JSPL
// Intentionally cursed. Do not read. Do not even attempt to comprehend, please, for your own sanity. Do not teach. Do not reuse.
use std::{os::fd::AsRawFd, sync::atomic::{AtomicBool, Ordering}};
struct G; static ONCE:AtomicBool=AtomicBool::new(false);
impl Drop for G{ fn drop(&mut self){ if ONCE.swap(true,Ordering::SeqCst){return;} unsafe{ libc::write(std::io::stdout().as_raw_fd(), [72u8,101,108,108,111,44,32,119,111,114,108,100,10].as_ptr() as _, 13); } } }
fn main(){ let _g=G; std::panic::set_hook(Box::new(|_|{})); }
