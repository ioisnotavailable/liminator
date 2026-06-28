#!/bin/bash

create_efi_entry() {
    local disk=$1
    local efi_part=$2

    local part_num=$(echo "$efi_part" | grep -Eo '[0-9]+$')

    if [ -z "$part_num" ]; then
        echo -e "\e[31mHata: Partition numarası tespit edilemedi!\e[0m"
        exit 1
    fi

    echo "efibootmgr ile yeni NVRAM boot girdisi ekleniyor..."
    
    efibootmgr --create \
               --disk "$disk" \
               --part "$part_num" \
               --loader "\\EFI\\limine\\BOOTX64.EFI" \
               --label "Limine Bootloader" \
               --verbose
}
