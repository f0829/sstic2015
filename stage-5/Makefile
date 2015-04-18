recode: recode.c keys.h
	gcc -O3 -march=native -fomit-frame-pointer -fopenmp -funroll-loops -Wall -o recode recode.c -lcrypto

keys.h: find-key.rb
	./find-key.rb > keys.h

clean:
	rm recode keys.h
