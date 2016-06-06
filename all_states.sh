#!/bin/bash

while read STATE
do
    echo -n "$STATE... "
    ./state.sh "$STATE"
    echo done
done < states
