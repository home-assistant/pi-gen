#!/bin/bash -e

on_chroot << EOF
groupadd -f -r -g 1001 homeassistant
useradd -u 1001 -g 1001 -rm homeassistant
EOF

install -v -o 1001 -g 1001 -d ${ROOTFS_DIR}/srv/homeassistant

on_chroot << \EOF
apt install -f hassbian-scripts
EOF

on_chroot << EOF
systemctl enable install_homeassistant
EOF

on_chroot << EOF
sed -i 's/PrintMotd no/PrintMotd yes/' /etc/ssh/sshd_config
rm /etc/update-motd.d/10-uname
rm /etc/motd
EOF

on_chroot << \EOF
for GRP in dialout gpio i2c input netdev spi video; do
        adduser homeassistant $GRP
done
for GRP in homeassistant; do
  adduser pi $GRP
done
EOF

