#ifndef AFFINE_MATRIX
#define AFFINE_MATRIX

#define N 2
#define M 2

int16_t AMR_180[N][M] = {-1, 0, 0, -1};  // Rotacija za 180 stepeni!
int16_t AMHF[N][M] = {-1, 0, 0, 1}; 	// Horizontalno obrtanje!
int16_t AMVF[N][M] = {1, 0, 0, -1}; 	// Vertikalno obrtanje!
int16_t AM_BT[N][M] = {0, 0, 0, 0};		// BEZ TRANSFORMACIJE!
#endif
