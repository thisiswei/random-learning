#include <stdlib.h>

typedef struct {
  void *elems;
  int elemsize;
  int logicallength;
  int alloclength;
} stack;

void StackNew(stack *s, int elemsize) {
  assert (s->elemsize > 0);
  s->elemsize = elemsize;
  s->logicallength = 0;
  s->alloclength = 4;
  s->elems = malloc(4 * elemsize);
  assert(s->elems != NULL);
}

int main(-, -) {
  const char *friends = {"AI", "Bob", "Carl"};
  stack stringstack;
}
