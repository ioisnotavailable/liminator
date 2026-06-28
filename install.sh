#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]; then
    echo -e "\e[31mHata: Lütfen bu scripti root yetkisiyle (sudo) çalıştırın.\e[0m"
    exit 1
fi

if [ ! -d /sys/firmware/efi ]; then
    echo -e "\e[31mHata: Sistem UEFI modunda boot edilmemiş! Bu script yalnızca UEFI sistemler içindir.\e[0m"
    exit 1
fi

source ./dependency_check.sh
source ./efibootmgr_operations.sh
source ./limine_operations.sh

echo -e "\e[34m=== Limine Bootloader Otomatik Kurulum Scripti ===\e[0m"

check_dependencies

echo -e "\n\e[32mMevcut diskler ve bölümler:\e[0m"
lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT

echo -e "\nLütfen boot yükleyicisinin kurulacağı ana diski seçin:"
disks=($(lsblk -dno NAME))
select disk in "${disks[@]}"; do
    if [ -n "$disk" ]; then
        TARGET_DISK="/dev/$disk"
        break
    else
        echo "Geçersiz seçim, lütfen tekrar deneyin."
    fi
done

echo -e "\nLütfen Kök (/) partition yolunu seçin:"
partitions=($(lsblk -plno NAME))
select part in "${partitions[@]}"; do
    if [ -n "$part" ]; then
        ROOT_PART="$part"
        break
    else
        echo "Geçersiz seçim."
    fi
done

echo -e "\nLütfen EFI (ESP) partition yolunu seçin (Örn: /boot veya /boot/efi dizininin bağlı olduğu bölüm):"
select esp_part in "${partitions[@]}"; do
    if [ -n "$esp_part" ]; then
        EFI_PART="$esp_part"
        break
    else
        echo "Geçersiz seçim."
    fi
done

ROOT_UUID=$(blkid -s UUID -o value "$ROOT_PART")
if [ -z "$ROOT_UUID" ]; then
    echo -e "\e[31mHata: Kök dizinin UUID değeri alınamadı!\e[0m"
    exit 1
fi

echo -e "\n\e[33m--- YAPILANDIRMA ÖZETİ ---\e[0m"
echo "Hedef Disk:      $TARGET_DISK"
echo "Kök Bölümü:      $ROOT_PART (UUID: $ROOT_UUID)"
echo "EFI Bölümü:      $EFI_PART"
echo -e "\e[33m--------------------------\e[0m"
read -p "Bu ayarlarla diske yazma işlemine devam edilsin mi? (e/H): " confirm

if [[ ! "$confirm" =~ ^[Ee]$ ]]; then
    echo "İşlem kullanıcı tarafından iptal edildi."
    exit 0
fi

setup_limine "$EFI_PART" "$ROOT_UUID"
create_efi_entry "$TARGET_DISK" "$EFI_PART"

echo -e "\n\e[32m[ BAŞARILI ] Limine Bootloader kurulumu tamamlandı!\e[0m"
