def subsets(seq):
    if seq == []:
        return [[]]
    head = seq[0:1]
    rest = seq[1:]
    subs = subsets(rest)
    return subs + [ head+sub for sub in subs ]

print subsets([1,2,3])
