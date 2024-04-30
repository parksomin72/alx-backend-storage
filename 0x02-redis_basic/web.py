#!/usr/bin/env python3
"""
Web cache and tracker using Redis
"""
import requests
import redis
import time

# Initialize Redis client
redis_client = redis.Redis()

def get_page(url: str) -> str:
    # Track URL access count
    count_key = f"count:{url}"
    redis_client.incr(count_key)

    # Check if HTML content is cached
    cached_content = redis_client.get(url)
    if cached_content:
        return cached_content.decode('utf-8')

    # Fetch HTML content from the URL
    response = requests.get(url)
    html_content = response.text

    # Cache HTML content with expiration time of 10 seconds
    redis_client.setex(url, 10, html_content)

    return html_content

if __name__ == "__main__":
    # Example usage
    url = "http://slowwly.robertomurray.co.uk"
    html = get_page(url)
    print(html)
