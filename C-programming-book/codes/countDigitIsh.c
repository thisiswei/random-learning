#include <stdio.h>
#include <stdlib.h>

int main() {
  int c, i, nwhite, nother;
  int arr[10];
  for (i = 0; i < 10; i++) {
    arr[i] = 0;
  }
  nwhite = nother = 0;
  while ((c = getchar()) != EOF) {
    if (c == '\t' || c == ' ' || c == '\n')
      nwhite ++;
    else if (c >= '0' && c <= '9')
      arr[c-'0'] ++;
    else
      nother ++;
  }
}
