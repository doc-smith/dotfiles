#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/common.sh"


stderr "Insalling Miniconda..."

MINICONDA_PATH="${HOME}/miniconda"

if [ ! -e "${MINICONDA_PATH}" ]; then
    MINICONDA_URL=https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    MINICONDA_INSTALLER="${HOME}/miniconda.sh"

    trap "rm -f '${MINICONDA_INSTALLER}'" exit

    stderr "Downloading the installer from ${MINICONDA_URL}..."
    wget "${MINICONDA_URL}" -O "${MINICONDA_INSTALLER}"

    stderr "Executing the installer (${MINICONDA_INSTALLER})..."
    bash "${MINICONDA_INSTALLER}" -b -p "${MINICONDA_PATH}"
else
    stderr "${MINICONDA_PATH} already exists, nothing to install"
fi

stderr "Insalling Miniconda: done"

stderr "Configuring Miniconda..."

"${MINICONDA_PATH}/bin/conda" config --set auto_activate_base false

stderr "Configuring Miniconda: done"
