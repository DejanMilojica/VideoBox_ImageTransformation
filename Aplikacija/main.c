#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "hwlib.h"
#include <math.h>

#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"

#include <pthread.h>

#include "ADDRESS_BASES.h"
#include "images/earth.h"
#include "images/train.h"
#include "images/test2.h"
#include "images/test3.h"
#include "images/test4.h"
#include "images/test5.h"

#include "affine_matrix.h"

#define IMAGE_WIDTH 640
#define IMAGE_HEIGH 480

#define ALT_LWFPGASLVS_OFST 0xFF200000
#define COPY_OFFSET 0x0004B000//0x00096000 

#define HW_REGS_BASE ( 0xFC000000 )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

#define ALT_AXI_FPGASLVS_OFST (0xC0000000)
#define HW_FPGA_AXI_SPAN (0x40000000)
#define HW_FPGA_AXI_MASK ( HW_FPGA_AXI_SPAN - 1 )

pthread_t user_interface_thread;

void *addr_pixel_image;

void *addr_parametar_transformacije;
void *addr_prikaz_slike;


void *addr_affine;

volatile char buffer_switch;

volatile uint32_t parametar; 
volatile uint32_t parametar_prikaz;
volatile char foreground_selector = -1;

volatile char stop = 0;

uint16_t (*a)[IMAGE_HEIGH][IMAGE_WIDTH];

/* Printanje header-a po pocetku izvrsavanja programa. */
void print_header(void){
	printf("\t\t\tIMAGE TRANSFORMATION\n");
	printf("============================================================\n");
	printf("Dostupne opcije:\n");
}

/* Upis odgovarajuce matrice transformacije u RAM memoriju.*/
void upis_matrice_transformacije(int16_t matrica[N][M]){

	int i,j;
	
	for( i = 0; i < N; i++){
		for( j = 0; j < M; j++){
			*((int16_t*)addr_affine + j + i * M) = matrica[i][j];
		}
	}
}

/* Funkcija programske niti, koja provjerava uneseni karakter sa tastature. */
void *user_interface_function(void* not_used)
{
	while(buffer_switch != 'q')
	{
		printf("\t's' = promjena slike.\n");
		printf("\t't' = transformacija slike.\n");
		printf("\t'p' = izbor prikaza slike originala/transformisane.\n");
		printf("\t'n' = prikaz matrice transformacije.\n");
		printf("\t'q' = izlaz iz programa.\n");
		printf("============================================================\n");
		printf(">>");
		fflush(stdin);
		fflush(stdout);
		scanf(" %c", &buffer_switch);
		
		if(buffer_switch == 't')
		{
			char definisanje_izvrsavanja_transformacije;	// Parametar kojim def. da li se transformacija vrsi SW/HW!
			printf("\t[s] - transformacije se vrse Softverski.\n");
			printf("\t[h] - transformacije se vrse Hardverski.\n");
			printf(">>");
			fflush(stdin);
			fflush(stdout);
			scanf(" %c", &definisanje_izvrsavanja_transformacije);
			
			printf("\t[1] - rotiranje za 180 stepeni.\n");
			printf("\t[2] - okretanje po vertikali.\n");
			printf("\t[3] - okretanje po horizontali.\n");
			printf("\t[4] - integracija bijelog pravougaonika u sliku.\n");
			printf("Transformacija:\n");
			printf(">>");
			fflush(stdin);
			fflush(stdout);
			scanf(" %d", &parametar);
			if(!(parametar==1 || parametar==2 || parametar==3 || parametar==4))
				parametar = 4; //Vrijednost koja uradi najblizu transformaciju!
			
			if(definisanje_izvrsavanja_transformacije == 'h'){
				*((uint32_t*)addr_parametar_transformacije) = parametar;
				if(parametar == 3)
					upis_matrice_transformacije(AMHF); //UPIS MATRICE TRANSFORMACIJE!
				else if(parametar == 2)
					upis_matrice_transformacije(AMVF); //UPIS MATRICE TRANSFORMACIJE!
				else if(parametar == 1)
					upis_matrice_transformacije(AMR_180); //UPIS MATRICE TRANSFORMACIJE!
				else 
					upis_matrice_transformacije(AM_BT);
			}

			else if(definisanje_izvrsavanja_transformacije == 's'){
				int i,j;
				uint16_t slika[IMAGE_HEIGH][IMAGE_WIDTH];

				if(parametar == 3){  // Okretanje po horizontali!
					for(i = 0; i < IMAGE_HEIGH/2; i++)
						for(j = 0; j < IMAGE_WIDTH; j++){
							slika[i][j] = (*a)[IMAGE_HEIGH-1-i][j];
							slika[IMAGE_HEIGH-1-i][j] = (*a)[i][j];
						}	

				}else if(parametar == 2){ // Okretanje po vertikali!
					for(i = 0; i < IMAGE_HEIGH; i++)
						for(j = 0; j < IMAGE_WIDTH/2; j++){
							slika[i][j] = (*a)[i][IMAGE_WIDTH-1-j];
							slika[i][IMAGE_WIDTH-1-j] = (*a)[i][j];
						}

				}else if(parametar == 1){  //Rotacija za 180 stepeni!
					for(i = 0; i < IMAGE_HEIGH; i++)
						for(j = 0; j < IMAGE_WIDTH; j++){
							slika[i][j] = (*a)[IMAGE_HEIGH-1-i][IMAGE_WIDTH-1-j];
						}

				}else if(parametar == 4){  //Integracija bijelog pravougaonika u sliku!
					for(i = 0; i < IMAGE_HEIGH; i++)
						for(j = 0; j < IMAGE_WIDTH; j++){
							if(i>=200 && i<=400 && j>=300 && j<=400)
								slika[i][j] = 0;
							else
								slika[i][j] = (*a)[i][j];
						}
				}else{
					printf("NEISPRAVNA OPCIJA!\n");
				}

				for(i = 0; i < IMAGE_HEIGH; i++)
					for(j = 0; j < IMAGE_WIDTH; j++)  // Upis kopije!
						*((uint16_t*)addr_pixel_image + COPY_OFFSET + i * IMAGE_WIDTH + j) = slika[i][j]; 
			
			}else
				printf("NEISPRAVNA OPCIJA!\n");
		}

		if(buffer_switch == 'p')
		{
			printf("Prikaz slike:\n");
			printf("\t[1] - prikaz originalne slike.\n");
			printf("\t[2] - prikaz transformacije.\n");
			fflush(stdin);
			fflush(stdout);
			scanf(" %d", &parametar_prikaz);

			*((uint16_t*)addr_prikaz_slike) = parametar_prikaz;
		}

		if(buffer_switch == 's')
		{
			printf("Unesi selector pozadinske slike:\n");
			fflush(stdin);
			fflush(stdout);
			scanf(" %d", &foreground_selector);
			stop = 0;
		}

		if(buffer_switch == 'n')
		{
			int elem;
			printf("MATRICA TRANSFORMACIJE:\n");
			
			int i,j;
			for( i = 0; i < N; i++)
			{
				for( j = 0; j < M; j++)
				{
					printf("%5d", *((int16_t*)addr_affine + j + i * M));
				}
				printf("\n");
			}
		}
	}
	printf("\t\t\tKRAJ PROGRAMA!!!\n");
	printf("============================================================\n");
	stop = 0;
}

int main(int argc, char* argv[])
{
	void*	lw_virtual_base;
	void* 	axi_virtual_base;
	
	int 	fd;

	if ((fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1) {
		printf("ERROR: could not open \"/dev/mem\"...\n");
		
		return 1;
	}

	lw_virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE);
	axi_virtual_base = mmap( NULL, HW_FPGA_AXI_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, ALT_AXI_FPGASLVS_OFST );
	
	
	if (axi_virtual_base == MAP_FAILED) {
		printf("ERROR: mmap() failed...\n");
		close(fd);

		return 1;
	}

	if (lw_virtual_base == MAP_FAILED) {
		printf("ERROR: mmap() failed...\n");
		close(fd);

		return 1;
	}

	// SLIKA!
	addr_pixel_image = axi_virtual_base + ((unsigned long)(SDRAM_CONTROLLER_BASE) & (unsigned long)(HW_FPGA_AXI_MASK));

	// AFINA MATRICA!
	addr_affine = axi_virtual_base + ((unsigned long)(AFFINE_MATRIX_BASE) & (unsigned long)(HW_FPGA_AXI_MASK));
	
	// PARAMETAR KOJI DEFINISE TIP TRANSFORMACIJE!
	addr_parametar_transformacije = lw_virtual_base + ((unsigned long)(ALT_LWFPGASLVS_OFST + IMAGE_PROCESSING_BASE) & (unsigned long)(HW_REGS_MASK));

	// PARAMETAR KOJI DEFINISE DA LI PRIKAZUJEMO ORIGINALNU SLIKU, ILI 'KOPIJU'(TRANSFORMISANU SLIKU)!
	addr_prikaz_slike = lw_virtual_base + ((unsigned long)(ALT_LWFPGASLVS_OFST + IZBOR_PRIKAZA_SLIKE_BASE) & (unsigned long)(HW_REGS_MASK));

	if(pthread_create(&user_interface_thread, NULL, user_interface_function, NULL)) {
		fprintf(stderr, "Error creating thread\n");
		return 1;
	}

//	uint16_t (*a)[IMAGE_HEIGH][IMAGE_WIDTH];

	print_header();

	int i, j;
	while(buffer_switch != 'q')
	{	

		switch(foreground_selector)
		{
			case 0:
				a = train;
			break;
			case 1:
				a = earth;
			break;
			case 2:
				a = test2;
			break;
			case 3:
				a = test3;
			break;
			case 4:
				a = test4;
			break;
			case 5:
				a = test5;
			break;
			default:
				a = earth;
		}

		for(i = 0; i < IMAGE_HEIGH; i++)
		{
			for(j = 0; j < IMAGE_WIDTH; j++)
			{
				*((uint16_t*)addr_pixel_image + i * IMAGE_WIDTH + j) = (*a)[i][j]; // Upis originalne slike!
			}
		}

		// KOPIJA!		
		//a = earth;
		for(i = 0; i < IMAGE_HEIGH; i++)
		{
			for(j = 0; j < IMAGE_WIDTH; j++)
			{
				*((uint16_t*)addr_pixel_image + COPY_OFFSET + i * IMAGE_WIDTH + j) = (*a)[i][j]; // Upis kopije!

			}
		}
		while(stop == 1);
		stop = 1;
	}

	if (munmap(axi_virtual_base, HW_FPGA_AXI_SPAN) != 0) {
		printf("ERROR: munmap() failed...\n");
		close(fd);

		return 1;
	}

	if (munmap(lw_virtual_base, HW_REGS_SPAN) != 0) {
		printf("ERROR: munmap() failed...\n");
		close(fd);

		return 1;
	}
	
	close(fd);

	return 0;
}

