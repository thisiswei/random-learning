#include <stdio.h>
#include <stdlib.h>

int main() {
  printf(pow(3, 2));
  return 0;
}

int pow(int base, int p) {
  int i, r;
  r = 1;
  for (i = 1; i <= p; i++) {
    r = r * base;
  }
  return r;
}
