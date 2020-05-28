#include <stdio.h>
#include <stdlib.h>
int main()
{
	int n = 50000;
    int *array;
	array  = (int*) malloc(n * sizeof(float));
	for(int i=0; i < n; ++i)
	{
		array[i] = n - i;
	}
    int max = 0, maxIndex = 0, arrSize = n, tempSize = arrSize, temp;
    int sorted = 0;  
    while(!sorted)
    {
        sorted = 1;
        for(int j = 0; j < arrSize - 1; j++)
        {
            if (array[j] > array[j + 1])
            {
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp; 
                sorted = 0;
            }
		}
    }
}

