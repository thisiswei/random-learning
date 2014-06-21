import Data.List

perms :: [Int] -> [[Int]]
perms [] = [[]]
perms xs = [ (x:xs') | x <- xs, xs' <- subsets $ delete x xs ]

subsets :: [Int] -> [[Int]]
subsets [] = [[]]
subsets (x:xs) = subs ++ [ x:sub | sub <- subs]
  where subs = subsets xs
