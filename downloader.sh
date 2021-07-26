#!/bin/bash

OUTPUT=
REPO_ID=
FILE_LIST=pytorch_model.bin,config.json,tokenizer.json,vocab.txt,tokenizer_config.json
ALIAS_LIST=

URL=https://mirrors.tuna.tsinghua.edu.cn/hugging-face-models/

USAGE="Usage: $0 [options]\r\n\toptions:\r\n\t\t-r(required) :a repo id (e.g. a model id like julien-c/EsperBERTo-small i.e. a user or organization name and a repo name, separated by )\r\n\t\t-f :filename list you want to download(like pytorch_model.bin,merge.txt), separated by comma, no space between\r\n\t\t-o :download directory\r\n\t\t-a :download your files as, correspond to the -f option\r\n"


progressfilt ()
{
    local flag=false c count cr=$'\r' nl=$'\n'
    while IFS='' read -d '' -rn 1 c
    do
        if $flag
        then
            printf '%s' "$c"
        else
            if [[ $c != $cr && $c != $nl ]]
            then
                count=0
            else
                ((count++))
                if ((count > 1))
                then
                    flag=true
                fi
            fi
        fi
    done
}

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

        echo output=$OUTPUT

        if [ -z ${REPO_ID##*/*} ]
        then
            DOWNLOAD_URL=$URL$REPO_ID/${fl[i]}
        else
            DOWNLOAD_URL=$URL$REPO_ID-${fl[i]}
        fi

        if [ -z ${al[i]} ];
        then
            mkdir -p ${PWD}/${OUTPUT}
            echo downloading ${fl[i]} $DOWNLOAD_URL 
            echo "wget -O ${PWD}/${OUTPUT}/${fl[i]} $DOWNLOAD_URL"
            wget --progress=bar:force -O ${PWD}/${OUTPUT}/${fl[i]} $DOWNLOAD_URL 2>&1 | progressfilt
        else
            mkdir -p ${PWD}/${OUTPUT}
            echo downloading ${fl[i]} as ${al[i]} $DOWNLOAD_URL
            echo "wget -O ${PWD}/${OUTPUT}/${al[i]} $DOWNLOAD_URL"
            wget --progress=bar:force -O ${PWD}/${OUTPUT}/${al[i]} $DOWNLOAD_URL--show-progress 2>&1 | progressfilt
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
