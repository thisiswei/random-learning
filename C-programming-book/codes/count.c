// count word, chars, lines

#include <stdio.h>
#include <stdlib.h>

#define IN 1
#define OUT 0

int main() {
  int c, wc, charc, lc, state;
  wc = charc = lc = state = 0;
  while ((c = getchar()) != EOF) {
    charc ++;
    if (c == '\n')
      lc ++;
    if (c == '\n' || c == '\t' || c == ' ')
      state = OUT;
    else if (state == OUT){
      state = IN;
      wc ++;
    }
  }
  printf("%d %d %d\n", charc, wc, lc);
  return 0;
}
