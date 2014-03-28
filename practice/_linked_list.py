class Node(object):
    def __init__(self, val):
        self.val = val
        self.next_ = None

    def __repr__(self):
        return str(self.val)

def _is_head(pre):
    return pre is None

def _is_tail(cur):
    return cur is None

class LinkedList(object):
    def __init__(self):
        self.head = None
        self.tail = None

    def delete(self, idx):
        prev = self._find_pre_idx_elem(idx)
        cur = prev.next_
        if prev is None:
            del cur
            return
        prev.next_ = cur.next_
        del cur

    def append(self, val):
        node = Node(val)
        if self.head is None:
            self.head = self.tail = node
            return
        self.tail.next_ = node
        self.tail = node

    def sort(self):
        cur = self.head
        swapped = True
        while swapped:
            cur = self.head
            swapped = False
            while cur:
                succ = cur.next_
                if succ and cur.val > succ.val:
                    cur.val, succ.val = succ.val, cur.val
                    swapped = True
                cur = succ

    def sorted_insert(self, val):
        self.sort()
        pre, cur = None, self.head
        if self.head is None:
            self.insert(0, val)
            return
        node = Node(val)
        while cur:
            if val <= cur.val:
                node.next_ = cur
                if pre is not None:
                    pre.next_ = node
                else:
                    self.head = node
                return
            pre, cur = cur, cur.next_
        if val > pre.val:
            self.tail.next_ = node
            self.tail = node

    def insert(self, idx, val):
        node = Node(val)
        if self.head is None and self.tail is None:
            self.head = self.tail = node
            return
        pre = self._find_pre_idx_elem(idx)
        if _is_head(pre):
            self.head, node.next_ = node, self.head
            return
        cur = pre.next_
        if _is_tail(cur):
            self.tail.next_, self.tail = node, node
            return
        pre.next_ = node
        node.next_ = cur
        return

    def _find_pre_idx_elem(self, idx):
        def helper(pre, cnt):
            if cnt == idx:
                return pre
            cur = self.head if pre is None else pre.next_
            if cur is None:
                if idx == cnt + 1:
                    return pre
                else:
                    raise ValueError('invalid index')
            return helper(cur, cnt+1)
        return helper(None, 0)

    def reverse_recursive(self):
        def helper(head):
            parent = head.next_
            if parent is None:
                return head
            rest = helper(parent)
            rest.next_ = head
            head.next_ = None
            return head
        head = self.head
        helper(head)
        self.head, self.tail = self.tail, self.head

    def __repr__(self):
        return '[' + ','.join(map(str, self._get_list())) + ']'

    def _get_list(self):
        to_return = []
        cur = self.head
        while cur:
            to_return.append(cur.val)
            cur = cur.next_
        return to_return

def test():
    lis = LinkedList()
    lis.append(3)
    lis.append(2)
    lis.append(4)
    lis.append(9)
    lis.append(10)

    assert lis._get_list() == [3, 2, 4, 9, 10]
    lis.reverse_recursive()
    assert lis._get_list() == [10, 9, 4, 2, 3]
    lis.insert(3, 12)
    assert lis._get_list() == [10, 9, 4, 12, 2, 3]
    lis.insert(0, 100)
    assert lis._get_list() == [100, 10, 9, 4, 12, 2, 3]
    lis.insert(6, -1)
    assert lis._get_list() == [100, 10, 9, 4, 12, 2, -1, 3]
    lis.delete(2)
    assert lis._get_list() == [100, 10, 4, 12, 2, -1, 3]
    lis = LinkedList()
    lis.insert(0, 100)
    assert lis._get_list() == [100]
    lis.insert(1, 200)
    assert lis._get_list() == [100, 200]

    lis = LinkedList()
    lis.sorted_insert(8)
    lis.insert(1, 2)
    lis.append(1)
    lis.append(5)
    lis.append(0)
    lis.sort()
    lis.sorted_insert(4)
    assert lis._get_list() == [0, 1, 2, 4, 5, 8]
    lis.sorted_insert(10)
    assert lis._get_list() == [0, 1, 2, 4, 5, 8, 10]
    lis.sorted_insert(-1)
    assert lis._get_list() == [-1, 0, 1, 2, 4, 5, 8, 10]

if __name__ == '__main__':
    exit(test())
