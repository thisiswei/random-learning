"""
count how many inversions in a array
[1, 3, 2,  7, 5, 4] -> (3, 2) + (7,5) + (7,4) + (5, 4) -> 4

[1, 2, 3], [4, 5, 7]
[1, 4, 6], [3, 5, 7]

"""

def sort_count(p):
    L = len(p)
    if L <= 1:
        return 0, p
    else:
        left_half, right_half = p[:L/2], p[L/2:]
        x, merged_left = sort_count(left_half)
        y, merged_right = sort_count(right_half)
        z, merged = sort_count_split(merged_left, merged_right)
    return x + y + z, merged

def sort_count_split(left, right):
    """
    use the method as in mergesort, count the number of inversions
    """
    i = j = 0
    l, r = len(left), len(right)
    cnt = 0
    merged = []
    while i < l and j < r:
        left_i, right_j = left[i], right[j]
        if left_i <= right_j:
            i += 1
            merged.append(left_i)
        else:
            cnt += l - i
            j += 1
            merged.append(right_j)
    merged += left[i:] or right[j:]
    return cnt, merged

input_array_1 = []  #0
input_array_2 = [1] #0
input_array_3 = [1, 5]  #0
input_array_4 = [4, 1] #1
input_array_5 = [4, 1, 2, 3, 9] #3
input_array_6 = [4, 1, 3, 2, 9, 5]  #5
input_array_7 = [4, 1, 3, 2, 9, 1]  #8

assert sort_count(input_array_1)[0] == 0
assert sort_count(input_array_2)[0] == 0
assert sort_count(input_array_3)[0] == 0
assert sort_count(input_array_4)[0] == 1
assert sort_count(input_array_5)[0] == 3
assert sort_count(input_array_6)[0] == 5
assert sort_count(input_array_7)[0] == 8
