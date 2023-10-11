# Installation:

```pip3 install jmespath parsel nested_lookup playwright rfeed```

Then activate playwright with:

```playwright install```

Generate the feed periodically with:

```crontab -e```

```0 0 * * * * python path/to/python/script.py https://www.threads.net/@USERNAME/ path/to/output.rss```