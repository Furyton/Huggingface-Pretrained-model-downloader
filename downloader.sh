#!/bin/bash

OUTPUT=
REPO_ID=
FILE_LIST=pytorch_model.bin
ALIAS_LIST=

URL=https://mirrors.tuna.tsinghua.edu.cn/hugging-face-models/

USAGE="Usage: $0 [options]\r\n\toptions:\r\n\t\t-r(required) :a repo id (e.g. a model id like julien-c/EsperBERTo-small i.e. a user or organization name and a repo name, separated by )\r\n\t\t-f(required) :filename list you want to download(like pytorch_model.bin,merge.txt), separated by comma, no space between\r\n\t\t-o :download directory\r\n\t\t-a :download your files as, correspond to the -f option\r\n"

function do_wget() {
    IFS=','
    read -ra fl <<< "$FILE_LIST"
    read -ra al <<< "$ALIAS_LIST"

    for ((i=0;i<${#fl[@]};i++)); do
        if [ -z ${fl[i]} ] || [ -z $REPO_ID ];
        then
            continue;
        fi
       	
        # expr index $REPO_ID "/"
	
        if [ -z $OUTPUT ];
        then
            OUTPUT=$REPO_ID
        fi 

        if [ -z ${REPO_ID##*/*} ]
        then
            DOWNLOAD_URL=$URL$REPO_ID/${fl[i]}
        else
            DOWNLOAD_URL=$URL$REPO_ID-${fl[i]}
        fi

        if [ -z ${al[i]} ];
        then
            echo downloading ${fl[i]} $DOWNLOAD_URL 
            wget -P $OUTPUT $DOWNLOAD_URL 
        else
            echo downloading ${fl[i]} as ${al[i]} $DOWNLOAD_URL
            wget -P $OUTPUT -O ${al[i]} $DOWNLOAD_URL
        fi
        #wget $URL/$REPO_ID/$i -o $OUTPUT
    done
    IFS=' '
}


while getopts ":o:r:f:a:h" option;
do
    case $option in
        o)
            OUTPUT=$OPTARG
            ;;
        r)
            REPO_ID=$OPTARG
            ;;
        f)
            FILE_LIST=$OPTARG
            ;;
        a)
            ALIAS_LIST=$OPTARG
            ;;
        h)
            printf "$USAGE"
            exit 0
            ;;
        [?])
            print >&2 $USAGE
            exit 1
            ;;
        *)
            echo "invalid option $OPTARG" 
            ;;
    esac
done

do_wget
