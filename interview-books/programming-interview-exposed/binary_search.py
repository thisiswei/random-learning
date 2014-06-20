"""
implement a function to perform a binary search on a sorted array of
integers to find the index of the given integer.
"""

def bsearch(seq, target):
    L = len(seq)
    mid = L / 2
    if target == seq[mid]:
        return mid
    elif target < seq[mid]:
        return mid - bsearch(seq[:mid], target)
    else:
        return mid + bsearch(seq[mid:], target)

if __name__ == '__main__':
    print bsearch([0, 99, 200, 700, 2000, 30000], 700)
