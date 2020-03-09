#!/usr/bin/python3
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
                    char = char.lower()
                    if char in char_amount:
                        char_amount[char] += 1
                    else:
                        char_amount[char] = 1
                    self.chars_counter += 1
            for char in char_amount.keys():
                chars_probabilities[char] = char_amount[char] / self.chars_counter
        return chars_probabilities

    def calc_entropy(self):
        ua_alphabet = ["а", "б", "в", "г", "ґ", "д", "е", "є", "ж", "з", "и", "і", "ї", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ь", "ю", "я"]
        entropy = 0
        p = self.probabilites
        for c in ua_alphabet:
            if c in p:
                entropy += p[c] * log( 1 / p[c] ,2)
        return entropy


def main():
    if len(sys.argv) == 4:
        files = [File(f) for f in sys.argv[1:]]
    else:
        print(f"Usage {sys.argv[0]} file1 file2 file3")
        exit(1)
    for f in files:
        print(f.name)
        print("{:10s}...txt | {:5.3f} | {:5.3f} |".format(f.name[:20], f.probabilites['а'], f.enthropy))


if __name__ == "__main__":
    main()
