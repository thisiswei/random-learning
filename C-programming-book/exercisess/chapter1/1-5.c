#include <stdio.h>
#include <stdlib.h>

// convert cel to fahr
void main() {
  float cels, fahr;
  float upper, step;
  upper = 300;
  step = 20;
  fahr = upper;
  while (fahr >= 0) {
    cels = (5.0/9.0) * (fahr-32);
    printf("%3.0f %6.1f\n", fahr, cels);
    fahr -= step;
  }
}
