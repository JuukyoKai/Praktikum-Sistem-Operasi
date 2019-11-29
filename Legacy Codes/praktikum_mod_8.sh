#!/bin/bash
#script by Juukyo npm 1

IP=0;
jumlah=0;
loop=1;
index_mhs=0;
index_mk1=0;
index_mk2=0;

declare -a nilai
declare -a mk1
declare -a mk2
declare -a ip
declare -a npm

while [[ loop -eq 1 ]]; do
	echo "Menu Program Praktikum : ";
	echo "1. Input data mahasiswa";
	echo "2. input data nilai mata kuliah";
	echo "3. view data mahasiswa dan nilai";
	echo "4. view data mahasiswa dengan IP";
	echo "5. Keluar Program";
	read temp;

	case "$temp" in
		"1" )
		echo "Input Npm mahasiswa";
		read npm[$index_mhs];
		let index_mhs=$index_mhs+1;
			;;
		"2" )
		echo "Nilai Sisop : "
		read mk1[$index_mk1];
		let index_mk1=$index_mk1+1;
		
		echo "Nilai Metnum : "
		read mk2[$index_mk2];
		let index_mk2=$index_mk2+1;
			;;
		"3" )
		for (( i = 0; i < $index_mhs; i++ )); do
			echo "NPM : ${npm[$i]}";
			echo "Nilai sisop : ${mk1[$i]}";
			echo "Nilai metnum : ${mk2[$i]}";
			echo ""
		done
			;;
		"4" )
		for (( i = 0; i < $index_mhs; i++ )); do
			if [[ $index_mk1 -eq 0 ]]; then
				echo "data invalid"
			else
				let jumlah=${mk1[$i]}+${mk2[$i]};
				let IP=$jumlah/2;
			
				echo "NPM : ${npm[$i]}";
				echo "IP : $IP";	
			fi
			
		done
			;;
		"5" )
		let loop=2;
			;;
	esac

done