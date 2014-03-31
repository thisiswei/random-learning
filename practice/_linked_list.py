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

def test():
    lis = LinkedList(3, 2, 4, 9, 10)
    print lis

    lis.reverse_recursive()
    print 'lis reversed'
    print lis

    lis.insert(3, 12)
    print 'inserted(3, 12)'
    print lis

if __name__ == '__main__':
    exit(test())
