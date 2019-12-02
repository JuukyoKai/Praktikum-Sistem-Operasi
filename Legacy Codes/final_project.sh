#!/bin/bash

index_usr=1;
temp_index=1;
loop=1;
loop1=1;
loop2=1;
loop_main=1;
loop_menu=1;
check=0;
max=0;
usr_control=2;

declare -a usr;
declare -a pass;
declare -a authority;
#user authority
# 0 - Super_User
# 1 - Administrator
# 2 - Regular

#declaring super user
usr[0]="root";
pass[0]="121332";
authority[0]=0;

change_control(){
	loop1=1;
	while [[ $loop1 == 1 ]]; do
		echo "masukkan user control type : "
		echo "1. Administrator"
		echo "2. Regular"
		read temp_auth;
		if [[ $temp_auth == 1 ]]; then
			authority[$1]=1;
			let loop1=0;
		elif [[ $temp_auth == 2 ]]; then
			authority[$1]=2;
			let loop1=0;
		fi
	done
}

sign_up(){
	clear
	echo "----------------Sign Up----------------"
	let loop=1;												#inisialisasi loop
	while [[ $loop -eq 1 ]]; do
		read -p "Masukkan username 	: " temp_usr;			#input username
		let max=$index_usr-1;
		for (( i = 0; i < $index_usr; i++ )); do
			if [[ $temp_usr == ${usr[$i]} ]]; then			#cek apabila username telah terpakai atau belum
				echo "Username telah terpakai";
				read 
				clear
			elif [[ $i == $max ]]; then
				#statements
				let loop=0;
				break;
			fi	
		done
	done
	let loop=1;												#inisialisasi loop
	while [[ $loop -eq 1 ]]; do
		read -sp "Masukkan Password	: " temp_pass1;			#input Password
		let check=0;										#inisialisiasi flag untuk cek password
		let max=$index_usr-1;
		for (( i = 0; i < $index_usr; i++ )); do
			if [[ ${pass[$i]} == $temp_pass1 ]]; then
				echo "break";
				break;
			elif [[ $i == $max ]]; then
				echo "Sudah Oke!!";
				let check=1;
				break;
			fi	
		done											#spacing
		read -sp "Masukkan kembali Password : " temp_pass2;
		if [[ $temp_pass1 == $temp_pass2 ]]; then
			if [[ $check == 0 ]]; then
				echo "Password sudah terdaftar oleh username lain";
			else
				echo "Okeysip"
				usr[$index_usr]=$temp_usr;
				pass[$index_usr]=$temp_pass1;
				change_control $index_usr
				let index_usr=$index_usr+1;
				let loop=0;
			fi

		else
			echo "Password yang anda masukkan tidak sesuai"
		fi

	done
}

login(){
	let loop=1;
	
	while [[ $loop == 1 ]]; do
		clear
		echo "-----------Login--------------"
		read -p "Masukkan username 	: " temp_usr;
		read -sp "Password 		: " temp_pass;	
		let max=$index_usr-1;
		echo "$max";
		for (( i = 0; i < $index_usr ; i++ )); do
			if [[ $temp_usr == ${usr[$i]} ]]; then
				if [[ $temp_pass == ${pass[$i]} ]]; then
					clear
					echo "Login Berhasil !!";
					echo "Selamat datang ${usr[$i]}!! - A${authority[$i]} -I$i";
					let temp_index=$i;
					let usr_control=${authority[$i]};
					let loop=0;
					break;
				elif [[ $i == $max ]]; then
					echo "Maaf Password salah!"
					echo "Silakan Login Kembali"
				fi
			elif [[ $i == $max ]]; then
				echo "Maaf user tidak terdaftar!"
				echo "Silakan Login Kembali"
			fi	
		done
		read 
	done
}

check(){	#input usrname $1 => temp_usr
	let check=0;
	if [[ $1 == "root" ]]; then
		echo "super user tidak dapat diganti"
		read
	elif [[ $index_usr == 1 ]]; then
		echo "belum ada user yang tersedia"
		read
	else
		for (( i = 0; i < $index_usr; i++ )); do
			if [[ $1 == ${usr[$i]} ]]; then
				let temp_index=$i;
				let check=1;
				break;
			fi
		done
	fi
	
}

view(){
	echo "_____________________________"
	for (( i = 0; i < $index_usr; i++ )); do
		if [[ ${authority[$i]} == 0 ]]; then
			echo "(super-user)	|   *********"	
		else
			echo "${usr[$i]}	|	${pass[$i]}"
		fi
	done
	read
}

change_pass(){
	let loop=1;												#inisialisasi loop
	while [[ $loop -eq 1 ]]; do
		read -sp "Masukkan Password	: " temp_pass1;			#input Password
		let check=0;										#inisialisiasi flag untuk cek password
		let max=$index_usr-1;
		for (( i = 0; i < $index_usr; i++ )); do
			if [[ ${pass[$i]} == $temp_pass1 ]]; then
				echo "break";
				break;
			elif [[ $i == $max ]]; then
				echo "Sudah Oke!!";
				let check=1;
				break;
			fi	
		done											#spacing
		read -sp "Masukkan kembali Password : " temp_pass2;
		if [[ $temp_pass1 == $temp_pass2 ]]; then
			if [[ $check == 0 ]]; then
				echo "Password sudah terdaftar oleh username lain";
			else
				echo "Okeysip"
				pass[$temp_index]=$temp_pass1;
				let loop=0;
				echo "Password berhasil diganti ! :D"
				read 
			fi

		else
			echo "Password yang anda masukkan tidak sesuai"
		fi

	done
}

menu(){
	loop_menu=1;
	while [[ $loop_menu == 1 ]]; do
		clear
		if [[ $usr_control == 0 ]]; then
			echo "System Administration"
			echo "0. Change User Account control"
			echo "1. Change Password "
			echo "2. View all user"
			echo "3. Log Out"
			read temp_case;
		elif [[ $usr_control == 1 ]]; then
			echo "System Administration"
			echo "1. Change Username / Password "
			echo "2. View all user"
			echo "3. Exit"
			read temp_case;
		elif [[ $usr_control == 2 ]]; then
			echo "System Administration"
			echo "1. View all user"
			echo "2. Exit"
			read temp_case;
			let temp_case=$temp_case+1;
			
		fi

		case "$temp_case" in
			"0" )
				read -p "Masukkan username user yang ingin diganti : " temp_change;
				check $temp_change
				if [[ $check == 1 ]]; then
					change_control $temp_index
				else 
					echo "User tidak ditemukan"
				fi			
				;;
			"1" )
				read -p "Masukkan username user yang ingin diganti : " temp_change;
				check $temp_change
				if [[ $check == 1 ]]; then
					change_pass
				fi
				;;
			"2" )
				view
				;;
			"3" )
			let loop_menu=0
				;;
		esac
	done
}


let loop_main=1;
while [[ $loop_main == 1 ]]; do
	clear
	read -p "apakah anda adalah user terdaftar ? (1. Yes/ 2. No) Press q to quit" prep;
	if [[ $prep == 1 ]]; then
		login
		menu
	elif [[ $prep == 2 ]]; then
		sign_up
		login
		menu
	else
		let loop_main=0;
	fi


done
