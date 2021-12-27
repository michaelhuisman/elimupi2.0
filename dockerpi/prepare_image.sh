#/bin/bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
MOUNT_DIR="/tmp/mount_tmp_image"
INPUT_IMAGE=$1
OUTPUT_IMAGE=${SCRIPT_DIR}/images/prepared/filesystem.img


if [[ -d ${INPUT_IMAGE} ]]; then
    echo "${INPUT_IMAGE} is a directory"
    exit 1
elif [[ -f ${INPUT_IMAGE} ]]; then
    echo "${INPUT_IMAGE} is a file"
else
    echo "Not a valid image is provided as first argument"
    exit 1
fi

echo "First stop any running Pi"
docker-compose -f ${SCRIPT_DIR}/docker-compose.yml down -v

echo "Copy ${INPUT_IMAGE} to ${OUTPUT_IMAGE}" 
cp ${INPUT_IMAGE} ${OUTPUT_IMAGE}

echo "Enable ssh for image"
mkdir -p ${MOUNT_DIR}
offset=$(file ${INPUT_IMAGE} | cut -d ";" -f 2 | grep -oP '(?<=startsector )(.*)(?=, [0-9].*)')
sudo mount ${OUTPUT_IMAGE} -o offset=$[512*${offset}] ${MOUNT_DIR}
sudo touch ${MOUNT_DIR}/ssh
sudo umount ${MOUNT_DIR}

echo "Resize the image to 6GB"
# qemu-img resize ${OUTPUT_IMAGE} 6G

echo "Remove ssh fingerprints from ~/.ssh/known_hosts, if exists."
ssh-keygen -f ~/.ssh/known_hosts -R [127.0.0.1]:5022