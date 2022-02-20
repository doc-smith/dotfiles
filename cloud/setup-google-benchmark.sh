#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

source "${SCRIPT_DIR}/common.sh"

require_sudo() {
    if ! sudo -n true; then
        die "you need sudo to run this script"
    fi
}


require_sudo

WORK_DIR="$(mktemp -d -p "${SCRIPT_DIR}")"
cleanup() {
    rm -rf "${WORK_DIR}"
}
trap cleanup EXIT

git clone https://github.com/google/benchmark.git "${WORK_DIR}"
cd "${WORK_DIR}"
cmake -E make_directory "build"
cmake -E chdir "build" cmake -DBENCHMARK_DOWNLOAD_DEPENDENCIES=on -DCMAKE_BUILD_TYPE=Release ../
cmake --build "build" --config Release
sudo cmake --build "build" --config Release --target install