#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

source "${SCRIPT_DIR}/common.sh"

require_root() {
    if [ "$EUID" -ne 0 ]; then
        die "please run as root"
    fi
}


require_root

AREA=Europe
ZONE=Prague

export LC_ALL=C

ZONEINFO_FILE='/usr/share/zoneinfo/'"${AREA}"'/'"${ZONE}"
ln --force --symbolic "${ZONEINFO_FILE}" "/etc/localtime"
dpkg-reconfigure --frontend=noninteractive tzdata

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
