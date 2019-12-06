#!/bin/bash

index_usr=1;
temp_index=1;
loop=1;
loop1=1;
loop2=1;
loop_main=1;
loop_main1=1;
loop_menu=1;
check=0;
max=0;
usr_control=2;

declare -a usr;
declare -a pass;
declare -a authority;
declare -a status;
declare -a temp_real;

#user authority
# 0 - Super_User
# 1 - Administrator
# 2 - Regular

#declaring super user
usr[0]="root";
pass[0]="121332";
authority[0]=0;
status[0]=1;

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
	let loop=1;												#inisialisasi loop
	while [[ $loop -eq 1 ]]; do
		echo "----------------Sign Up----------------"
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
		clear
		echo "----------------Sign Up----------------"
		echo "Masukkan username 	: $temp_usr";
		read -sp "Masukkan Password	: " temp_pass1;			#input Password
		let check=0;										#inisialisiasi flag untuk cek password
		let max=$index_usr-1;
		for (( i = 0; i < $index_usr; i++ )); do
			if [[ ${pass[$i]} == $temp_pass1 ]]; then
				echo "sudah terpakai :P";
				break;
			elif [[ $i == $max ]]; then
				echo "Sudah Oke!!";
				let check=1;
				break;
			fi	
		done											#spacing
		if [[ $check != 0 ]]; then
			read -sp "Masukkan kembali Password : " temp_pass2;
			if [[ $temp_pass1 == $temp_pass2 ]]; then
				echo "Okeysip"
				usr[$index_usr]=$temp_usr;
				pass[$index_usr]=$temp_pass1;
				status[$index_usr]=1;
				change_control $index_usr
				let index_usr=$index_usr+1;
				let loop=0;
			else
				read -p "Password yang anda masukkan tidak sesuai"
			fi
		else
			read -p "Password sudah terdaftar oleh username lain";
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
				if [[ ${status[$i]} != 0 ]]; then
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
				else
					echo "User Tidak Tersedia"
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
				if [[ ${status[$i]} != 0 ]]; then
					let temp_index=$i;
					let check=1;
					break;
				fi
			fi
		done
	fi
	
}

view(){
	echo "_____________________________"
	for (( i = 0; i < $index_usr; i++ )); do
		if [[ ${authority[$i]} == 0 ]]; then
			echo "(super-user)	   *********"	
		elif [[ ${status[$i]} != 0 ]]; then
			echo "${usr[$i]}		${pass[$i]}"
		fi
	done
	read
}

change_pass(){
	let loop=1;												#inisialisasi loop
	while [[ $loop == 1 ]]; do
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

delete(){
	loop1=1;
	while [[ $loop1 == 1 ]]; do
		read -sp "Masukkan password account : " temp_pass
		if [[ $temp_pass == ${pass[$temp_index]} ]]; then
			read -p "apakah anda yakin (y/n) " temp_des;
			if [[ $temp_des == "Y" || $temp_des == "y" ]]; then
				let status[$temp_index]="Deactivated";
				echo "Account berhasil dihapus!";
				let loop1=0;
				read
			elif [[ $temp_des == "N" || $temp_des == "n" ]]; then
				let status[$temp_index]="Activated";
				let loop1=0;
			else
				echo "Input tidak sesuai silakan input ulang!!"
			fi
		elif [[ $temp_pass == "q" || $temp_pass ]]; then
			let loop1=0;
		else
			echo "Maaf password tidak sesuai"
		fi
	done
}

menu_kw(){
	loop_menu=1;
	while [[ $loop_menu == 1 ]]; do
		clear
		if [[ $usr_control == 0 ]]; then
			echo "System Administration"
			echo "0. Change User Account control"
			echo "1. Delete account"
			echo "2. Change Password "
			echo "3. View all user"
			echo "4. Log Out"
			read temp_case;
		elif [[ $usr_control == 1 ]]; then
			echo "System Administration"
			echo "1. Change Password"
			echo "2. View all user"
			echo "3. Exit"
			read temp_case;
			let temp_case=$temp_case+1;
		elif [[ $usr_control == 2 ]]; then
			echo "System Administration"
			echo "1. View all user"
			echo "2. Exit"
			read temp_case;
			let temp_case=$temp_case+2;
			
		fi

		case "$temp_case" in
			"0" )
				read -p "Masukkan username account yang ingin diganti : " temp_change;
				check $temp_change
				if [[ $check == 1 ]]; then
					change_control $temp_index
				else 
					echo "account tidak ditemukan"
				fi			
				;;
			"1" )
				read -p "Masukkan username account yang ingin dihapus : " temp_change;
				check $temp_change;
				if [[ $check == 1 ]]; then
					delete $temp_change
				fi
				;;
			"2" )
				read -p "Masukkan username account yang ingin diganti : " temp_change;
				check $temp_change
				if [[ $check == 1 ]]; then
					change_pass
				else
					echo "Account tidak ditemukan"
					read
				fi
				;;
			"3" )
				view
				;;
			"4" )
			let loop_menu=0
				;;
		esac
	done
}

menu_asli(){
	let loop_menu=1;
	while [[ $loop_menu == 1 ]]; do
		clear
		echo "System Administration"
		echo "1. Create New User Account"
		echo "2. Delete Account"
		echo "3. View All User"
		echo "4. Quit"
		read temp_case;

		case "$temp_case" in
			"1" )
				read -p "Input username : " temp_usr;
				sudo adduser $temp_usr
				;;
			"2" )
				read -p "Input username : " temp_usr;
				sudo deluser --remove-home $temp_usr
				;;
			"3" )
				ls /home
				read
				;;
			"4" )
				let loop_menu=0;
				;;
		esac
	done
}

file_manegement(){
	let loop_menu=1;
	cd /root/'Semester 3'/'Sistem Operasi';
	while [[ $loop_menu == 1 ]]; do
		clear
		echo "System Administration"
		echo "1. Create New File"
		echo "2. Delete File"
		echo "3. Edit File"
		echo "4. Mengganti Owner File"
		echo "5. Mengganti User Akses"
		echo "6. View File"
		echo "7. Quit"
		read temp_case;
		case "$temp_case" in
			"1" )
				read -p "Masukkan nama file : " temp_file;
				read -p "masukkan format file (.sh/.txt) : " temp_format;
				if [[ $temp_format == '.sh' || $temp_format == '.txt' ]]; then
					>$temp_file$temp_format
					echo "file telah dibuat!!"
				else
					echo "format yang dimasukkan belum terfasilitasi oleh aplikasi ini :(";
				fi
				read;
				;;
			"2" )
				read -p "Masukkan nama file dengan formatnya yang ingin dihapus : " temp_file;
				rm $temp_file
				read;
				;;
			"3" )
				read -p "Masukkan nama file dengan formatnya yang ingin diedit : " temp_file;
				nano $temp_file
				;;
			"4" )
				read -p "Masukkan nama file dengan formatnya yang ingin diganti : " temp_file;
				read -p "Masukkan user yang ingin dijadikan owner file ($temp_file) : " temp_usr;
				chown $temp_usr $temp_file
				;;
			"5" )
				read -p "Masukkan nama file dengan formatnya yang ingin diganti : " temp_file;
				read -p "Masukkan akses untuk owner (1-7) : " temp_aks1;
				read -p "Masukkan akses untuk grup (1-7) : " temp_aks2;
				read -p "Masukkan akses untuk other (1-7) : " temp_aks3;
				if [[ $temp_aks1 -le 7 && $temp_aks2 -le 7 && $temp_aks3 -le 7 ]]; then
					chmod $temp_aks1$temp_aks2$temp_aks3 $temp_file
				else
					echo "user akses file salah";
				fi
				read;
				;;
			"6" )
				ls -l
				read
				;;
			"7" )
				let loop_menu=0;
				;;

		esac
		
	done
}

let loop_main=1;
while [[ $loop_main == 1 ]]; do
	clear
	echo "-----------Program Sysadmin--------------"
	echo "0. Sysadmin KW super"
	echo "1. Sysadmin System"
	echo "2. File Management"
	echo "3. Exit"
	read prep

	case "$prep" in
		"0" )
			let loop_main1=1;
			while [[ $loop_main1 == 1 ]]; do
				clear
				read -p "apakah anda adalah user terdaftar ? (1. Yes/ 2. No) Press q to quit" prep;
				if [[ $prep == 1 ]]; then
					login
					menu_kw
				elif [[ $prep == 2 ]]; then
					sign_up
					login
					menu_kw
				else
					let loop_main1=0;
				fi
			done
			;;
		"1" )
			menu_asli
			;;
		"2" )
			file_manegement
			;;
		"3" )
			let loop_main=0;
			;;
	esac
done