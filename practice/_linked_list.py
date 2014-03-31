class Node(object):
    def __init__(self, val):
        self.val = val
        self.next_ = None

    def __repr__(self):
        val = str(self.val)
        if self.next_ is None:
            return val
        return val + ',' + str(self.next_)

def _is_head(pre):
    return pre is None

def _is_tail(cur):
    return cur is None

class LinkedList(object):
    def __init__(self, *args):
        self.head = None
        self.tail = None
        if args:
            map(lambda val: self.append(val), args)

    def __repr__(self):
        return str(self.head)

    def delete(self, idx):
        prev = self._find_pre(idx)
        cur = prev.next_
        if prev is None:
            del cur
            return
        prev.next_ = cur.next_

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
        cur = self.head
        node = Node(val)
        pre = None
        while cur:
            if cur.val >= val:
                if pre is None:
                    self.head = node
                else:
                    pre.next_ = node
                node.next_ = cur
                return
            pre, cur = cur, cur.next_
        if self.head is None:
            self.head = node
            return
        self.tail.next_, self.tail = node, node

    def insert(self, idx, val):
        node = Node(val)
        pre = self._find_pre(idx)
        if pre is None:
            self.head, node.next_ = node, self.head
        else:
            pre.next_, node.next_ = node, pre.next_
            if node.next_ is None:
                self.tail = node

    def _find_pre(self, idx):
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
        return None if self.head is None else helper(None, 0)

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

def test():
    lis = LinkedList(3, 2, 4, 9, 10)
    print lis

    lis.reverse_recursive()
    print 'lis reversed'
    print lis

    lis.insert(3, 12)
    print 'inserted(3, 12)'
    print lis

    lis.insert(0, 100)
    lis.insert(6, 9)
    lis.insert(8, 88)
    lis.sort()
    lis.sorted_insert(0)
    lis.sorted_insert(111)
    print lis


if __name__ == '__main__':
    exit(test())
