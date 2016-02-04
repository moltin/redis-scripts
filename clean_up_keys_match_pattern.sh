#!/bin/bash
echo "Cleanup KEYS that match a specific PATTERN, SCAN & DEL"
if [ $# -ne 4 ]
then
  echo "Error: You have done something completely wrong!"
  echo "Usage: $0 <host> <port> <pattern> <count>"
  exit 1
fi

response=$(redis-cli -h $1 -p $2 EVAL "$(cat ./lua/scan_match_count_keys.lua)" 0 $3 $4)

cursor=$(expr "$response" : '\([0-9]*[0-9 ]\)')
echo "Cursor: $cursor"

keys=$(echo $response | awk '{for (i=2; i<=NF && i > 0; i++) print $i}')

if [ -n "$keys" ]
then
  keya=( $keys )
  count=$(echo ${#keya[@]})
  redis-cli -h $1 -p $2 EVAL "$(cat ./lua/del_keys.lua)" $count $keys
  exit 1
fi

echo "Error: No KEYS that match that PATTER have been found"
