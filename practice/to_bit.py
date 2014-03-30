def to_bit(n):
    bits = _get_bit_size(n)
    to_return = [0 for _ in range(bits)]
    for i in reversed(range(bits)):
        if n >= 2 ** i:
            to_return[i] = 1
            n -= 2 ** i
    return to_return[::-1]

def _get_bit_size(n, d=8):
    if 2 ** d - 1 >= n:
        return d
    return _get_bit_size(n, 2 * d)

print to_bit(13)
print to_bit(255)
print to_bit(256)
