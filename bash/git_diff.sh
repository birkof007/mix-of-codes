#/bin/bash
#Vypise pouze zmeny s radky zacinajici na + a - s mezerou nebo tabulátorem pro specifikovaný soubor
#Vstup je ve formátu: git_diff.sh <from> <to> <file_of_interest> <output>

from=$1
to=$2
file_of_interest=$3
output=$4

git diff --no-color ${from} ${to} ${file_of_interest} | grep -E '^\+[[:space:]]|^\-[[:space:]]' > ${output}
echo "Hotovo"
