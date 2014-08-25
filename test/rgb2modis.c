#include "stdlib.h"
#include "stdio.h"
#include "string.h"

int main(int argc, char *argv[])
{
	// FILE *fp = fopen(argv[1], "r");
	// int i, j, k;

	// while ((i = fgetc(fp)) != EOF) {
	// 	j = fgetc(fp);
	// 	k = fgetc(fp);
	// 	if (i != j || j != k) {
	// 		fprintf(stderr, "Error: bad pixel: %d %d %d\n", i, j, k);
	// 		exit(1);
	// 	} else if (i < 0 || i > 255) {
	// 		fprintf(stderr, "Error: out of range: %d\n", i);
	// 		exit(1);
	// 	} else if (j == EOF || k == EOF) {
	// 		fprintf(stderr, "Error: file not in rgb\n");
	// 		exit(1);
	// 	}
	// 	putchar(i);
	// }
	// fclose(fp);

	for (int i = 1; i < argc; i++) {
		FILE *frgb = fopen(argv[i], "r");
		char *name = malloc(20);
		int len = strlen(argv[i]);
		argv[i][len-4] = '\0';
		strcpy(name, argv[i]);
		strcat(name, ".modis");
		FILE *fmodis = fopen(name, "a");
		
		int j, k, m;
		while ((j = fgetc(frgb)) != EOF) {
			k = fgetc(frgb);
			m = fgetc(frgb);
			if (j != k || k != m) {
				fprintf(stderr, "Error: bad pixel: %d %d %d\n", j, k, m);
				exit(1);
			} else if (j < 0 || j > 255) {
				fprintf(stderr, "Error: out of range: %d\n", i);
				exit(1);
			} else if (k == EOF || m == EOF) {
				fprintf(stderr, "Error: file not in rgb\n");
				exit(1);
			}
			fputc(j, fmodis);
		}

		fclose(fmodis);
		fclose(frgb);
	}

	return 0;
}