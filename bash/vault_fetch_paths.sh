#!/bin/sh
#################################################################################################
# You need to be loged into Hashi Corp Vault CLI
# Script will iterrate throught Vault secrets saved in KV engine
# Found path are saved into paths.txt
# tmp.txt, tmp_buff.txt are something like arrays, which are not supported in Bourn Shell
# Script is not optimized, but is working :)
# If you asked your self why Bourn Shell is used, so it is becouse Vault Docker Container
# use Alpine Linux in BussyBox without Bash
#################################################################################################

###init part
rm tmp.txt 2>/dev/null
rm paths.txt 2>/dev/null
rm tmp_buff 2>/dev/null
echo "kv/" > tmp.txt
touch tmp_buff.txt
touch paths.txt
### eof init

while true; do ################# while 1
        while read -r kv_path; do ################# while 2
        if [ $kv_path != "" ]; then
                echo "-- getting values for kv_path ::: $kv_path :::"
                res=$(vault kv list -format=json $kv_path | awk 'NR>1 {print $1}' | tr -d '"[],')
                IFS="$IFS"
                IFS="
                "
                for line in $res; do
                  linesh="${line: -1}" #get last char
                  full_path=$kv_path$line #prepair full secret path
                  if [ $linesh != "/" ]; then
                    echo "-- adding ::: $full_path ::: into paths.txt :)"
                    echo $full_path >> paths.txt
                  elif [ $linesh != "" ]; then
                    echo "-- adding ::: $full_path ::: into tmp_buff.txt"
                    echo "$full_path" >> tmp_buff.txt
                  fi
                done
                IFS="$oIFS"
        else
          echo "-- kv_path is empty. Continuing."
        fi

        done < "tmp.txt"  ########################### EOF while 2

        if [ ! -s "tmp_buff.txt" ]; then
         echo "-- tmp_buff.txt is empty file. Ending script"
          break
        else
          rm -v -f tmp.txt
          mv -v tmp_buff.txt tmp.txt
          touch tmp_buff.txt
        fi

done ########################### EOF while 1

echo "=============== Found paths in paths.txt ==============="
cat paths.txt
