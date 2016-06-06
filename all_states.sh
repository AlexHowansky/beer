#!/bin/bash

while read STATE
do
    echo -n "$STATE... "
    ./state.sh "$STATE" >/dev/null
    echo done
done < states
