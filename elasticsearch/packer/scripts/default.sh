#!/bin/bash -ex

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install htop dstat -y

echo "elasticsearch soft nofile 128000\n
elasticsearch hard nofile 128000\n
root soft nofile 128000\n
root hard nofile 128000" | sudo tee --append /etc/security/limits.conf

echo "fs.file-max = 500000" | sudo tee --append /etc/sysctl.conf

# move udev rules and related scripts to the proper place
sudo mv /tmp/ebsnvme-id /sbin
sudo mv /tmp/ec2udev-vbd /sbin
sudo chown root:root /sbin/ebsnvme-id /sbin/ec2udev-vbd
sudo chmod u+x /sbin/ebsnvme-id /sbin/ec2udev-vbd
sudo chmod go-rwx /sbin/ebsnvme-id /sbin/ec2udev-vbd
sudo mv /tmp/10-aws.rules /etc/udev/rules.d
