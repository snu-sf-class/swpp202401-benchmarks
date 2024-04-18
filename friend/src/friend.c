#include <inttypes.h>
#include <stdlib.h>

#define MAX(x, y) (((x) > (y)) ? (x) : (y))

uint64_t read();
void write(uint64_t);

void *malloc_upto_8(uint64_t x) { return malloc((x + 7) / 8 * 8); }

int findSample(int n, int confidence[], int host[], int protocol[]) {
  int i;
  int *D;

  D = (int *)malloc_upto_8(2 * sizeof(int) * n);

  for (i = 0; i < n; i++)
    D[2 * i] = confidence[i];
  for (i = n - 1; i >= 1; i--) {
    switch (protocol[i]) {
    case 0:
      D[2 * host[i]] += D[2 * i + 1];
      D[2 * host[i] + 1] += MAX(D[2 * i], D[2 * i + 1]);
      break;

    case 1:
      D[2 * host[i]] = MAX(D[2 * host[i]] + MAX(D[2 * i], D[2 * i + 1]),
                           D[2 * host[i] + 1] + D[2 * i]);
      D[2 * host[i] + 1] += D[2 * i + 1];
      break;

    default:
      D[2 * host[i]] =
          MAX(D[2 * host[i]] + D[2 * i + 1], D[2 * host[i] + 1] + D[2 * i]);
      D[2 * host[i] + 1] += D[2 * i + 1];
    }
  }
  return MAX(D[0], D[1]);
}

// Main
int main(void) {
  int n, i;
  int *confidence, *host, *protocol;

  // Number of people
  n = read();

  confidence = (int *)malloc_upto_8(sizeof(int) * n);
  host = (int *)malloc_upto_8(sizeof(int) * n);
  protocol = (int *)malloc_upto_8(sizeof(int) * n);

  // Confidence
  for (i = 0; i < n; i++)
    confidence[i] = read();

  // Host and Protocol
  for (i = 1; i < n; i++) {
    host[i] = read();
    protocol[i] = read();
  }

  // Answer
  write(findSample(n, confidence, host, protocol));
  return 0;
}
