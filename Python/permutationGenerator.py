import itertools

class permutationGenerator():

    @staticmethod
    def generateFromFile(fileName):
        """Just read content of file."""
        print("Reading file content by line")
        with open(fileName, "r") as f:
            lines = f.read().splitlines()
            yield from permutationGenerator.generateFromList(lines)


    @staticmethod
    def generateFromList(listOfVariables):
        """Will generate all possible permutations from input with all lenghts from 1 to length(listOfVariables)."""
        for a in range(1, len(listOfVariables) + 1):
            permForA = itertools.permutations(listOfVariables, a)
            for b in permForA:
                yield b


gen_perm = permutationGenerator.generateFromFile("passwords.txt")
with open("result.txt", "w") as f:
    for it in gen_perm:
        f.write(str(it) + "\n")


"""
print(gen_perm.__next__())
print(gen_perm.__next__())
print(gen_perm.__next__())
print(type(gen_perm))
"""
