#!/usr/bin/env bash

set -euo pipefail

ENVRIONMENT_NAME=science
PYTHON_VERSION=3.8

DEFAULT_PACKAGES=(
    numpy
    matplotlib
    notebook
)


stderr() {
    echo "$@" 1>&2;
}


die() {
    stderr "$@"
    exit 1
}


if conda info -e | grep "${ENVRIONMENT_NAME}"; then
    die "the environment ${ENVRIONMENT_NAME} already exists"
else
    conda create \
        --yes \
        --name "${ENVRIONMENT_NAME}" \
        python="${PYTHON_VERSION}" \
        "${DEFAULT_PACKAGES[@]}"
fi

