#!/bin/bash

# If $RMCFG exist, then use the environment variable.
# If $RMCFG does not exist, $HOME/.rm.cfg will be used.
# If neither exist, the recycle bin is in the default location:  $HOME/deleted.
if [ $RMCFG ] ; then
    recyclepath=$RMCFG
elif [ -e $HOME/.rm.cfg  ] ; then
    eval recyclepath=$(head -1 $HOME/.rm.cfg)
else
    recyclepath=$HOME/deleted
fi

file=$1
matchentry=$(cat $HOME/.restore.info |grep -w ^$1)

# the original address of the file
fileOrig=$(echo -n $matchentry | cut -d":" -f2)

writeFile() {
    originalDir=$(dirname $fileOrig)
    if [ ! -d $originalDir ] ; then
        mkdir -p $originalDir
    fi
    mv -f $recyclepath/$file $fileOrig
    grep -v $matchentry $HOME/.restore.info > $HOME/.RMtemp
    mv -f $HOME/.RMtemp $HOME/.restore.info
}

selectCase() {
    case $response in
        y) writeFile ;;
        yes)writeFile;;
        n) exit ;;
        no) exit ;;
        *) "Error: Invalid response!" exit ;;
    esac
}

convertToLower() {
    response=$(echo $response | tr [:upper:] [:lower:])
}

# If the file does not exist in the recycle bin, your script should produce an error.
if [ ! $matchentry ] ; then
    echo "Error: The file $file does not exist!"
else
    # If the file already exists in the target directory, your script should prompt "Do you want to overwrite?"i
    if [ -e $fileOrig ] ; then
        echo "Do you want to overwrite? $fileOrig"
        echo "If no, then the file name $file will be used instead of the original name."
        read -p "[Y/n] " response
        convertToLower
        selectCase
    else
        writeFile
    fi
fi
