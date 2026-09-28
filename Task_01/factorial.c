#include <stdio.h>

int main(int argc, char *argv[]) {
	if(argc != 2) {
	 printf("Error: expected one argument\n");
	 return 0;
	}
	
	int num;
	sscanf(argv[1], "%d", &num);

	int fact = num;
        int result = num;

	while(fact > 1) {
	  fact--;
	  result = result * fact; 
	}

	printf("%d\n", result);
	return 0;
}
