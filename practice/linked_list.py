class Node(object):
    def __init__(self, val):
        self.val = val
        self.next_ = None

    def __repr__(self):
        return str(self.val)

class LinkedList(object):
    def __init__(self):
        self.head = None
        self.tail = None

    def __repr__(self):
        return '[' + ','.join(map(str, self._get_list())) + ']'

    def _get_list(self):
        to_return = []
        cur = self.head
        while cur:
            to_return.append(cur.val)
            cur = cur.next_
        return to_return

    def add_node(self, val):
        node = Node(val)
        if self.head is None:
            self.head = node
        if self.tail is None:
            self.tail = node
        else:
            self.tail.next_ = node
            self.tail = node

    def append(self, val):
        self.add_node(val)

    def insert(self, insert_idx, val):
        # [10,9,4,2,3]
        # lis.insert(2,11)
        # lis
        # [10,9,4,11,3]
        prev, cur = self.find_prev_and_cur(insert_idx)
        node = Node(val)
        if prev is None and cur is None:
            self.head = node
            return
        if prev is None:
            self.head = node
            node.next_ = cur
            return
        prev.next_ = node
        node.next_ = cur

    def delete(self, idx):
        prev, cur = self.find_prev_and_cur(idx)
        if prev is None:
            del cur
            return
        prev.next_ = cur.next_
        del cur

    def reverse(self):
        d = self.get_cur_to_prev_map()
        cur = self.tail
        while cur:
            prev = d.get(cur)
            cur.next_ = prev
            cur = prev
        self.head, self.tail = self.tail, self.head

    #how to make this work
    #def reverse(self):
    #    self.tail = cur = self.head
    #    while cur and cur.next_ is not None:
    #        tmp_next = cur.next_
    #        swap(cur, cur.next_)
    #        #cur, cur.next_ = cur.next_, cur
    #        cur = tmp_next
    #    self.head = cur
    #    self.tail.next_ = None

    #def reverse_recur(self):
    #    if self.head is None or self.head == self.tail:
    #        return self
    #    head, neck, rest = self.divide()
    #    neck.next_

    def reverse(self):
        pass

    def sorted_insert(self, val):
        """
        [3, 1, 5, 4], 6 -> [1, 3, 4, 5, 6]

        [3, 1, 1, 4], 2 -> [1, 3, 4, 5, 6]
        3.next_ -> 1
        """
        d = self.get_cur_to_prev_map()
        cur = self.tail
        prev = d.get(cur)
        while cur and prev:
            if prev > cur:
                swap(prev, cur)
            self.should_insert(prev, cur, val)
            cur = prev
        #update(head and tail)

    def should_insert(prev, cur, val):
        node = Node(val)
        front = min(prev, cur, key=lambda x: x.val)
        back = min(prev, cur, key=lambda x: x.val)
        if front.val < val < back.val:
            prev.next_ = node
            node.next_ = cur.next_

    def find_prev_and_cur(self, idx):
        cnt = 0
        prev, cur = None, self.head
        while cur and cur.next_:
            if idx == cnt:
                return prev, cur
            prev, cur = cur, cur.next_
            cnt += 1
        if cnt != idx:
            if cnt + 1 == idx:
                return cur, None
            else:
                raise ValueError('bitch')
        return prev, cur

    def get_cur_to_prev_map(self):
        d = {}
        cur = self.head
        cur.next_
        while cur and cur.next_:
            d[cur.next_] = cur
            cur = cur.next_
        return d

def swap(cur, next_):
    next_.next_ = cur

def test():
    lis = LinkedList()
    lis.add_node(3)
    lis.add_node(2)
    lis.add_node(4)
    lis.append(9)
    lis.append(10)
    assert lis._get_list() == [3, 2, 4, 9, 10]
    lis.reverse()
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

test()
