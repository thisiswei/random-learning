{- why this aint right?
count :: Int -> Int
count n = count' n [1, 2, 3]

count' :: Int -> [Int] -> Int
count' n [] = 0
count' 0 _ = 1
count' n steps | n < 0     = 0
               | otherwise = count' (n - (head steps)) steps + (count' n (tail steps))
-}

-- 9.1 A child is running up a staircase with n steps, and can hop either 1
-- step, 2 step or 3, count how many possible ways to run up the stairs
count'' n | n < 0     = 0
          | n == 0    = 1
          | otherwise = count'' (n-1) + count'' (n-2) + count'' (n-3)

-- 9.2
ways :: Int -> Int -> Int -> Int -> Int
ways i j x y | i == x    = 1
             | j == y    = 1
             | otherwise = (ways i (j+1) x y) + (ways (i+1) j x y)

-- 9.3
magic :: [Int] -> Int
magic xs = magic' xs 0 (length xs - 1)

magic' :: [Int] -> Int -> Int -> Int
magic' [] _ _ = -1
magic' xs s e | idx == val = val
              | val < idx      = magic' xs idx e
              | otherwise      = magic' xs 0 idx
  where
    idx   = (s + e) `div` 2
    val   = xs !! idx

-- 9.4
subsets :: [Int] -> [[Int]]
subsets [] = [[]]
subsets (x:xs) = subs ++ map (x:) subs
  where subs = subsets xs

-- 9.5
perms :: [Int] -> [[Int]]
perms [] = [[]]
perms xs = [ x:p | x <- xs, p <- perms $ removed x xs ]
  where removed _ [] = []
        removed y (y':ys) | y == y'   = ys
                          | otherwise = y' : removed y ys

-- 9.6? parentheses 3 == [((()))), (()()), (())(), ()(()), ()()()]
parentheses 0 = ""
parentheses 1 = "()"

-- 9.7? didn't even understand the questions

-- 9.8
cc :: Int -> Int
cc n = cc' n [25, 10, 5, 1]

cc' :: Int -> [Int] -> Int
cc' _ [] = 0
cc' 0 _ = 1
cc' n xs | n < 0     = 0
         | otherwise = cc' (n - head xs) xs + cc' n (tail xs)

-- 9.9  ?
-- print all ways of arranging eight queens on 8 X 8 chess board

-- 9.10 ?
type Box = (Int, Int, Int)

-- maxH :: [Box] -> Int
-- push onto stack
-- put the maximum on bottom, then next maximum untils there is no way to do it
maxHWD :: [Box] -> Box
maxHWD [] = []
maxHWD xs = max (map (\x -> max x) xs)

-- 9.11 ?
