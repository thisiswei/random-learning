int main() {
  int alice = 10;
  int bob = 20;
  swap(&alice, &bob);
  return 0;
}

void pointer() {
  int* x;
  int* y;
  *x = 1;
  *y = 2;
  x = y;
}

typedef struct node{
  int val;
  struct node* next;
} node;

void linkedlist() {
  node* fst;
  node* sec;
  node* third;

  fst = malloc(sizeof(node));
  sec = malloc(sizeof(node));
  third = malloc(sizeof(node));

  fst->val = 1;
  sec->val = 2;
  third->val = 3;

  fst->next = sec;
  sec->next = third;
  third->next = fst;
}

swap(int* a,int*b) {
  int tmp;
  tmp = *a;
  *a = *b;
  *b = tmp;
}

