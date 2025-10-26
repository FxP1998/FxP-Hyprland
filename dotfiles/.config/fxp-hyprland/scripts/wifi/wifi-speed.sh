#!/bin/bash

INTERFACE="wlo1"
SLEEP=1

get_bytes() {
  cat /sys/class/net/$INTERFACE/statistics/$1
}

RX_PREV=$(get_bytes rx_bytes)
TX_PREV=$(get_bytes tx_bytes)

while true; do
  sleep $SLEEP
  RX_CUR=$(get_bytes rx_bytes)
  TX_CUR=$(get_bytes tx_bytes)

  RX_RATE=$(( (RX_CUR - RX_PREV) / SLEEP ))
  TX_RATE=$(( (TX_CUR - TX_PREV) / SLEEP ))

  RX_PREV=$RX_CUR
  TX_PREV=$TX_CUR

  # Convert bytes/s to human-readable
  human() {
    local bytes=$1
    if (( bytes > 1048576 )); then
      echo "$(bc <<< "scale=1; $bytes/1048576") MB/s"
    elif (( bytes > 1024 )); then
      echo "$(bc <<< "scale=1; $bytes/1024") KB/s"
    else
      echo "$bytes B/s"
    fi
  }

  RX_HR=$(human $RX_RATE)
  TX_HR=$(human $TX_RATE)

  echo "↓ $RX_HR ↑ $TX_HR"
done

