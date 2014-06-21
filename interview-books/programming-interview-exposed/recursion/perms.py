# why this is not correct
def perms(seq):
    if seq == []:
        return [[]]
    head = seq[0:1]
    restp = perms(seq[1:])
    return [p[:i] + head + p[i:] for p in restp for i in range(len(restp)+1)]

#def perms(seq):
#    if seq == []:
#        return [[]]
#    return [[x]+p for x in seq for p in perms(removed(x, seq))]

#def removed(x, seq):
#    idx = seq.index(x)
#    return seq[:idx] + seq[idx+1:]
#
#def permutations(items):
#    if items == []:
#        return [ [] ]
#    else:
#        return [ [x] + p
#                     for x in items
#                     for p in permutations(removed(items, x)) ]

#def removed(items, x):
#    "Return a copy of items, but with x removed."
#    copy = list(items)
#    copy.remove(x)
#    return copy
#
#def permutations(items):
#    if items == []:
#        return [ [] ]
#    else:
#        first, rest = items[0:1], items[1:]
#        return [ (p[:i] + first + p[i:]) for p in permutations(rest) for i in range(len(p)+1) ]
#
print perms([1,2,3])
