#!/bin/bash

while read COUNTRY
do
    echo -n "$COUNTRY... "
    ./country.sh "$COUNTRY" >/dev/null
    echo done
done < countries
