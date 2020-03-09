#!/usr/bin/python3
import os
import sys
from math import log


class File:
    def __init__(self, name):
        self.name = name
        self.file_object = open(name)
        self.chars_counter = 0
        self.probabilites = self.calc_probabilites()
        self.enthropy = self.calc_entropy()

    def calc_probabilites(self):
        char_amount = {}
        chars_probabilities = {}
        for line in self.file_object:
            for char in line:
                if char.isalpha():
                    #char = char.lower()
                    if char in char_amount:
                        char_amount[char] += 1
                    else:
                        char_amount[char] = 1
                    self.chars_counter += 1
            for char in char_amount.keys():
                chars_probabilities[char] = char_amount[char] / self.chars_counter
        return chars_probabilities

    def calc_entropy(self):
        entropy = 0
        p = self.probabilites
        for c in p:
                entropy += p[c] * log( 1 / p[c] ,2)
        return entropy


def main():
    if len(sys.argv) > 1:
        files = [File(f) for f in sys.argv[1:]]
    else:
        print(f"Usage {sys.argv[0]} file1 file2 file3")
        exit(1)
    for f in files:
        print(f.name + "\n")
        print(f"File enthropy: {round(f.enthropy, 5)}")
        print()
        original_size = os.path.getsize(f.name)
        print("Orgignal: {:9d} bytes   100.0%".format(original_size))
        for ftype in [".tar.bz2", ".tar.gz", ".tar.xz", ".rar", ".zip"]:
            compressed_size = os.path.getsize(f.name + ftype)
            print("{:9s} {:9d} bytes    {:3.1f}%".format(ftype, compressed_size, compressed_size / original_size * 100 ))
        print()
        print("Chars probabilites:\n")
        for c in sorted(f.probabilites):
            print("{:s} - {:5.5f} ".format(c, f.probabilites[c]), end="   ")
        print()


if __name__ == "__main__":
    main()
