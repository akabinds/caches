const std = @import("std");
const mem = std.mem;

pub fn RawCache(comptime K: type, comptime V: type) type {
    return struct {
        const Node = struct {
            key: K,
            value: V,
            prev: ?*Node = null,
            next: ?*Node = null,
        };

        const Self = @This();

        store: std.AutoHashMap(K, V),
        capacity: usize,
        head: ?*Node = null,
        tail: ?*Node = null,
        _alloc: *mem.Allocator,

        /// Create a new cache with the given capacity.
        pub fn with_capacity(cap: usize) Self {
            return Self{
                .store = std.AutoHashMap(K, V),
                .capacity = cap,
                .head = null,
                .tail = null,
                ._alloc = @as(*mem.Allocator, mem.Allocator.new()),
            };
        }

        pub fn capacity(self: *const Self) usize {
            return self.capacity;
        }

        pub fn store_size(self: *const Self) usize {
            return self.store.size();
        }
    };
}
