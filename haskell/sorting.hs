import Data.List

{-
  [0, 1, 1, 2 ,3, 4]

    *
  * * * * *
  -------------------
  0,1,2,3,4,5,6,7,8,9
-}

histgram [] = ""
histgram lst = unlines $ (transpose p) ++ ["=========", "0123456789"]
  where
    p :: [String]
    p   = map (\c -> take max $ repeat ' ' ++ replicate c '*' ) cnts
    cnts :: [Int]
    cnts = map (\c -> length $ elemIndices c lst) [0..9]
    max  = maximum cnts


-- heapsort
-- radixsort
-- treesort

-- selectionSort
-- swap the current with the mininum
ssort [] = []
ssort xs = m : ssort (delete m xs)
  where m = minimum xs


-- insertSort
isort []        = []
isort [x]       = [x]
isort (x:xs)    = insert x $ isort xs
  where
    insert      :: (Ord a) => a -> [a] -> [a]
    insert y ys = takeWhile (<= y) ys ++ [y] ++ dropWhile (<=y) ys



qsort [] = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort bigger
  where smaller = [ n | n <- xs, n <= x ]
        bigger  = [ n | n <- xs, n > x ]

msort :: [Int] -> [Int]
msort ls = merge l r
  where l = take n ls
        r = drop n ls
        n = length ls

merge [] x          = x
merge x []          = x
merge a@(x:xs) b@(y:ys) | x <= y    = x : (merge xs b)
                        | otherwise = y : (merge a ys)

bsort :: [Int] -> [Int]
bsort [] = []
bsort [x] = [x]
bsort lst = let lst' =  (bubble lst) in
                case (lst' == lst) of
                  False -> bsort lst'
                  _     -> lst'
  where
    bubble (x:y:xs) | x <= y    = x : bubble (y:xs)
                    | otherwise = y : bubble (x:xs)
    bubble [x] = [x]


{-
 -- First version of Bubble Sort (a).
bsort''::(Ord a) => [a] -> [a]
bsort'' []  = []
bsort'' [x] = [x]
bsort'' xs  = let (xs',last) = bubble(xs) in bsort xs'++[last]
    where
    -- bubble down and return the last element separately
    bubble [last]   = ([],last)
    bubble (x:y:xs)
        | x <= y    = let (xs',last) = bubble(y:xs) in (x:xs',last)
        | otherwise = let (xs',last) = bubble(x:xs) in (y:xs',last)

-- Second version that ends if nothing has been swapped (b).
bsort'::(Ord a) => [a] -> [a]
bsort' []  = []
bsort' [x] = [x]
bsort' xs  = let (xs',last,changed) = bubble(xs)
                 in if changed then bsort xs'++[last]
                    else xs'++[last]
    where
    -- bubble down, return the last element and indicate change
    bubble [last]   = ([],last,False)
    bubble (x:y:xs)
        | x <= y    = let (xs',last,changed) = bubble(y:xs)
                          in (x:xs',last,changed)
        | otherwise = let (xs',last,_) = bubble(x:xs)
                          in (y:xs',last,True)
-}
