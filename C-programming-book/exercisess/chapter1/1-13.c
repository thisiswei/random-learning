#include <stdio.h>
#include <stdlib.h>

#define IN 0;
#define OUT 1;

int main() {
  int wl, state, k;
  char c;
  char *w;
  wl = state = k = 0;
  while ((c = getchar()) != EOF) {
    if (c == ' ' || c == '\t' || c == '\n') {
      state = OUT;
      if (wl) {
        putchar(w);
        wl = 0;
        w = '\0';
        k = 0;
      }
    }
    else if (state == OUT) {
      state = IN;
      w[k++] = c;
      wl ++;
    }
  }
}
