
// another way
typedef struct {
  void *elems;
  int elemsize;
  int logicallength;
  int alloclength;
} stack;

//void StackNew(stack *s, int elemsize);
//void StackDispose(stack *s);
//void StackPush(stack *s, void *elemaddr);
//void StackPop(stack *s, void *elemaddr);


void StackNew(stack *s, int elemsize) {
  assert (s->elemsize > 0);
  s->elemsize = elemsize;
  s->logicallength = 0;
  s->alloclength = 4;
  s->elems = malloc(4 * elemsize);
  assert(s->elems != NULL);
}

void StackDispose(stack *s) {
  // some other stuff here
  free(s->elems);
}

// static is just like `private`
static void StackGrow(stack *s) {
  s->alloclength *= 2;
  s->elems = realloc(s->elems, s->alloclength * s->elemsize);
}

void StackPush(stack *s, void *elemaddr) {
  if (s->logicallength == s->alloclength)
    StackGrow(s);
  void *target = (char *) s->elems + s->logicallength * s->elemsize;
  memcpy(target, elemaddr, s->elemsize);
  s->logicallength++;
}

void StackPop(stack *s, void *elemaddr) {
  void *source = (char *)s->elems + (s->alloclength - 1) * s->elemsize;
  memcpy(elemaddr, source, s->elemsize);
  s->logicallength --;
}
