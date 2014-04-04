#include <stdlib.h>

void *lsearch(void *key, void *base, int n, int elemsize,
              int (*cmpfn)(void *, void *)) {
  for (int i = 0; i < n; i++) {
    void *elemaddr = (char *)base + i * elemsize;
    if (cmpfn(key, elemaddr) == 0)
      return elemaddr;
  }
  return NULL;
}

int StrCmp(void *vp1, void *vp2) {
}

void *bsearch(void *key, void *base, int n, int elemsize,
              int (*cmp)(void *, void *)) {

}

typedef struct {
  int *elems;
  int logicallength;
  int alloclength;

} stack;

//void StackNew(stack *s);
//void StackDispose(stack *s);
//void StackPush(stack *s, int value);
//int StackPop(stack *s);


void StackNew(stack *s) {
  s->logicallength = 0;
  s->alloclength = 4;
  s->elems = malloc(4 * sizeof(int));
  assert (s->elems != NULL);
}

void StackPush(stack *s, int value) {
  if (s->alloclength == s->logicallength) {
    s->alloclength *= 2;
    s->elems = realloc(s->elems, s->alloclength, *sizeof(int));
    assert (s->elems != NULL);
  }
  s->elems[s->logicallength] = value;
  s->logicallength ++;
}

int StackPop(stack *s) {
  assert (s->logicallength > 0);
  s->logicallength --;
  return s->elems[s->logicallength];
}
