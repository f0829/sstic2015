CFLAGS=-O3 -march=native -fomit-frame-pointer -funroll-loops -Wall

bf: bf.o decrypt.o
	gcc ${CFLAGS} -fopenmp -o bf bf.o decrypt.o -lcrypto

decrypt:
	gcc $(CFLAGS) -D_STANDALONE_ -o decrypt decrypt.c

decrypt.o: decrypt.c decrypt.h
	gcc -c $(CFLAGS) -o decrypt.o decrypt.c

bf.o: keys.h
	gcc -c $(CFLAGS) -fopenmp -o bf.o bf.c

keys.h: find-key.rb
	./find-key.rb > keys.h

clean:
	rm bf decrypt keys.h bf.o decrypt.o
