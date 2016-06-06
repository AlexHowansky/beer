#!/bin/bash

if [ ${#} -ne 1 ]
then
    echo "Usage: ${0} <country>"
    exit 1
fi

if ! grep -q "^${1}$" countries
then
    echo "Error: Unknown country. If the country name has spaces, make sure you"
    echo "       quote the paramter. See the countries file for a complete list."
    echo
    echo "Examples: ${0} France"
    echo "          ${0} \"Czech Republic\""
    exit 1
fi

COUNTRY=$(echo ${1} | sed 's/ /_/g')

mkdir -p "archive/${COUNTRY}"

FILE="archive/${COUNTRY}/${COUNTRY}_$(date +%Y%m%d).csv"
LAST="archive/${COUNTRY}/$(ls "archive/${COUNTRY}" | sort -nr | head -1)"

curl --silent --data "action=get_breweries&search_by=country&_id=${1}" "https://www.brewersassociation.org/wp-admin/admin-ajax.php" | ./extract.php > "${FILE}"

if [ "${LAST}" != "archive/${COUNTRY}/" -a "${LAST}" != "${FILE}" ]
then
    if cmp -s "${LAST}" "${FILE}"
    then
        echo "no change since ${LAST}"
        rm "${FILE}"
    else
        diff -u "${LAST}" "${FILE}"
    fi
fi
