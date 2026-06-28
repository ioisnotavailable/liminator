#!/bin/bash

check_dependencies() {
    echo "Bağımlılıklar kontrol ediliyor..."
    local dependencies=("limine" "efibootmgr" "blkid")
    local missing_deps=()

    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo -e "\e[33mEksik bağımlılıklar tespit edildi: ${missing_deps[*]}\e[0m"
        read -p "Eksik paketler otomatik olarak kurulsun mu? (e/H): " ins_choice
        if [[ "$ins_choice" =~ ^[Ee]$ ]]; then
            pacman -Sy --noconfirm "${missing_deps[@]}"
        else
            echo -e "\e[31mHata: Gerekli paketler olmadan kuruluma devam edilemez.\e[0m"
            exit 1
        fi
    fi
    echo -e "\e[32mTüm bağımlılıklar hazır.\e[0m"
}
