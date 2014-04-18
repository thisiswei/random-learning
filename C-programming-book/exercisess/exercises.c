#include <stdlib.h>
#include <stdio.h>


/* squeeze: delete all c from s */

void squeeze(char s[], int c) {
  int i, j;
  for (i = j = 0; s[i] != '\0'; i++) {
    if (s[i] != c) {
      s[j] = s[i];
      j ++;
    }
  }
  s[j] = '\0';
}

//2-5 write any(s1, s2) return first location in s1 where any char from s2 occurs

int any(char s1[], char s2[]) {
  for (int i = 0; s1[i] != '\0'; i++) {
    for (int j = 0; s2[j] != '\0'; j++) {
      if (s1[i] == s2[j]) return i;
    }
  }
  return -1;
}


// 2-4 write a alternative version of squeeze(s1, s2) that deletes each
// character in s1 that matches any character in s2

void squeezeA(char s1[], char s2[]) {
  int i;
  for (i = 0; s2[i] != '\0'; i++)
    squeeze(s1, s2[i]);
}


// 2-6 setbits(x, p, n, y) that return x with n bits that begin at position p
// set to the rightmost n bit of y.

void setbits(x, p, n, y) {
  return x & (y >> (p+1-n))
}









int main() {
  int i;
  i = any("wtf", "bitch");
  printf("%d", i);
  return 0;
}
