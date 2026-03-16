#!/bin/sh
SCRIPT_DIR="$(realpath "$(dirname "$0")")"
WORKING_DIR="${WORKING_DIR:-$SCRIPT_DIR}"
TAG="${TAG:-v161}"
PORT="${PORT:-8888}"
PROGRAM=notebook

OPTIONS=$(getopt -o hw:t:p:l --long help,dir:,tag:,port:,lab -n "$0" -- "$@")
[ $? != 0 ] && exit 1
eval set -- "$OPTIONS"

while true; do
    case "$1" in
        -h|--help)
            echo "Usage: $0 [-h|--help] [-w|--dir] [-t|--tag] [-p|--port] [-l|--lab]"
            exit 0
            ;;
        -w|--dir)
            WORKING_DIR="$2"
            shift 2
            ;;
        -t|--tag)
            TAG="$2"
            shift 2
            ;;
        -p|--port)
            PORT="$2"
            shift 2
            ;;
        -l|--lab)
            PROGRAM=lab
            TAG=latest
            shift
            ;;
        --) shift; break ;;
        *) break ;;
    esac
done

    #-v $WORKING_DIR/kaggle.json:/root/.config/kaggle/kaggle.json \
exec docker run \
    -v $WORKING_DIR:/tmp/working \
    -w /tmp/working \
    -p "$PORT:$PORT" \
    --rm \
    gcr.io/kaggle-images/python:"$TAG" \
        jupyter $PROGRAM \
        --no-browser \
        --ip="0.0.0.0" \
        --port="$PORT" \
        --notebook-dir=/tmp/working \
        --allow-root
