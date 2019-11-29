#!/bin/bash

		echo "input menit : ";
			read menit;


		if [[ $menit -lt 60 ]]; 
			then
			
				echo " "$menit" menit ";
			#statements
		elif [[ $menit -lt 1440 ]]; 
			then
				let jam=$menit/60
				let sisa=$menit%60

				echo $jam" jam "$sisa" menit ";
			#statements
			else
					let hari=$menit/1440
					let sisa=$menit%1440
					let jam=$sisa/60
					let input=$sisa%60
					echo " "$hari" hari "$jam" jam "$input" menit";
				#statements
		fi
