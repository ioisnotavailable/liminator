#!/bin/bash

echo "
boot partitionunun bulunduğu diskin adını gir.
Örneğin: sda veya nvme0n1
"
read -p " > "  disk
echo "

boot partitionunun partition numarasını gir.
Örneğin: 1 veya p1
"
read -p " > " part

echo "


"
#efibootmgr \
#      --create \
#      --disk /dev/$disk \
#      --part $part \
#      --label "Arch Linux Limine Boot Loader" \
#      --loader '\EFI\arch-limine\BOOTX64.EFI' \
#      --unicode



echo "İşlem tamamlandı."
