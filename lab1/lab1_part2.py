#!/usr/bin/python3
import os
import sys


def encode_utf64(source_str):
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    binarray = ''
    encoded = ''
    encoded_formated = ''
    for c in bytearray(source_str):
        binarray += bin(c)[2:].rjust(8, '0')
    for i in range(0, len(binarray), 24):
        for j in range(i, i + 24, 6):
            if binarray[j:j+6]:
                index = int(binarray[j:j+6].ljust(6, '0'), 2)
                encoded += alphabet[index]
            else:
                encoded += '='
    for i in range(0, len(encoded), 76):
        encoded_formated += encoded[i:i+76] + '\n'
    else:
        encoded_formated = encoded_formated[:0-1]
    return encoded_formated


def main():
    source = ''
    source = sys.stdin.buffer.read()
    print(encode_utf64(source))


if __name__ == "__main__":
    main()
