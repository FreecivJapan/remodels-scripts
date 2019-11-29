#!/usr/bin/sh


# files or directories to copy
TO_COPY=(akasaba akasaba.serv teiki teiki.serv newteiki newteiki.serv)


# Freeciv's data directory of Linux
FREECIVS_DATA_DIRECTORY=/usr/local/share/freeciv/


# freeciv-scripts/scripts/files
BASE_DIR=$(dirname "$0")



# make symlinks

for file in ${TO_COPY[@]}
do
  echo "copy $file to $FREECIVS_DATA_DIRECTORY"
  cp -rf $file $FREECIVS_DATA_DIRECTORY
done

