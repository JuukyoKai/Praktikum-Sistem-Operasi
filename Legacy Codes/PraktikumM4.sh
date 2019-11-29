#!/bin/bash

loop=1;

echo "1. Menu Kalkulator loop";
echo "2. Exit";
read loop;

while [[ loop -eq 1 ]]; do
	echo "masukkan Inputan bilangan acuan : ";
	read acuan;
	echo "Masukkan Batasan loop : ";
	read batas;

	a=1
	echo "Penjumalahan";
	while [[ $a -le $batas ]]; do
		echo ""$acuan" + "$a" = "$((acuan+a));
		a=$((a+1));
	done
	b=1
	echo "Pengurangan";
	while [[ $b -le $batas ]]; do
		echo ""$acuan" - "$b" = "$((acuan-b));
		b=$((b+1));
	done
	c=1
	echo "Pembagian";
	while [[ $c -le $batas ]]; do
		echo ""$acuan" / "$c" = "$((acuan/c));
		c=$((c+1));
	done
	d=1
	echo "Perkalian"
	while [[ $d -le $batas ]]; do
		echo ""$acuan" x "$d" = "$((acuan*d));
		d=$((d+1));
	done

	echo "1. Menu Kalkulator loop";
	echo "2. Exit";
	read loop;

done

