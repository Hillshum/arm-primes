
#
#
#
primes: main.o is_prime.o console.o itoa.o math.o
	 ld main.o is_prime.o console.o itoa.o math.o -o primes

main.o: main.s
	as main.s -o main.o

is_prime.o: is_prime.s
	as is_prime.s -o is_prime.o

console.o: console.s
	as console.s -o console.o

itoa.o: itoa.s
	as itoa.s -o itoa.o

math.o: math.s
	as math.s -o math.o
