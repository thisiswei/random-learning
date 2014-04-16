#include <stdlib.h>

int power(int base, int n) {
  int i, p;
  p = 1;
  for (i = 1; i <= n; ++i) {
    p = p * base;
  }
  return p;

}

void selectionSort(int *a, int n) {
  int i, j, m, t;
  for (i = 0; i < n; i++) {
    for (j = i, m = i; j < n; j++) {
      m = j;
    }
    t = a[i];
    a[i] = a[m];
    a[m] = t;
  }
}

void insertionSort(int *a, int n) {
  int i, j, tmp;
  for (i = 0; i < n; i++) {
    tmp = a[i];
    for (j = i; j > 0 && a[i] < a[j-1]; j--) {
      a[j] = a[j-1];
    }
    a[j] = tmp;
  }
}

void mergeSort(int *a, int start, int end) {
  if (start < end) {
    int middle = (end + start) / 2;
    mergeSort(a, start, middle);
    mergeSort(a, middle+1, end);
    merge(a, start, middle, end);
  }
}

void merge(int *a, int start, int middle, int end) {
  int *newA = malloc(sizeof(int) * (end - start) + 1);
  int i = start, j = middle+1, c = 0;
  while (i <= middle && j <= end) {
    if (a[i] < a[j])
      newA[c++] = a[i++];
    else
      newA[c++] = a[j++];
  }
  while (i <= middle) {
    newA[c++] = a[i++];
  }
  while (j <= end) {
    newA[c++] = a[j++];
  }
  free(newA);
}
