#!/usr/bin/sh



### locale and time

export LANG=ja_JP.UTF-8
THE_DATE=$(date +'%Y-%m-%d_%H-%M-%S')



### tautology

SCRIPT_PATH=$(realpath $0)
BASE_DIR=$(dirname $SCRIPT_PATH)


SERV_FILE=$BASE_DIR/makisaba.serv


SAVES_DIR=$BASE_DIR/data/saves
THIS_SAVE_DIR=$SAVES_DIR/$THE_DATE
mkdir $THIS_SAVE_DIR

    

### generate serv file

echo -e "\n\n---\ngenerate freeciv server(.serv) file..."

echo -n > $SERV_FILE


server_configs=(
    "/cmdlevel ctrl first"
    "/cmdlevel basic new"

    "/metamessage makisabaの公開鯖です。"

    "/set autosave INTERRUPT|TURN|GAMEOVER|QUITIDLE"
    "/set saveturns 10"

    "/set savename makisaba"
    "/set scorelog enabled"
    "/set scorefile Score.log"     # muddy: "/set scorefile ${THIS_SAVE_DIR}/Score.log" too long. instead, move file when server end

    )

for config in "${server_configs[@]}"; do
    echo $config >> $SERV_FILE
    echo $config
done




### start freeciv server

echo -e "\n\n---\nexecute game..."


freeciv-server \
    --port 5556 \
    --exit-on-end \
    --log Log.txt \
    --read $SERV_FILE \
    --saves $THIS_SAVE_DIR \
    $* \


### save datas whether game played.

echo -e "\n\n---\nsave and ending server..."

if [ "$(ls -A $THIS_SAVE_DIR)" ]; then
    mv Score.log $THIS_SAVE_DIR
    mv Log.txt $THIS_SAVE_DIR
    echo -e "game has played.\ndatas are saved to $THS_SAVE_DIR"
else
    rm -rf $THIS_SAVE_DIR
    rm -f Score.log
    rm -f Log.txt
    echo -e "game has not played.\n$THIS_SAVE_DIR was Empty because. also files removed."
fi


