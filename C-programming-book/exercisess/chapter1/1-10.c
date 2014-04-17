#include <stdio.h>
#include <stdlib.h>

int main() {
  char c;
  while ((c = getchar()) != EOF) {
    if (c == '\t') {
      putchar('\\');
      putchar('t');
    }
    else if (c == '\b') {
      putchar('\\');
      putchar('b');
    }
    else if (c == '\\') {
      putchar('\\');
      putchar('\\');
    }
    else {
      putchar(c);
    }
  }
  return 0;
}
