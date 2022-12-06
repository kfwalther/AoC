'''
Dec 6 Python script
'''

# Iterate thru string char-by-char until we find set of N unique, consecutive chars.
def FindUniqueSet(inStr, n):
    for i in range(len(inStr)):
        if len(set(inStr[i:i+n])) == n:
            return str(i + n)

# Open file for reading.
with open('input.txt', 'r') as f:
    inStr = f.readline()
    # Find first instance of 4 and 14 unique, consecutive chars.
    print('Part A: ' + FindUniqueSet(inStr, 4))
    print('Part B: ' + FindUniqueSet(inStr, 14))
