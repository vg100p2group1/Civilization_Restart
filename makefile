all:
	elm make src/Main.elm
	mkdir build -p
	cp index.html build/index.html
	cp images build/images -rf

.PHONY: clean
clean:
	rm index.html
	rm build -r