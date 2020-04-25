#!/bin/bash
CONTAINER_ID=""
CONTAINER_NAME=""

PROG_NAME=$(basename $0)

function usage_exit {
  cat <<_EOS_ 1>&2
  Usage: $PROG_NAME [OPTIONS...]
  OPTIONS:
    -h, --help                      このヘルプを表示
    -i, --id                        コンテナのIDを指定
    -n, --name NAME                 コンテナの名前を指定
_EOS_
    exit 1
}

while (( $# > 0 )); do
    if [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
        usage_exit
    elif [[ $1 == "--id" ]] || [[ $1 == "-i" ]]; then
        if [[ $2 == -* ]]; then
            echo "無効なパラメータ"
            usage_exit
        else
            CONTAINER_ID=$2
        fi
        shift 2
    elif [[ $1 == "--name" ]] || [[ $1 == "-n" ]]; then
        if [[ $2 == -* ]] || [[ $2 == *- ]]; then
            echo "無効なパラメータ： $1 $2"
            usage_exit
        fi
        CONTAINER_NAME=$2
        shift 2
    else
        echo "無効なパラメータ： $1"
        usage_exit
    fi
done

if [[ -n ${CONTAINER_ID} ]]; then
    CONTAINER_ID=$(docker ps | grep ${CONTAINER_ID})
else
    CONTAINER_ID=$(docker ps | grep "jetson/ros:melodic-desktop-full")

    if [[ -n ${CONTAINER_NAME} ]]; then
        CONTAINER_ID=$(echo "${CONTAINER_ID}" | grep ${CONTAINER_NAME})
    fi
fi

CONTAINER_NUMS=$(echo "${CONTAINER_ID}" | wc -l)

if [[ ${CONTAINER_NUMS} -eq 0 ]]; then
    echo "起動中のROS-Bridgeコンテナが存在しません．"
    usage_exit
elif [[ ${CONTAINER_NUMS} -ne 1 ]]; then
    echo "起動しているROS-Bridgeコンテナが複数存在します．"
    echo ""
    docker ps
    echo ""
    echo "オプションを付けてください．"
    usage_exit
fi

CONTAINER_ID=${CONTAINER_ID:0:12}

docker exec -it ${CONTAINER_ID} /bin/bash
