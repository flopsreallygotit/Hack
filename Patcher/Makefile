CXX=g++
CXXFLAGS=-Wall -Wextra -fsanitize=address
OBJ=main.o 
ODIR=obj
IFLAGS=-lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio

%.o: %.c $(DEPS)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

main: $(OBJ)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(IFLAGS)  

.PHONY: clear
clear:
	rm -f ./*.o main