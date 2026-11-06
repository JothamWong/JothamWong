#!/bin/bash
# These commands are meant to be copied from this file and ran in shell directly
# Quick kernel setup
cp -v /boot/config-$(uname -r) .config
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
scripts/config --set-str SYSTEM_TRUSTED_KEYS ""
scripts/config --set-str SYSTEM_REVOCATION_KEYS ""
scripts/config --set-str MODULE_SIG_KEY ""
make olddefconfig
make -j$(nproc)
sudo make INSTALL_MOD_STRIP=1 modules_install
sudo make install
sudo vi /etc/default/grub
sudo update-grub
sudo reboot