all:
	elm make src/Main.elm

.PHONY : clean
clean :
	-rm index.html
	