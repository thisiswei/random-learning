"""
If the recursive decomposition doesn’t end up violating the rules, everything
should be okay.

The first rule—that only one disk can be moved at a time—is not an
issue. If there is more than a single disk, the recursive decomposition breaks the problem
down to generate a simpler case. The steps in the pseudocode that actually transfer disks
move only one disk at a time.

The second rule—that you are not allowed to place a larger
disk on top of a smaller one—is the critical one. You need to convince yourself that you
will not violate this rule in the recursive decomposition.
"""

#Hanoi move tower
def move(size, start='L', using='M', end='R'):
    if len(size) == 1:
        return [size[0] + ',' + start + '->' + end]
    return move(size[:-1], start, end, using) + move(size[-1], start, using, end) + move(size[:-1], using, start, end)

print move('123')




