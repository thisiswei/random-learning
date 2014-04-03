void swap(int *px, int *py) {
  int tmp;
  tmp = *px;
  *px = *py
  *py = tmp;
}

int strlen(char *s) {
  for (n = 0; *s != '\0'; s++) {
    n++;
  }
  return n;
}

int strlen(char *s) {
  char *p = s;
  while (*p != '\0') {
    p++;
  }
  return p - s;
}
