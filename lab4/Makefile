.PHONY : all debug clean

AS_FLAGS = 
LD_FLAGS = --static
SRC = print_file.s
OBJ = print_file.o
EXE = print_file

all: $(EXE)

debug: ASFLAGS += --gdwarf-2
debug: $(EXE)

$(EXE): $(OBJ)
	ld $(LD_FLAGS) $(OBJ) -o $(EXE)

$(OBJ): $(SRC)
	as $(ASFLAGS) -o $(OBJ) -c $(SRC)

clean:
	rm -f $(OBJ) $(EXE)
