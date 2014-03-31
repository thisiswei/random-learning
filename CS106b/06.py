#Hanoi move tower
def move(size, start='L', using='M', end='R'):
    if len(size) == 1:
        return [size[0] + ',' + start + '->' + end]
    return move(size[:-1], start, end, using) + move(size[-1], start, using, end) + move(size[:-1], using, start, end)

print move('123')




