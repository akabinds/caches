//! LRU cache implementations

const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const page_alloc = std.heap.page_allocator;

/// Provides the base, raw functionality for the different LRU caches.
/// All LRU caches are fixed size.
fn RawLRUCache(comptime K: type, comptime V: anytype) type {
    return struct {
        const EntryNode = struct {
            key: K,
            value: V,
            prev: ?*EntryNode = null,
            next: ?*EntryNode = null,
        };

        const Self = @This();

        store: type = std.AutoHashMap(K, V),
        capacity: usize,
        head: ?*EntryNode = null,
        tail: ?*EntryNode = null,
        allocator: Allocator,

        fn initWithCapacity(capacity: usize, allocator: Allocator) Self {
            assert(capacity > 0);

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

        /// Clear the contents of the cache without freeing the backing allocation.
        fn purgeNoFree(self: *Self) void {}

        /// Clear the contents of the cache and free the backing allocation.
        fn purgeAndFree(self: *Self) void {}

        /// Evict an entry from the cache.
        fn evict(self: *Self) void {}

        /// Evict an entry from the cache and execute the given callback.
        fn evictWithCallback(self: *Self, callback: fn(*K, *V) -> void) void {}
    };
}

/// An in-memory LRU (Least Recently Used) cache.
pub fn LRUCache(comptime K: type, comptime V: anytype) type {
    return RawLRUCache(K, V);
}
