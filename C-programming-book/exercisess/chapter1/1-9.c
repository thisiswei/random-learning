#include <stdio.h>
#include <stdlib.h>

// copy input to its output, replacing each string of 1 or more blank
// with single blank

int main() {
  char c, last;
  last = getchar();
  while ((c = getchar()) != EOF) {
    if (last != ' ') {
      putchar(last);
    }
    else if (c != ' ') {
      putchar(' ');
    }
    last = c;
  }
  putchar(last);
  return 0;
}
