# How to develop locally on a virtual Pi

## Requirements:

You need to have the following tools installed:
- docker
- ansible
- qemu-img

## how to start the virtual Pi
Execute the following steps from a Linux system (This can also be WSL2 on Windows 10/11).

- checkout this repository and go to root directory of this repository.
- Download the image for raspios. For example from this url:
    https://downloads.raspberrypi.org/raspios_armhf/images/raspios_armhf-2021-05-28/2021-05-07-raspios-buster-armhf.zip
- Move the image to the folder `dockerpi/images`.
- go the folder `dockerpi`.
- run `./prepare_image.sh <image_path>` for example `./prepare_image.sh images/2021-05-07-raspios-buster-armhf.img`
  This will prepare the image to be ready for dockerpi.
- Then run `docker-compose up` to start dockerpi.
  This should start the virtual Pi. When you see the following output:
  ```
  Raspbian GNU/Linux 10 raspberrypi ttyAMA0
  ```

  you should be able to ssh into the virtual Pi by executing `ssh pi@localhost -p 5022` then provide the default raspbian password `raspberry`.

## Run the Ansible code on the virtual Pi

To run the Ansible code go to the directory `ansible` in the root folder of this repository.
Then run the command `ansible-playbook --inventory dockerpi.yml site.yml`, this should run the Ansible playbooks.

