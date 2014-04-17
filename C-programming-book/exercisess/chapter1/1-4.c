#include <stdio.h>
#include <stdlib.h>

// convert cel to fahr
int main() {
  float fahr;
  float lower, upper, step;
  lower = 0;
  upper = 100;
  step = 10;
  while (lower <= upper) {
    fahr = (lower * 180/100) + 32;
    printf("%3.0f %6.1f\n", lower, fahr);
    lower += step;
  }

}
