#!/bin/bash


echo "boot partitionunun bulunduğu diskin adını gir."
echo "Örneğin: sda veya nvme0n1"
echo ""
read -p " > "  disk
echo ""
echo ""
echo "boot partitionunun partition numarasını gir."
echo "Örneğin: 1 veya p1"
echo ""
read -p " > " part

echo ""
echo ""
echo ""

#efibootmgr \
#      --create \
#      --disk /dev/$disk \
#      --part $part \
#      --label "Arch Linux Limine Boot Loader" \
#      --loader '\EFI\arch-limine\BOOTX64.EFI' \
#      --unicode

