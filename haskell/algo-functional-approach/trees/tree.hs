data BinTree a = Empty | NodeBT a (BinTree a) (BinTree a)
  deriving Show

count_depth' :: BinTree a -> (Int, Int)
count_depth' Empty = (1, 0)
count_depth' (NodeBT v lf rt) = (c1 + c2, 1 + (max d1 d2))
  where (c1, d1) = count_depth' lf
        (c2, d2) = count_depth' rt

inorder Empty = []
inorder (NodeBT a lf rt) = inorder lf ++ [a] ++ inorder rt

inorder' node = inorder'' node []
  where
    inorder'' Empty z = z
    inorder'' (NodeBT a lf rt) z = inorder'' lf (a:(inorder'' rt z))

data BinTree'' a = Leaf'' a
                 | NodeBT'' (BinTree'' a) (BinTree'' a)

flipT :: BinTree'' a -> BinTree'' a
flipT (NodeBT'' a b) = NodeBT'' (flipT b) (flipT a)
flipT x@(Leaf'' a) = x

tinsert :: a -> BinTree a -> BinTree a
tinsert v Empty = NodeBT Empty v Empty
tinsert v (NodeBT w lf rt)
  | (size lf) <= (size rt) = NodeBT w (tinsert v lf) rt
  | otherwise              = NodeBT w lf (tinsert v rt)

size :: BinTree -> Int
size Empty = 0
size (NodeBT lf _ rt) = 1 + (size lf) + (size rt)

data BinTreeSz a = EmptySz
                 | NodeBTSz (Int, Int) (BinTreeSz a) (BinTreeSz a)

tinsertSz :: a -> BinTreeSz a -> BinTreeSz a
tinsertSz v EmptySz = NodeBTSz (0, 0) v EmptySz EmptySz
tinsertSz v (NodeBTSz (s1, s2) w lf rt)
  | s1 <= s2  = NodeBTSz (s1+1, s2) w (tinsertSz v lf) rt
  | otherwise = NodeBTSz (s1, s2+1) w lf (tinsertSz v rt)


