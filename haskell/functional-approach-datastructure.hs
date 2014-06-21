(x:_) !! 0 = x
(_:xs) !! n = xs !! (n-1)

reverse [] = []
reverse (x:xs) = (reverse xs) ++ x

elem x [] = False
elem x (y:ys) | x == y = True
              | otherwise = elem x ys

maximum [x] = x
maximum (x:y:ys) | x > y = maximum (x:ys)
                 | otherwise = maximum (y:ys)

concat [] = []
concat ([]:xs) = concat xs
concat ((x:xs):ys) = x : concat (xs:ys)

zip (x:xs) (y:ys) = (x, y) : zip(xs, ys)
zip _ _ = []

unzip [] = []
unzip ((x,y) : ps) = (x:xs , y:ys) where (xs, ys) = unzip ps

removeDups [] = []
removeDups ((x:y):ys) | x == y = removeDups ys
                      | otherwise = x : removeDups (y:ys)

rem34 lab@(a:b:c:d:xs) | c == d = (a:b:xs)
                       | otherwise = lab

perms [] = []
perms xs = [ (x:ps) | x <- xs, ps <- perms (removedFirst x xs) ]
  where removedFirst x []                 = []
        removedFirst x (y:ys) | x == y    = ys
                              | otherwise = y : removedFirst x ys

foldr f b []     = b
foldr f b (x:xs) = f x (foldr f b xs)

map f xs = foldr (\x ys -> (f x) : ys) [] xs

foldl f b []     = b
foldl f b (x:xs) = foldl f (f b x) xs

sumll xss = foldl (foldl (+)) 0 xss

listDiff l1 l2 = foldl delete l1 l2
  where delete [] _ = []
        delete (x:xs) y | x == y = x : (delete xs y)

data Tree a = Node a [Tree a] deriving show
data BinTree a = Empty | NodeBT a (BinTree a) (BinTree a)
  deriving show

tsum Empty = 0
tsum (NodeBT a lf rt) = a + (tsum lf) + (tsum rt)

data BinTree' a = Leaf a | NodeBT' a (BinTree' a) (BinTree' a)
  deriving show

tsum' :: BinTree' Int -> int
tsum' (Leaf v) = v
tsum' (NodeBT v lf rt) = v + (tsum' lf) + (tsum' rt)

preorder :: BinTree a -> [a]
preorder Empty = []
preorder (NodeBT a lf, rt) = [a] ++ preorder lf  ++ preorder rt

import array

fibs n = a
  where a = array (1, n) ([(1,1), (2, 1)] ++
                          [(i, a!(i-1) + a!(i-2)) | i <- [3..n]])

