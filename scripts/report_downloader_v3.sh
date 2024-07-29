#!/bin/bash

REPORT_URL=${1}
BASE_URL=${REPORT_URL%%/ingest*}
NUMBER_PAGES=${2}
CSRF_TOKEN=${3}
SESSION_ID=${4}

echo "File Name,File Format,Preservation Normalization Attempted,Preservation Normalization Failed,Preservation Conformance Check,Already in Preservation Format,Access Normalization Attempted,Access Normalization Failed,Already in Access Format,Access Conformance Check"

for i in {1..10000000}; do
    if [[ ${i} -gt ${NUMBER_PAGES} ]]; then
        break;
    fi

    if [[ ${i} -eq 1 ]]; then
        curl "${REPORT_URL}" -X 'GET' -H "Cookie: ${CSRF_TOKEN}; ${SESSION_ID}" > /tmp/0.1.html
    else
        curl "${REPORT_URL}${i}/" -X 'GET' -H "Cookie: ${CSRF_TOKEN}; ${SESSION_ID}" > /tmp/0.1.html
    fi

    tr -d '\n' < /tmp/0.1.html > /tmp/1.html

    table_rows=$(xmllint --html --xpath '//table[@class="table"]/tbody/tr' /tmp/1.html)

    while read -r row; do
        # These have href's that we do not need
        file_name=$(echo "$row" | xmllint --html --xpath './/td[1]/descendant::*/text() | .//td[1]/text()' - | tr '\n' ' ' | tr -d '[:blank:]')
        file_format=$(echo "$row" | xmllint --html --xpath './/td[2]/descendant::*/text() | .//td[2]/text()' - | tr '\n' ' ' | tr -d '[:blank:]')

        # All the ones that have possible hrefs
        preservation_attempted=$(echo "$row" | xmllint --html --xpath './/td[3]/descendant::*/text() | .//td[3]/text()' - | tr '\n' ' ' | tr -d '[:blank:]')
        preservation_attempted_link="$(echo "$row" | xmllint --html --xpath './/td[3]/a/@href' - 2> /dev/null | tr -d '[:blank:]')"

        if [[ $preservation_attempted_link != "" ]]; then
            preservation_attempted_link=" \"${BASE_URL}${preservation_attempted_link#href=\"}"
        fi

        preservation_failed=$(echo "$row" | xmllint --html --xpath './/td[4]/descendant::*/text() | .//td[4]/text()' - | tr '\n' ' ' | tr -d '[:blank:]')
        preservation_failed_link="$(echo "$row" | xmllint --html --xpath './/td[4]/a/@href' - 2> /dev/null | tr -d '[:blank:]')"

        if [[ $preservation_failed_link != "" ]]; then
            preservation_failed_link=" \"${BASE_URL}${preservation_failed_link#href=\"}"
        fi

        preservation_conformance=$(echo "$row" | xmllint --html --xpath './/td[5]/descendant::*/text() | .//td[5]/text()' - | tr '\n' ' ' | tr -d '[:blank:]')
        preservation_conformance_link="$(echo "$row" | xmllint --html --xpath './/td[5]/a/@href' - 2> /dev/null | tr -d '[:blank:]')"

        if [[ $preservation_conformance_link != "" ]]; then
            preservation_conformance_link=" \"${BASE_URL}${preservation_conformance_link#href=\"}"
        fi

        already_in_preservation=$(echo "$row" | xmllint --html --xpath './/td[6]/descendant::*/text() | .//td[6]/text()' - | tr '\n' ' ' | tr -d '[:blank:]')
        already_in_preservation_link="$(echo "$row" | xmllint --html --xpath './/td[6]/a/@href' - 2> /dev/null | tr -d '[:blank:]')"

        if [[ $already_in_preservation_link != "" ]]; then
            already_in_preservation_link=" \"${BASE_URL}${already_in_preservation_link#href=\"}"
        fi

        access_attempted=$(echo "$row" | xmllint --html --xpath './/td[7]/descendant::*/text() | .//td[7]/text()' - | tr '\n' ' ' | tr -d '[:blank:]')
        access_attempted_link="$(echo "$row" | xmllint --html --xpath './/td[7]/a/@href' - 2> /dev/null | tr -d '[:blank:]')"

        if [[ $access_attempted_link != "" ]]; then
            access_attempted_link=" \"${BASE_URL}${access_attempted_link#href=\"}"
        fi

        access_failed=$(echo "$row" | xmllint --html --xpath './/td[8]/descendant::*/text() | .//td[8]/text()' - | tr '\n' ' ' | tr -d '[:blank:]')
        access_failed_link="$(echo "$row" | xmllint --html --xpath './/td[8]/a/@href' - 2> /dev/null | tr -d '[:blank:]')"

        if [[ $access_failed_link != "" ]]; then
            access_failed_link=" \"${BASE_URL}${access_failed_link#href=\"}"
        fi

        already_in_access=$(echo "$row" | xmllint --html --xpath './/td[9]/descendant::*/text() | .//td[9]/text()' - | tr '\n' ' ' | tr -d '[:blank:]')
        already_in_access_link="$(echo "$row" | xmllint --html --xpath './/td[9]/a/@href' - 2> /dev/null | tr -d '[:blank:]')"

        if [[ $already_in_access_link != "" ]]; then
            already_in_access_link=" \"${BASE_URL}${already_in_access_link#href=\"}"
        fi

        access_conformance=$(echo "$row" | xmllint --html --xpath './/td[10]/descendant::*/text() | .//td[10]/text()' - | tr '\n' ' ' | tr -d '[:blank:]')
        access_conformance_link="$(echo "$row" | xmllint --html --xpath './/td[10]/a/@href' - 2> /dev/null | tr -d '[:blank:]')"

        if [[ $access_conformance_link != "" ]]; then
            access_conformance_link=" \"${BASE_URL}${access_conformance_link#href=\"}"
        fi

        # Print the extracted data (you can modify this to save to a file or process further)
        echo "$file_name,$file_format,${preservation_attempted}${preservation_attempted_link},${preservation_failed}${preservation_failed_link},${preservation_conformance}${preservation_conformance_link},${already_in_preservation}${already_in_preservation_link},${access_attempted}${access_attempted_link},${access_failed}${access_failed_link},${already_in_access}${already_in_access_link},${access_conformance}${access_conformance_link}"
    done <<< "$table_rows"
done
