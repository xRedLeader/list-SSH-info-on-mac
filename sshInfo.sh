#!/bin/bash
file="$HOME/.ssh/config"
increment=0
while IFS= read -r line
do
	if [[ $line = \#* ]] ; then
    	filler="gone"
    else
    	#need to do values
    	#echo "okay"
    	arrLine=(${line//;/ })
    	#echo ${arrLine[1]}
    	arrayOptions[$increment]=${arrLine[0]}
    	arrayValues[$increment]=${arrLine[1]}
    	#echo ${array[0]}
	fi
	increment=$((increment+1))
done <"$file"

printf "\n"
echo '--------------------------------------------'

for i in "${!arrayOptions[@]}"; do
	printf "%-25s %s \n" "${arrayOptions[$i]}" "${arrayValues[$i]}"

	if [[ ${arrayOptions[$i]} == "IdentityFile"* ]] ; then
		echo '--------------------------------------------'
	fi 
done
printf "\n"
