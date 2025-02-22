#!/bin/bash
# get_weather.sh

cache_file="/tmp/tmux_weather_cache"
cache_duration=500  # ~8.33 minutes

# Check if cache exists and is recent enough.
if [ -f "$cache_file" ]; then
  last_update=$(stat -c %Y "$cache_file")
  now=$(date +%s)
  diff=$(( now - last_update ))
  if [ $diff -lt $cache_duration ]; then
    cat "$cache_file"
    exit 0
  fi
fi

location="$(curl -s ipinfo.io | jq -r '.city')"
temp="$(curl -s "wttr.in/${location}?format=%t" | sed 's/C//')"

# Update cache and output data
echo "$temp" > "$cache_file"
echo "$temp"

