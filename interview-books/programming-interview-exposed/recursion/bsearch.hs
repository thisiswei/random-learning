import Data.List

bsearch :: [Int] -> Int -> Int
bsearch xs x | x `notElem` xs  = error "wtf"
             | x == mid        = mid
             | x < mid         = bsearch l x
             | otherwise       = bsearch r x
  where mid = xs !! (length xs `div` 2)
        l   = takeWhile (\y -> y /= mid) xs
        r   = dropWhile (\y -> y /= mid) xs

perms :: Eq a => [a] -> [[a]]
perms []     = [[]]
perms xs = [ x:p | x <- xs, p <- perms (removed x xs) ]
  where removed :: Eq a => a -> [a] -> [a]
        removed _ []      = []
        removed x' (x:xs) | x' == x   = xs
                          | otherwise = x : removed x' xs

subsets []     = [[]]
subsets (x:xs) = subs ++ [ x:sub | sub <- subs ]
  where subs = subsets xs
