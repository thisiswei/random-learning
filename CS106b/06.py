"""
http://cs.stanford.edu/people/eroberts/courses/cs106b/chapters/06-recursive-procedures.pdf
"""

#Hanoi move tower
def move(size, start='L', using='M', end='R'):
    if len(size) == 1:
        return [size[0] + ',' + start + '->' + end]
    return move(size[:-1], start, end, using) + move(size[-1], start, using, end) + move(size[:-1], using, start, end)

def permutations(ls):
    if ls == []:
        return [[]]
    head = ls[0:1]
    return [s[:i] + head + s[i:] for s in permutations(ls[1:]) for i in range(len(s)+1)]

def countmoves(n):
    if n == 0:
        return 0
    return 1 + 2 * countmoves(n-1)

# why the fuck did I make this so complicated
#import string
#def get_dict():
#    letters = string.letters[26:]
#    ranges = get_start_end(0, 3)
#    return dict((i, letters[s:e])
#                for (i, (s, e)) in zip(range(2, 10), ranges))
#
#
#def get_start_end(start, end):
#    if end == 26:
#        return [(22, 26)]
#    return [(start, end)] + get_start_end(end, end+[3, 4][end in (15, 22)])

d = {
        2: 'ABC',
        3: 'DEF',
        4: 'GHI',
        5: 'JKL',
        6: 'MNO',
        7: 'PQRS',
        8: 'TUV',
        9: 'WXYZ'
        }


def mnemonics(string):
    group_letters = [d.get(int(s)) for s in string]
    def helper(group):
        if group == []:
            return ''
        head, rest = group[0], group[1:]
        if not rest:
            return [h for h in head]
        return [h+g for g in helper(rest) for h in head]
    return helper(group_letters)

def subsets(s):
    if s == "":
       return set([""])
    subs = [remove(s, c) for c in s]
    return set([s]) | set(p for sub in subs for p in subsets(sub))

def remove(s, c):
    copied = s.replace(c, '')
    return copied
#9
def generate_binary_code(nbits):
    if nbits == 0:
        return [[]]
    return [[d] + p for p in generate_binary_code(nbits-1) for d in [0, 1]]
#10
def gray_code():
    pass


def test():
    assert mnemonics('723') == ['PAD', 'QAD', 'RAD', 'SAD', 'PBD', 'QBD', 'RBD', 'SBD', 'PCD', 'QCD', 'RCD', 'SCD', 'PAE', 'QAE', 'RAE', 'SAE', 'PBE', 'QBE', 'RBE', 'SBE', 'PCE', 'QCE', 'RCE', 'SCE', 'PAF', 'QAF', 'RAF', 'SAF', 'PBF', 'QBF', 'RBF', 'SBF', 'PCF', 'QCF', 'RCF', 'SCF']
    assert len(mnemonics('723')) == 36
    assert subsets('ABC') == set(['ABC', 'AB', 'AC', 'A', 'BC', 'B', 'C', ''])
    print generate_binary_code(3)
    assert set(generate_binary_code(3)) == set([[0, 0, 0], [1, 0, 0], [0, 1, 0], [1, 1, 0], [0, 0, 1], [1, 0, 1], [0, 1, 1], [1, 1, 1]])

if __name__ == '__main__':
    exit(test())
