#!/bin/bash

if [ ${#} -ne 1 ]
then
    echo "Usage: ${0} <state>"
    exit 1
fi

if ! grep -q "${1}" states
then
    echo "Error: Unknown state, please provide the full state name and not the abbreviation. Also make sure you quote names with spaces."
    exit 1
fi

STATE=$(echo ${1} | sed 's/ /_/g')

mkdir -p "archive/${STATE}"

FILE="archive/${STATE}/${STATE}_$(date +%Y%m%d).csv"
LAST="archive/${STATE}/$(ls "archive/${STATE}" | sort -nr | head -1)"

curl --silent --data "action=get_breweries&search_by=statename&_id=${1}" "https://www.brewersassociation.org/wp-admin/admin-ajax.php" | ./extract.php > "${FILE}"

if [ -n "${LAST}" -a "${LAST}" != "${FILE}" ]
then
    if cmp -s "${LAST}" "${FILE}"
    then
        echo "no change since ${LAST}"
        rm "${FILE}"
    else
        diff -u "${LAST}" "${FILE}"
    fi
fi
