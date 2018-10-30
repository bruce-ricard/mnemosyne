#!/bin/bash

set -e

while read line; do
    ENDPOINT=`echo $line | cut -d',' -f1`
    COUNTRY=`echo $line | cut -d',' -f2`

    curl "http://flagpedia.net/${ENDPOINT}" > "${COUNTRY}.html"
    curl $(grep 'Flag of' "${COUNTRY}.html" | grep srcset | head -1 | sed 's/.*src="\/\/\(.*.png\).*/\1/') > "images/${COUNTRY}.png"
    rm -f "${COUNTRY}.html"
done < countries.txt
