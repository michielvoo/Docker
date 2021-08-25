#!/bin/sh
case $1 in
    docs)
        echo "docs"
        ;;
    test)
        docker run --rm -it -v $PWD:/root/work pester -Output Detailed
        ;;
    version)
        docker run --rm -it az -Version
        docker run --rm -it --entrypoint git az --version
        ;;
esac