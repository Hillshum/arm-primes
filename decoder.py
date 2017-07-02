#!/usr/bin/env python3

from sys import argv

FILENAME = 'primes.txt'

num_primes = 50 if len(argv) < 2 else argv[1]
start = 'begin' if len(argv) < 3 else argv[2]

#start = {'begin': 0, 'end': 2}[start]
num_primes = int(num_primes)


with  open(FILENAME, 'rb') as fp:
    if start == 'end':
        fp.seek(num_primes * -4, 2)
    data = fp.read(4)
    for i in range(abs(num_primes)):
        print(int.from_bytes(data, 'little'))
        data = fp.read(4)
