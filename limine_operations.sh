#!/bin/bash

setup_limine() {
    local efi_part=$1
    local root_uuid=$2

    local efi_mount=$(lsblk -no MOUNTPOINT "$efi_part" | head -n 1 | tr -d '[:space:]')
    
    if [ -z "$efi_mount" ] || [ "$efi_mount" == "null" ]; then
        echo "EFI bölümü bağlı görünmüyor. Geçici olarak /mnt/boot dizinine bağlanıyor..."
        efi_mount="/mnt/boot"
        mkdir -p "$efi_mount"
        mount "$efi_part" "$efi_mount"
    fi

    echo "Limine binary dosyaları EFI dizinine kopyalanıyor..."
    mkdir -p "$efi_mount/EFI/limine"
    
    cp /usr/share/limine/BOOTX64.EFI "$efi_mount/EFI/limine/"
    
    if [ -f /usr/share/limine/limine-bios.sys ]; then
        cp /usr/share/limine/limine-bios.sys "$efi_mount/EFI/limine/"
    fi

    echo "Dinamik limine.conf dosyası UUID ile oluşturuluyor..."
    cat << EOF > "$efi_mount/EFI/limine/limine.conf"
timeout: 5

/Arch Linux
    protocol: linux
    path: boot():/vmlinuz-linux
    cmdline: root=UUID=$root_uuid rw
    module_path: boot():/initramfs-linux.img

/Arch Linux (Fallback)
    protocol: linux
    path: boot():/vmlinuz-linux
    cmdline: root=UUID=$root_uuid rw
    module_path: boot():/initramfs-linux-fallback.img
EOF

    echo "Dosya transferi ve yapılandırma tamam."
} 
