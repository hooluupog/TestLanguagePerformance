#include <stdio.h>

int main(void) {
int i;
char buf[256];
  for (i = 0; i < 1 << 25; i++) {
    sprintf(buf, "%d\n", i);
  }
} 
