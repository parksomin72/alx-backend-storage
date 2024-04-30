#!/usr/bin/env python3
"""
Cache module for storing and retrieving data from Redis
"""
import redis
from typing import Callable

class Cache:
    def __init__(self):
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data):
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key):
        return self._redis.get(key)

def replay(method: Callable):
    inputs_key = f"{method.__qualname__}:inputs"
    outputs_key = f"{method.__qualname__}:outputs"
    inputs = cache._redis.lrange(inputs_key, 0, -1)
    outputs = cache._redis.lrange(outputs_key, 0, -1)

    print(f"{method.__qualname__} was called {len(inputs)} times:")
    for input_args, output in zip(inputs, outputs):
        print(f"{method.__qualname__}(*{input_args.decode('utf-8')}) -> {output.decode('utf-8')}")

# Test your implementation
if __name__ == "__main__":
    cache = Cache()

    cache.store("foo")
    cache.store("bar")
    cache.store(42)

    replay(cache.store)
