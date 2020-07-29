all:
<<<<<<< HEAD
	elm make src/Main.elm
	mkdir build -p
	cp index.html build/index.html
	cp images build/images -rf

=======
	
	mkdir build -p
	elm make src/Main.elm --output build/elm.js
	cp index.html build/index.html
	cp images build/ -rf
	cp CSS build/ -rf
>>>>>>> Zihao_Wei
.PHONY: clean
clean:
	rm index.html
	rm build -r
	rm elm-stuff -r