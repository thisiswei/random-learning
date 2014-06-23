from collections import defaultdict

def find_non_repeated(string):
    """
    find the first nonrepeated character in a string.
    """
    d = defaultdict(int)
    for s in string:
        d[s] += 1
    for s in string:
        if d.get(s) == 1:
            return s

def remove_chars(string, remove):
    """
    >>> remove_chars("Battle of the Vowels: Hawaii VS. Grozny", "aelou")
    "Bttl f th Vwls: Hw VS. Grzny"
    """
    to_return = []
    for s in string:
        if s not in remove:
            to_return.append(s)
    return to_return

def reverse_words(sentence):
    """
    >>> reverse_words("Do or do not, there is no try.")
    "try. no is there not, do or Do"
    """
    return " ".join(reversed(sentence.split()))

def string_to_int(string):
    """
    >>> string_to_int("30")
    30
    """
    zero = ord('0')
    return reduce(lambda x, y: x*10 + y, [ord(s) - zero for s in string])

def int_to_string(n):
    """
    >>> int_to_string(37)
    "37"
    """
    seq = helper(n)
    print seq
    zero = ord('0')
    return ''.join(map(lambda i: chr(zero + i - 0), seq))

def helper(i):
    if i < 10:
        return [i]
    d, r = divmod(i, 10)
    return helper(d) + [r]


def test():
    print find_non_repeated("total")
    print find_non_repeated("teeter")
    assert string_to_int("137") == 137
    assert int_to_string(137) == "137"
    print "pass"

test()
