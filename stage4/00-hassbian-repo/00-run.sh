#!/bin/bash -e

install -m 644 files/hassbian.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"

#on_chroot apt-key add - < files/hassbian.gpg.key

on_chroot << EOF
apt update
EOF
