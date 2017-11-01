#!/bin/bash
VERSION="1.0.0"

while [ "$1" != "" ]; do
    case $1 in
        -f | --file )           shift
                                filename=$1
                                ;;
        -H | --host )           shift
                                host=$1
                                ;;
        -v | --version )        echo "Version: $VERSION"
                                exit
                                ;;
        -h | --help ) 
            printf "\n"
            echo "Usage: my_test [OPTIONS]"
            echo "OPTION includes:"
            echo "     -f | --file -sets the .ssh config file if you have placed it 
            anywhere than $HOME/.ssh/config"
            echo "     -v | --version - prints out version information for this script"
            echo "     -H | --host - prints options from specific host"
            echo "     -h | --help - displays this message"
            printf "\n"
            exit
            ;;
        * ) 
            printf "\n"
            echo "Invalid option: $1"
            echo "Usage: sshInfo [OPTIONS]"
            echo "     -f | --file -sets the .ssh config file if you have placed it 
            anywhere than $HOME/.ssh/config"
            echo "     -v | --version - prints out version information for this script"
            echo "     -H | --host - prints options from specific host"
            echo "     -h | --help - displays this message"
            printf "\n"
            exit
            ;;
    esac
    shift
done


# set the location of the config file if not passed in, try default location
if [ "${filename}" != "" ] ; then
    file=${filename}
else
    file="$HOME/.ssh/config"
fi


# read in the file
increment=0

while IFS= read -r line
do
    # ignore all commented lines
    if [[ $line = \#* ]] ; then
        filler="gone"
    else
        # Read in line
        arrLine=(${line//;/ })

        # set the Options = to array at index of counter
        arrayOptions[$increment]=${arrLine[0]}
        arrayValues[$increment]=${arrLine[1]}

    fi
    # increase counter
    increment=$((increment+1))
done <"$file"


# print first bar
printf "\n"
echo '--------------------------------------------'

# if someone specified a host name, only print that out, otherwise, print them all out.
if [ "${host}" != "" ] ; then
    increment=0

    # loop through array and find the Host specified
    for i in "${!arrayValues[@]}"; do
        if [[ "${arrayValues[$increment]}" == "${host}" ]]; then
            while :; do
                # print out this option of the Host that was wanted
                printf "%-25s %s \n" "${arrayOptions[$increment]}" "${arrayValues[$increment]}"
                increment=$((increment+1))

                if [ "${arrayOptions[$increment]}" == "Host" ]; then

                    echo '--------------------------------------------'
                    printf "\n"
                    break
                fi
            done
        fi
        increment=$((increment+1))
    done

else
    # loop through all configh file and print out options
    for i in "${!arrayOptions[@]}"; do
        printf "%-25s %s \n" "${arrayOptions[$i]}" "${arrayValues[$i]}"

        if [ ${arrayOptions[$i]} == "IdentityFile" ] || [ ${arrayValues[$i]} == "password" ] ; then
            echo '--------------------------------------------'
        fi 
    done
    printf "\n"
fi







