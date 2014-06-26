module BinTree (BinTree, emptyTree, inTree, addTree, delTree, buildTree, inorder) where

data (Ord a) => BinTree a = EmptyBT
                          | NodeBT a (BinTree a) (BinTree a)

inTree :: (Ord a, Show a) => a -> BinTree a -> Bool
inTree EmptyBT _ = False
inTree (NodeBT v lf rt) v' | v == v'    = True
                           | v' < v     = inTree lf
                           | otherwise  = inTree rt

addTree :: (Ord a, Show a) => a -> BinTree a -> Bool
addTree EmptyBT v = NodeBT v EmptyBT EmptyBT
addTree n@(NodeBT v lf rt) v' | v == v'   = n
                            | v' > v    = NodeBT v lf (addTree rt v')
                            | otherwise = NodeBT v (addTree lf v') rt

buildTree lf = foldr addTree EmptyBT lf

buildTree' [] = EmptyBT
buildTree' lf = NodeBT x (buildTree' l1) (buildTree l2)
where l1 = take n lf
      (x:l2) = drop n lf
      n  = (length lf) `div` 2

inorder EmptyBT = []
inorder (NodeBT v lf rt) = inorder lf ++ [v] ++ inorder rt

delNode EmptyBT _ = EmptyBT

delNode (NodeBT v lf EmptyBT) v' | v == v' = lf
delNode (NodeBT v EmptyBT rt) v' | v == v' = rt

delNode (NodeBT v lf rt) v' | v > v'     = NodeBT v lf (delNode rt)
                            | v < v'     = NodeBT v (delNode lf) rt
                            | otherwise  = NodeBT k lf (delNode k rt)
  where k = minT rt
        minT (NodeBT v EmptyBT _) = v
        minT (NodeBT _ lf _) = minT lf
