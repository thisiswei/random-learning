fib = 1:1:[ (a+b) | (a, b) <- zip fib (tail fib) ]

data Tree a = Leaf a
            | Branch (Tree a) (Tree a)

fringe :: Tree a -> [a]
fringe (Leaf x) = [x]
fringe (Branch left right) = fringe left ++ fringe right

{-
type String  = [Char]
type Person  = [Name, Address]
type Name  = String
data Address  =  None | Addr String
-}

quicksort [] = []
quicksort (x:xs) = quicksort x' ++
                   [x]          ++
                   quicksort xs'
  where x'  = [ y | y <- xs, y < x ]
        xs' = [ y | y <- xs, y > x ]

{-
take 0 _ = []
take _ [] = []
take n (x:xs) = x : (take (n-1) xs)
-}

data Point = Pt {pointx, pointy :: Float}

showTree :: (Show a) => Tree a -> String
showTree (Leaf a) = show a
showTree (Branch l r) = showTree l ++ showTree r

-- readsTree ('<' : s) = [(Branch l r, u) | (l, "|":t) <- readsTree s,
--                                          (r, ">":u) <- readsTree t]
-- readsTree s = [(Leaf x, t) | x, t <- reads s]

-- a = [1, 2, 3] >>= (\ x -> [1, 2, 3]) >>= (\ y -> return (x /= y)) >>= (\r -> case r of True -> return (x, y) _   -> fail "")))

mvLift2 :: (a -> b -> c) -> [a] -> [b] -> [c]
mvLift2 f x y = do x' <- x
                   y' <- y
                   return (f x' y')
