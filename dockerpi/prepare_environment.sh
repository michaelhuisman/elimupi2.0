#/bin/bash
set -ex

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Clone dockerpi3..."
cd ${SCRIPT_DIR}
git clone https://github.com/jer0enA/dockerpi3.git -b develop

docker-compose -f ${SCRIPT_DIR}/docker-compose.yml build rpi3
