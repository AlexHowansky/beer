#!/bin/bash

while read STATE
do
    echo -n "$STATE... "
    ./beer.sh "$STATE"
    echo done
done < states
