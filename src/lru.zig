const std = @import("std");
const raw = @import("raw.zig");

pub fn LRUCache(comptime K: type, comptime V: type) type {
    return raw.RawCache(K, V);
}

// incomplete
// test "new lru" {
//     comptime {
//         var cache = LRUCache(i32, i32).with_capacity(10);
//         std.debug.print(cache);
//     }
// }
