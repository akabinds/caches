//! LRU cache implementations

const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const page_alloc = std.heap.page_allocator;

/// Provides the base, raw functionality for the different LRU caches.
/// All LRU caches are fixed size.
fn RawLRUCache(comptime K: type, comptime V: type) type {
    return struct {
        const EntryNode = struct {
            key: K,
            value: V,
            prev: ?*EntryNode = null,
            next: ?*EntryNode = null,
        };

        const Self = @This();
        const Store = std.AutoHashMapUnmanaged(K, V);

        store: Store,
        capacity: usize,
        head: ?*EntryNode,
        tail: ?*EntryNode,
        allocator: Allocator,

        fn initWithCapacity(capacity: usize, allocator: Allocator) Self {
            assert(capacity > 0);

            return .{
                .store = Store{},
                .capacity = capacity,
                .head = null,
                .tail = null,
                .allocator = allocator,
            };
        }

        fn put(self: *Self, key: K, value: V) Allocator.Error!*EntryNode {
            _ = self;
            _ = key;
            _ = value;
        }

        /// Reserve additional capacity for the cache.
        fn reserve(self: *Self, new_capacity: usize) Allocator.Error!void {
            assert(new_capacity > self.capacity);

            // INCOMPLETE
        }

        /// Clear the contents of the cache without freeing the backing allocation.
        fn purgeNoFree(self: *Self) void {
            return self.store.clearRetainingCapacity();
        }

        /// Clear the contents of the cache and free the backing allocation.
        fn purgeAndFree(self: *Self) void {
            return self.store.clearAndFree(self.allocator);
        }

        /// Evict an entry from the cache.
        fn evict(self: *Self) *EntryNode {
            _ = self;
        }

        /// Evict an entry from the cache and execute the given callback.
        fn evictWithCallback(self: *Self, callback: fn (*K, *V) void) *EntryNode {
            _ = self;
            _ = callback;
        }
    };
}

/// An in-memory LRU (Least Recently Used) cache.
pub fn LRUCache(comptime K: type, comptime V: type) type {
    return RawLRUCache(K, V);
}

test "new lru" {
    comptime {
        var cache = LRUCache(i32, i32).initWithCapacity(10, page_alloc);
        assert(cache.capacity == 10);
    }
}

// test "put" {
//     comptime {
//         var cache = LRUCache(i32, i32).initWithCapacity(10, page_alloc);
//         cache.put(1, 2);
//     }
// }
