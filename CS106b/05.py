def digit_sum(n):
    def helper(n):
        if n < 10:
            return n
        p, r = divmod(n, 10)
        return r + helper(p)
    return helper(n)

def digit_root(n):
    def helper(n, steps):
        if n < 10:
            return steps
        return helper(digit_sum(n), steps+1)
    return helper(n, 0)

def C(n, k):
    if n == 0 or k == 0 or n == k:
        return 1
    return C(n-1, k-1) + C(n-1, k)

def reverse_string(s):
    if len(s) == 1:
        return s
    return reverse_string(s[1:]) + s[0:1]

def reverse_string2(s):
    L = len(s)
    if L == 1 or L == 0:
        return s
    return s[-1] + reverse_string2(s[1:-1]) + s[0]

def test():
    assert digit_sum(1729) == 19
    assert digit_root(1729) == 3
    assert C(6, 2) == 15
    assert reverse_string('blahblahhhh') == reverse_string2('blahblahhhh') == ''.join(reversed('blahblahhhh'))
    print 'pass'

if __name__ == '__main__':
    exit(test())
