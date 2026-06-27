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

#mkdir -p /boot/EFI/arch-limine
#cp /usr/share/limine/BOOTX64.EFI /boot/EFI/arch-limine/


if [ $? -eq 0 ]; then
	echo "BOOTX64.EFI dosyası başarıyla kopyalandı"
	exit 0
else
    	echo "BOOTX64.EFT dosyasının kopyalanmasına bir hata meydana geldi."
	exit 1
fi



