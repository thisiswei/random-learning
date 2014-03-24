def merge_sort(lis):
    l = len(lis)
    if l <= 1:
        return lis
    left_len = l/2
    left, right = merge_sort(lis[:left_len]), merge_sort(lis[left_len:])
    return merge(left, right)

def merge(left, right):
    left_len, right_len = len(left), len(right)
    to_return = []
    l, r = 0, 0
    while l < left_len and r < right_len:
        left_, right_ = left[l], right[r]
        if left_ < right_:
            to_return.append(left_)
            l += 1
        else:
            to_return.append(right_)
            r += 1
    to_add = right[r:] or left[l:]
    to_return += to_add
    return to_return

import random
lis = range(1000000)
random.shuffle(lis)
merge_sort(lis)
