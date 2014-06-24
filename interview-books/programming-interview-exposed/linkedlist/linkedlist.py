# Linked list problems from http://cslibrary.stanford.edu/105/LinkedListProblems.pdf


class Node(object):
    def __init__(self, val):
        self.val = val
        self._next = None

    def __str__(self):
        node = self
        to_return = "["
        while node:
            to_return += str(node.val)
            if node._next is not None:
                to_return += ', '
            node = node._next
        to_return += "]"
        return to_return

    def __repr__(self):
        return str(self)


# count the number of times that int occur in the list
# 1
def count(node, i):
    r = 0
    while node:
        if node.val == i:
            r += 1
        node = node._next
    return r

# Write a GetNth() function that takes a linked list and an integer index and returns the data value stored in the node at that index position.

#2
def get_nth(node, idx):
    """
    Error if it's invalid idx, otherwise return the idx's val
    """
    cur_idx = 0
    while node:
        if cur_idx == idx:
            return node
        node = node._next
        cur_idx += 1
    raise ValueError("Invalid index")


#5
def insertNth(node, idx, val):
    cur = Node(val)
    if idx == 0:
        cur._next = node
        return
    pre = get_nth(node, idx-1)
    pre._next, cur._next = cur, pre._next

#6 ? how to update the node'head when inserting in the front
def sorted_insert(node, val):
    """
    given a list that is sorted in increasing order, and a
    single node, inserts the node into the correct sorted position in the list
    """
    pre, cur = None, node
    while cur:
        if val < cur.val:
            break
        pre, cur = cur, cur._next
    to_insert = Node(val)
    to_insert._next = cur
    if pre is not None:
        pre._next = to_insert

#7
def insert_sort(node):
    """
    given a list, rearranges its nodes so they are sorted in increasing order.
    It should use SortedInsert()
    """
    to_return = Node(node.val)
    cur = node._next
    while cur:
        sorted_insert(to_return, cur.val)
        cur = cur._next
    return to_return

def append(a, b):
    """
    append b to a, and set b to empty
    find the tail, and connect a's tail to b's head.
    """
    while a:
        a = a._next
    a._next = b
    b = None

def front_back_split(node):
    """
    given a list, split them in half, if the length is odd, the extra
    element should go in the front list
    """
    length = _get_length(node)
    mid_idx = length / 2
    if not length % 2 == 0:
        mid_idx += 1

    front = node
    back = get_nth(node, mid_idx)
    get_nth(node, mid_idx-1)._next = None
    return (front, back)

def _get_length(node):
    r = 0
    while node:
        node = node._next
        r += 1
    return r

def redup(node):
    """
    takes a list sorted in increasing order and delete any duplicate
    nodes from the list. Ideally, should only traversed the list once.
    """
    #because it's sorted, we only have to remove the items are
    #duplicated next to each other
    while node and node._next:
        if node.val == node._next.val:
            node._next = node._next._next
            node._next = None
        node = node._next
    return node


def move_node(n1, n2):
    """
    takes two lists, pop the front of the second list, and push it
    on the front of the first list
    """
    n2 = n2._next
    n2._next = None
    h2 = n2
    h2._next = n1
    n1 = h2

def alternating_split(node):
    """given a list, split its nodes into two shorter lists.
    if we number the elements 0, 1, 2, .. then all the even elems
    should go in the first, others in odd.
    """
    odd, even = None
    idx = 0
    while node:
        target = even if idx % 2 == 0 else odd
        move_node(target, node)
    return odd, even

def shuffle_merge(n1, n2):
    """
    {1,2,3}, {7, 13, 1} => {1, 7, 2, 13, 3, 1}
    if neither list runs out, all the nodes should be taken from other list
    """
    #to_return = n1
    #source = n1
    #while n1:
    #    n1 = n1._next
    #    n2 = n2._next
    #    source = n1 if source == n2 else n1
    #    move_node(to_return, source)


def sorted_merge():
    pass

def merge_sort():
    pass

def sorted_intersect():
    """docstring for sorted_intersect"""
    pass

def reverse(node):
    pre, cur = None, node
    while cur:
        tmp = cur._next
        cur._next = pre
        pre = cur
        cur = tmp
    return pre

def recursive_reverse(node):
    if node is None:
        return None
    if node._next is None:
        return node
    rest = recursive_reverse(node._next)
    rest._next = node
    node._next = None
    return rest

# --- Following are linkedlist problems from cracking the interview 5th page 190

def unsorted_redup(node):
    """
    remove duplicates items from unsorted linkedlist
    {3, 2, 2, 3, 1, 3, 4, 9}
    hashtable?
    loop through
    """
    appeared = {}
    pre = None
    root = node
    while node:
        if node.val not in appeared:
            appeared[node.val] = True
        else:
            pre._next = node._next
            node = node._next
        pre = node
        node = node._next
    return root

def unsorted_redup_no_buffer(node):
    """
    pointer 1: current node
    pointer 2: iterate throught all the nodes
    """
    root = cur = other = node
    while cur:
        other = cur
        while other:
            if other.val == other._next.val:
                other._next = other._next._next
            other = other._next
        cur = cur._next
    return root

# ---- haven't check the solutions yet
def kth(node, i):
    """
    find the kth to the last elems of the list
    """
    idx = 0
    while node:
        node = node._next
        idx += 1
        if i == idx:
            return node

def delete_middle(node):
    """
    Delete a node in the middle of the linkedlist
    must assume the length in odd
    """
    length = _get_length(node)
    idx = length / 2
    i = 0
    root = node
    while node._next:
        if i == idx:
            node._next = node._next._next
            break
        node = node._next
        i += 1
    print root

def partition(node, val):
    front = back = None
    root = node
    while node:
        cur = node
        if cur.val < val:
            if front is None:
                front = Node(val)
            else:
                front._next = cur
        else:
            if back is None:
                back = Node(val)
            else:
                cur._next = back
                back = cur
        node = node._next
    return root

#2.5
#a)
def sum_of_reverse(n1, n2):
    r1 = _reversed(n1)
    r2 = _reversed(n2)
    return sum([reduce(lambda x, y: x*10 + y, r) for r in [r1, r2]])

def _reversed(node):
    if node is None:
        return None
    if node._next is None:
        return [node.val]
    rest = _reversed(node._next)
    return rest + [node.val]

#2.5
#b)
def sum_of_reverse2(n1, n2):
    return _get_sum(n1, 0) + _get_sum(n2, 0)

def _get_sum(node, acc):
    if node._next is None:
        return acc + node.val
    return _get_sum(node._next, (acc + node.val)*10)

#2.6
def circular_head(node):
    """
    return the head of the circular linkedlist
    A -> B -> C -> D -> E -> C  => C
    """
    pass

#2.7
def ispal(node):
    """
    chck if a linked list is a palindrome
    """
    return reverse(node) == node

def test():
    node = Node(2)
    sorted_insert(node, 3)
    sorted_insert(node, 3)
    sorted_insert(node, 5)
    sorted_insert(node, 7)
    sorted_insert(node, 7)
    sorted_insert(node, 8)

    print node
    dep = unsorted_redup(node)
    print dep

    reversed_node = reverse(node)
    print reversed_node

    n1 = n2 = reversed_node
    assert sum_of_reverse(n1, n2) == 23578 * 2
    assert sum_of_reverse2(n1, n2) == 87532 * 2
    recursive_reverse(reversed_node)

    front_back_split(node)

if __name__ == "__main__":
    test()
