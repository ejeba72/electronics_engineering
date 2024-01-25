// 2024jan23 tue 2158mf
// POINTER EXPERIMENTATION

#include<stdio.h>

int main() {
  int a = 6;
  // int* b = &a;
  int b = &a;  // This is the experiment. And it produces error. I did it to better understand defining a pointer.
  printf("value of a: %d\n", *b);
  printf("memory address of a: %p\n", b);
}
