class Node(object):
    def __init__(self, val):
        self.val = val
        self.left = None
        self.right = None

def find_node(Node, val):
    if Node is None:
        return None
    if Node.val == val:
        return Node
    elif val > Node.val:
        return find_node(Node.right, val)
    return find_node(Node.left, val)
