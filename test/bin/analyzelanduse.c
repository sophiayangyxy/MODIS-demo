#include "stdio.h"
#include "stdlib.h"
#include "strings.h"

int main(int argc, char *argv[])
{
	
	FILE *topselected = fopen(argv[1], "a");
	FILE *selectedtiles = fopen(argv[2], "a");
	
	// for (int i = 0; i < argc; i++) {
	// 	fprintf(topselected, "%s\n", argv[i]);
	// 	fprintf(selectedtiles, "la");
	// }

	int t;

	char *usetype = argv[3];
	if (strcmp(usetype, "water") == 0) {
		t = 0;
	} else if (strcmp(usetype, "evergreenneedle") == 0) {
		t = 1;
	} else if (strcmp(usetype, "evergreenlead") == 0) {
		t = 2;
	} else if (strcmp(usetype, "deciduousneedle") == 0) {
		t = 3;
	} else if (strcmp(usetype, "deciduousleaf") == 0) {
		t = 4;
	} else if (strcmp(usetype, "mixedforest") == 0) {
		t = 5;
	} else if (strcmp(usetype, "closedshrub") == 0) {
		t = 6;
	} else if (strcmp(usetype, "openshrub") == 0) {
		t = 7;
	} else if (strcmp(usetype, "woody") == 0) {
		t = 8;
	} else if (strcmp(usetype, "savanna") == 0) {
		t = 9;
	} else if (strcmp(usetype, "grassland") == 0) {
		t = 10;
	} else if (strcmp(usetype, "wetland") == 0) {
		t = 11;
	} else if (strcmp(usetype, "cropland") == 0) {
		t = 12;
	} else if (strcmp(usetype, "urban") == 0) {
		t = 13;
	} else if (strcmp(usetype, "vegetartion") == 0) {
		t = 14;
	} else if (strcmp(usetype, "ice") == 0) {
		t = 15;
	} else if (strcmp(usetype, "barren") == 0) {
		t = 16;
	} else {
		t = 17;
	}

	char **fname = malloc(1000 * sizeof(char *));
	int i = 0;

	// char *fname = strtok(argv[5], " ");
	// printf("%s\n", fname);
	// fprintf(topselected, "%s\n", fname);
	// fprintf(selectedtiles, "blah");

	fname[0] = malloc(sizeof(char) * 30);
	fname[0] = strtok(argv[5], " ") ;
	
	// fprintf(topselected, "%s\n", fname[0]);

	while (fname[i] != NULL) {
		i++;
		fname[i] = malloc(sizeof(char) * 30);
		fname[i] = strtok(NULL, " ");
		fprintf(topselected, "%s\n", fname[i]);
	}
	int a = 0;
	while (fname[a] != NULL) {
		fprintf(selectedtiles, "%s\n", fname[a]);
		a++;
	}

	// unsigned long freq;
	// int index, hexIndex;
	// for (int i = 5; i <= argc; i++) {
	// 	FILE *fp = fopen(argc[i], "a");
	// 	fscanf(fp, "%lu %d %02x", &freq, &index, &hexIndex);
	// 	if (index == t)
	// }

	return 0;
}



























