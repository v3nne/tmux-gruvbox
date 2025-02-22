#!/bin/bash

if [ "$(uname)" = "Darwin" ]; then
  top -l 1 | awk -F'[,:%]' '/CPU usage/ {usage = 100 - $6; printf "%.0f%%", usage}'
else
  top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf("%d%%", 100 - $1)}'
fi

