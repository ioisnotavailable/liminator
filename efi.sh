#!/bin/bash


echo "boot partitionunun bulunduğu diskin adını gir."
echo "Örneğin: sd veya nvme0n1"
echo ""
read disk
echo ""
echo ""
echo "boot partitionunun partition numarasını gir."
echo "Örneğin: a veya p1"
echo ""
read part

echo ""
echo ""
echo ""



#mkdir -p /boot/EFI/arch-limine
#cp /usr/share/limine/BOOTX64.EFI /boot/EFI/arch-limine/

#efibootmgr \
#      --create \
#      --disk /dev/$disk \
#      --part $part \
#      --label "Arch Linux Limine Boot Loader" \
#      --loader '\EFI\arch-limine\BOOTX64.EFI' \
#      --unicode

