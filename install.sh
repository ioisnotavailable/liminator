#!/bin/bash

echo "	 	 
┌──────────────────────────┐
│▌  ▗     ▗       ▐        │
│▌  ▄ ▛▚▀▖▄ ▛▀▖▝▀▖▜▀ ▞▀▖▙▀▖│
│▌  ▐ ▌▐ ▌▐ ▌ ▌▞▀▌▐ ▖▌ ▌▌  │
│▀▀▘▀▘▘▝ ▘▀▘▘ ▘▝▀▘ ▀ ▝▀ ▘  │
└──────────────────────────┘
"

echo "Merhaba.
Limine Yapılandırma Programına hoşgeldin.
Çalışan sistemlerde yanlışlıkla çalıştırılıp sisteme zarar 
vermemesi için komutlar yorum satırına alınarak kapatıldı.
Programın çalışabilmesi için efibootmgr_operations.sh ve 
limine_operations.sh dosyalarında bulunan '#' karakterlerini sil.
(İlk satırda bulunanlar hariç.)


"
read -p "Gerekli düzenlemeleri yaptın mı? (e/h): " cevap

if [ "$cevap" == "e" ]; then
	echo ""
elif [ "$cevap" == "h" ]; then
    echo "İşlem iptal edildi."
    exit 0 
else
    echo "Geçersiz bir tuşa bastın. Lütfen sadece 'e' veya 'h' gir."
    exit 1 
fi


./dependency_check.sh

if [ $? -eq 0 ]; then
	echo ""
else
	exit 1
fi


echo "

'/' (root) klasörünün partition yolunu gir.!
Örneğin /dev/sda1

"
read -p " > " disk
echo "
"

PARTUUID=$(blkid -s PARTUUID -o value ${disk})


if [ $? -eq 0 ]; then
	./limine_operatiions.sh $PARTUUID
	./efibootmgr_operations.sh
else
    	echo "Uygun partition yolu gir.!
Örneğin  /dev/sda1"
	exit 1
fi
