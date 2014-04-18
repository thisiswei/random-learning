#include <stdio.h>
#include <stdlib.h>
// print one word per line.

int main() {
  char c;
  int state, j;
  state = 0;
  char *w;
  while ((c = getchar()) != EOF) {
    if (c == '\t' || c == '\n' || c == ' ') {
      state = 0;
      printf("%s", w);
      putchar('\n');
      w = '\0';
    }
    else if (state == 0) {
      state = 1;
      w[j++] = c;
    }
  }
  return 0;
}
