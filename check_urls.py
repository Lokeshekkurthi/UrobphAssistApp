import os
import django
from django.urls import get_resolver

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'urobph_backend.settings')
django.setup()

def show_urls(resolver, prefix=''):
    for pattern in resolver.url_patterns:
        pattern_str = ""
        if hasattr(pattern, 'pattern'):
            if hasattr(pattern.pattern, '_route'):
                pattern_str = pattern.pattern._route
            else:
                pattern_str = str(pattern.pattern)
        
        if hasattr(pattern, 'url_patterns'):
            show_urls(pattern, prefix + pattern_str)
        else:
            print(f"{prefix}{pattern_str}")

print("Current URL Patterns:")
show_urls(get_resolver())
