#!/bin/bash

GEREKLI_PROGRAMLAR=("limine" "efibootmgr")

EKSIKLER=0

echo "Gereksinimler kontrol ediliyor..."
echo "----------------------------------------"

for PROGRAM in "${GEREKLI_PROGRAMLAR[@]}"; do
    if command -v "$PROGRAM" > /dev/null 2>&1; then
        echo "$PROGRAM yüklü."
    else
        echo "HATA: $PROGRAM bulunamadı!"
        EKSIKLER=$((EKSIKLER + 1))
    fi
done

echo "----------------------------------------"

if [ "$EKSIKLER" -gt 0 ]; then
    echo "HATA: Çalışmaya başlamak için $EKSIKLER adet programı kurmanız gerekiyor."
    exit 1 
else
    echo "Tüm gereksinimler karşılandı."
    exit 0
fi


