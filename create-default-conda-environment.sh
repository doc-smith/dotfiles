#!/usr/bin/env bash

set -euo pipefail

ENVRIONMENT_NAME=science
PYTHON_VERSION=3.8

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


stderr() {
    echo "$@" 1>&2;
}


die() {
    stderr "$@"
    exit 1
}


if conda info -e | grep "${ENVRIONMENT_NAME}"; then
    die "the environment ${ENVRIONMENT_NAME} already exists"
fi

ENVIRONMENT_FILE="$(mktemp "${TMPDIR}/$(uuidgen).yml")"
trap 'rm -f "${ENVIRONMENT_FILE}"' EXIT

cat << EOF > "${ENVIRONMENT_FILE}"
name: ${ENVRIONMENT_NAME}
channels:
  - conda-forge
dependencies:
- python=${PYTHON_VERSION}
- pandas
- scikit-learn
- matplotlib
- notebook
EOF

conda env create -f "${ENVIRONMENT_FILE}"

