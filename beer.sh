#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <state>"
    exit 1
fi

if ! grep -q "$1" states
then
    echo "Error: Unknown state, please provide the full state name and not the abbreviation. Also make sure you quote names with spaces."
    exit 1
fi

mkdir -p "archive/$1"

FILE="archive/$1/$(date +%Y%m%d).csv"
LAST="archive/$1/$(ls "archive/$1" | sort -nr | head -1)"

curl --silent --data "action=get_breweries&search_by=statename&_id=$1" "https://www.brewersassociation.org/wp-admin/admin-ajax.php" | ./extract.php > "$FILE"

if [ -n "$LAST" -a "$LAST" != "$FILE" ]
then
    if cmp -s "$LAST" "$FILE"
    then
        echo "no change since $LAST"
        rm "$FILE"
    else
        diff -u "$LAST" "$FILE"
    fi
fi
