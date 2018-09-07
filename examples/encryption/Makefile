# The examples of https://github.com/digi-trust/dt-cdn/wiki/ID-encryption
MAKEFLAGS = -j1
default:
all: run
EXAMPLE_DECRYPTED := $(shell cat id-decrypted-hex.txt)
ifneq "16" "$(shell echo -n $(EXAMPLE_DECRYPTED) | wc -c)"
$(info error: the decrypted example is corrupted)
$(info error: it must have exactly 64 bits as 16 hexidecimal characters)
$(error cannot proceed)
endif
run: run-setup-keying.sh
run-setup-keying.sh:
	./setup-keying.sh
	: DONE - demonstrated how to run openssl to create key pairs
clean: clean-setup-keying.sh
clean-setup-keying.sh:
	rm -f t99.{private,public}.{der,pem}
run: run-decrypt.sh
run-decrypt.sh: id-encrypted-base64.txt
	./decrypt.sh
	: DONE - demonstrated how to decrypt an identifier from bash with openssl
	: exhibit the null bytes, no newline && ./decrypt.sh 2>/dev/null | cat -ve; echo
	test "$(EXAMPLE_DECRYPTED)" == "`./decrypt.sh 2>/dev/null | tr -d '\0'`"
run: run-decrypt.php
run-decrypt.php: # [[FIXTHIS]] the crypto-blob is hard-coded in the php, not in id-encrypted-base64.txt
	php ./decrypt.php
	: DONE - demonstrated how to decrypt an identifier from PHP
	: exhibit the null bytes, no newline && php ./decrypt.php 2>/dev/null | cat -ve ; echo
	test "Decrypted ID: $(EXAMPLE_DECRYPTED)" == "`php ./decrypt.php 2>/dev/null | tr -d '\0'`"
run: run-decrypt.java
run-decrypt.java: example.private.der
	javac -classpath /usr/share/java/apache-commons-codec.jar Playground.java
	java -classpath .:/usr/share/java/apache-commons-codec.jar Playground
	: DONE - demonstrated how to decrypt an identifier from Java
	: exhibit the null bytes, YES newline && java -classpath .:/usr/share/java/apache-commons-codec.jar Playground 2>/dev/null | cat -ve
	test "$(EXAMPLE_DECRYPTED)" == "`java -classpath .:/usr/share/java/apache-commons-codec.jar Playground | tr -d '\0' | head -1`"
clean: clean-decrypt.java
clean-decrypt.java:
	rm -f Playground.class
example.private.der: example.private.pem
	: see the suggestion in Playground.java
	openssl pkcs8 -topk8 -nocrypt -in $< -outform DER -out $@
clean: clean-example.private.der
clean-example.private.der:
	rm -f example.private.der example.public.der
run: run-decrypt.cpp
# CXXFLAGS is reserved to the command line
__CXXFLAGS = -ggdb -std=c++1z
_CXXFLAGS = $(__CXXFLAGS) $(CXXFLAGS)
run-decrypt.cpp: example.private.der id-encrypted-base64.txt
	$(CXX) -o decrypt.exe $(_CXXFLAGS) decrypt.cpp -lcryptopp -lpthread
	./decrypt.exe example.private.der id-encrypted-base64.txt
	: DONE - demonstrated how to decrypt an identifier from C++
	: exhibit the null bytes, YES newline && ./decrypt.exe example.private.der id-encrypted-base64.txt 2>/dev/null | cat -ve
	test "./decrypt.exe: OK, recovered $(EXAMPLE_DECRYPTED)" == "`./decrypt.exe example.private.der id-encrypted-base64.txt | tr -d '\0'`"

clean: clean-decrypt.cpp
clean-decrypt.cpp:
	rm -f decrypt.exe

run: ; @echo OK

default: all
