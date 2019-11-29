#1/bin/bash

loop=1;
declare -a array1;
declare -a array2;
declare -a jumlah;
declare -a kali;

while [[ $loop -eq 1 ]]; do

	echo "Menu Program Praktikum : ";
	echo "1. Input Matriks 2 dimensi";
	echo "2. Output Penjumlahan matriks";
	echo "3. Output Perkalian Matriks";
	echo "Keluar Program";
	read case;
		
	case "$case" in #Input matriks
		"1" )
		 echo "Input matriks 1 :"
		 for (( i = 0; i < 4; i++ )); do
		 	read array1[i];
		 done
		 echo "Input matriks 2 :"
		 for (( i = 0; i < 4; i++ )); do
		 	read array2[i];
		 done
			;;
		"2" ) #jumlah dua matriks
		 for (( i = 0; i < 4; i++ )); do
				jumlah[$i]=$(array1[$i])+$(array2[$i]);
	 	 done
	 	 echo "Output penjumlahan matriks adalah : ";
	 	 for (( i = 0; i < 4; i++ )); do
	 	 	if [[ $i -eq 1 ]]; then
	 	 		echo "$jumlah[$i]";
	 	 	fi
	 	 done
		 
		 echo "$(jumlah[2]) $(jumlah[3])";
			;;
		#"3" ) #kali 2 matriks
		#	for (( i = 0; i < 4; i++ )); do
		#		for (( j = 0; i < 2; i++ )); do
		#			if [[ j -eq 1 | j -eq 3 ]]; then
		#				let kali[i]=$kali[i]+$(array1[i]*array2[j]
		#			fi
		#			
		#		done
		#	done
		#	
		#	echo "Output perklaian 2 matriks";
		#	::
		"4" )
		let loop=2;
			::
	esac
done


