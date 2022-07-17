const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const page_alloc = std.heap.page_allocator;

fn RawCache(comptime K: type, comptime V: anytype) type {
    return struct {
        const Node = struct {
            key: K,
            value: V,
            prev: ?*Node = null,
            next: ?*Node = null,
        };

        const Self = @This();

        store: type = std.AutoHashMap(K, V),
        capacity: usize,
        head: ?*Node = null,
        tail: ?*Node = null,
        allocator: Allocator,

        fn init(allocator: Allocator) Self {
            return Self{
                .store = std.AutoHashMap(K, V),
                .capacity = 0,
                .head = null,
                .tail = null,
                .allocator = allocator,
            };
        }

        fn initWithCapacity(capacity: usize, allocator: Allocator) Self {
            return Self{
                .store = std.AutoHashMap(K, V),
                .capacity = capacity,
                .head = null,
                .tail = null,
                .allocator = allocator,
            };
        }

        /// Reserve additional capacity for the cache.
        fn reserve(self: *Self, new_capacity: usize) Allocator.Error!void {
            assert(new_capacity > self.capacity);

            // INCOMPLETE
        }
    };
}

pub fn LRUCache(comptime K: type, comptime V: anytype) type {
    return RawCache(K, V);
}

// incomplete
test "new lru" {
    comptime {
        var cache = LRUCache(i32, i32).initWithCapacity(10, page_alloc);
        assert(cache.capacity == 10);
    }
}
