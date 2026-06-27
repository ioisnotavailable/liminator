#!/bin/bash

echo "Merhaba."
echo "Limine Yapılandırma Programına hoşgeldin."
echo ""
echo ""
echo "  '/' (root) klasörünün partition yolunu gir.!"
echo "  Örneğin /dev/sda1"
echo ""
read disk
echo ""


PARTUUID=$(blkid -s PARTUUID -o value ${disk})


if [ $? -eq 0 ]; then
	./kur.sh $PARTUUID
	./efi.sh
else
    	echo "Uygun partition yolu girin.!"
	echo "ÖRN: /dev/sda1"
fi
