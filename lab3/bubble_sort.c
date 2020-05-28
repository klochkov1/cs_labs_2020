#include <stdio.h>
#include <stdlib.h>

int main() {
  int n = 5000;
  int* array;
  array = (int*)malloc(n * sizeof(float));
  for (int i = 0; i < n; ++i) {
    array[i] = n - i;
  }
  
  int sorted = 0, temp;
  while (!sorted) {
    sorted = 1;
    for (int j = 0; j < n - 1; j++) {
      if (array[j] > array[j + 1]) {
        temp = array[j];
        array[j] = array[j + 1];
        array[j + 1] = temp;
        sorted = 0;
      }
    }
  }
  // for (int i = 0; i < n; ++i) {
  //   printf("%5i ", array[i]);
  //   if ((i + 1) % 20 == 0) {
  //     printf("\n");
  //   }
  // }
}