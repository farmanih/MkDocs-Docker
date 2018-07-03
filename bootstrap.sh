#!/bin/bash
set -eu

check_install_status () {
    if [[ ! -e /mkdocs ]]; then 
        mkdir -p /mkdocs
    fi
    cd /mkdocs
    if [[ ! -e "mkdocs.yml" ]]; then
    echo "No previous config. Starting fresh instalation"
    mkdocs new .
    fi
}

start_mkdocs () {
    cd /mkdocs
    echo "Starting MKDocs"
    mkdocs serve -a 0.0.0.0:80
}

get_docs () {
    if [[ ! -e /mkdocs ]]; then 
        echo "Downloading documentation from Git Repository"
        git clone ${GIT_REPO} /mkdocs
    fi
}

if [ ${GIT_REPO} != 'false' ]; then
    get_docs
    start_mkdocs
else
    check_install_status
    start_mkdocs
fi
