#!/bin/bash

ROOT_PARTUUID=$1 
echo "Limine konfigürasyonu oluşturuluyor..."

#cat <<EOF > /boot/limine.conf
#timeout: 5

#/Arch Linux
#    protocol: linux
#    path: boot():/vmlinuz-linux
#    module_path: boot():/initramfs-linux.img
#    cmdline: root=PARTUUID=${ROOT_PARTUUID} rw
#EOF

echo "Konfigürasyon başarıyla yazıldı!"
