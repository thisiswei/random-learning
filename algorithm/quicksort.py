def quick_sort(arr):
    """[3, 8, 2, 5, 1, 4, 7, 6]
    pick pivot, put smaller on the left, larger on the right,
    keep doing these for the subset of the array:left, right
    """
    if len(arr) <= 1:
        return arr
    k = choose_pivot(arr)
    left, right = partition(arr, k)
    l = quick_sort(left)
    r = quick_sort(right)
    return l + r

def partition(arr, k):
    middle = arr[k]
    i = 0
    for j, ele in enumerate(arr, 0):
        if ele <= middle:
            if j >= i:
                switch(i, j, arr)
            i += 1
    switch(k, i-1, arr)
    return arr[:i], arr[i:]

def choose_pivot(arr):
    return 0

def switch(idx, idy, arr):
    arr[idx], arr[idy] = arr[idy], arr[idx]


arr = [3, 8, 2, 5, 1, 4, 7, 6]
print arr
print quick_sort(arr)

import random
arr2 = range(10000)
random.shuffle(arr2)
print arr2
print quick_sort(arr2)

