#!/bin/bash

if [ "$(uname)" = "Darwin" ]; then
  # Get total physical memory in bytes
    total=$(sysctl -n hw.memsize)
    # Get the page size in bytes
    pagesize=$(sysctl -n hw.pagesize)
    # Get the number of free pages (strip the trailing dot)
    free_pages=$(vm_stat | grep "Pages free:" | awk '{print $3}' | tr -d '.')
    # Calculate free memory in bytes
    free_bytes=$(( free_pages * pagesize ))
    # Used memory is total minus free
    used_bytes=$(( total - free_bytes ))
    # Calculate the percentage of used memory
    printf "%d%%" $(( used_bytes * 100 / total ))
else
  free | awk '/Mem:/ {printf("%d%%", $3/$2 * 100)}'
fi

