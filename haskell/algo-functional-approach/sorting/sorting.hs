import PQueue
import BinTree

selection :: (Ord a) => [a] -> [a]
selection [] = []
selection xs = m : (delete m xs)
  where m = minimum xs
        delete _ []      = []
        delete x (x':xs) | x == x' = xs
                         | otherwise = x' : (delete x xs)

quick :: (Ord a) => [a] -> [a]
quick [] = []
quick (x:xs) = quick lesser ++ [x] ++ quick bigger
  where lesser = [ x' | x' <- xs, x' <= x ]
        bigger = [ x' | x' <- xs, x' > x ]

quick' :: (Ord a) => [a] -> [a] -> [a]
quick' [] s = s
quick' (pivot:rest) s = quick' lower (pivot : (quick' upper s))
  where lower = [ x | x <- rest, x <= pivot ]
        upper = [ x | x <- rest, x > pivot ]

isort :: (Ord a) => [a] -> [a]
isort [] = []
isort (x:xs) = insert x (isort xs)
insert x xs = takeWhile (<= x) xs ++ [x] ++ dropWhile (<= x) xs
insert' y b@(y':ys) | y < y' = y : b
                    | y > y' = y' : (insert' y ys)

isort' xs = foldr insert [] xs

msort :: (Ord a) => [a] -> [a]
msort [] = []
msort [x] = [x]
msort xs = merge (msort lf) (msort rt)
  where n = length xs `div` 2
        lf = take n xs
        rt = drop n xs

merge x [] = x
merge [] y = y
merge l@(x:xs) r@(y:ys) | x > y = y : (merge l ys)
                        | otherwise = x : merge xs r

msort' :: (Ord a) => [a] -> [a]
msort' = ms . split
  where ms [r] = r
        ms l   = ms (mergePairs l)
        mergePairs [] = []
        mergePairs [x] = [x]
        mergePairs (x:x':rest) = (merge x x') : mergePairs rest

split [] = []
split (x:xs) = [x] : split xs

mkPQ :: (Ord a) => [a] -> PQueue a
mkPQ xs = foldr enPQ emptyPQ xs

hsort :: (Ord a) => [a] -> [a]
hsort xs = hsort' (mkPQ xs)
  where hsort' x | (pqEmpty x) = []
                 | otherwise   = (frontPQ x) : (hsort' (dePQ x))

tsort :: (Ord a) => [a] -> [a]
tsort xs = (inorder . buildTree) xs
