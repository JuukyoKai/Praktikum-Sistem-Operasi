from os import getpid
from time import time, sleep
from multiprocessing import Pool, Process

def modul(a):
	global c
	if a % c == 0:
		print(a**2," - ID proses",getpid())
	else :
		print(a," - ID proses",getpid())
	sleep(1)

if __name__ == '__main__':
	c = int(input("masukkan modulo loop :"))
	a = int(input("Masukkan batas a^2 : "))

	#sekuensial
	print("\nloop sekuensial")
	sek_awal = time()

	for i in range(1,(a**2)+1):
		modul(i)

	sek_akhir=time()

	#Process
	print("\nloop Process")
	pro_arr = []
	pro_awal = time()

	for i in range(1,(a**2)+1):
		p = Process(target=modul, args=(i,))
		pro_arr.append(p)
		p.start()

	for i in pro_arr:
		p.join()

	pro_akhir = time()

	#Pool
	print("\nloop Pool")
	pool_awal = time()

	pool=Pool()
	pool.map(modul,range(1,(a**2)+1))
	pool.close()

	pool_akhir=time()

print("\nsekuensial : ",sek_akhir - sek_awal," detik")
print("\nProcess : ",pro_akhir - pro_awal," detik")
print("\npool : ",pool_akhir - pool_awal," detik")