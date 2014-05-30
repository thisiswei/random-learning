import Data.List

-- 1. last
myLast [x] = x
myLast (x:xs) = myLast xs

-- 2. myButLast
myButLast = last . init

-- 3. element-at
elementAt (x:xs) 1 = x
elementAt (x:xs) n = elementAt xs (n-1)

-- 4. myLength
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

-- 5. myReverse
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

-- 6. isPalindrome
isPalindrome [] = True
isPalindrome xs = reverse xs == xs

-- 7. flatten
data NestedList a = Elem a | List [NestedList a]

flatten (Elem a) = [a]
flatten (List x) = concatMap flatten x

-- 8. compress
compress xs = map head $ group xs

-- 9. pack
pack :: Eq a => [a] -> [[a]]
pack [] = []
pack (x:xs) = (x : takeWhile (== x) xs) : pack (dropWhile (== x) xs)

-- 10. encode
encode xs = map (\x -> (length x, head x)) $ group xs


data Item a = Single a | Multiple Int a

-- 11. encodeMod
encodeModified :: Eq a => [a] -> [Item a]
encodeModified = map encode' . encode
  where encode' (1, x) = Single x
        encode' (c, x) = Multiple c x

-- 12. decode
decode :: [Item a] -> [a]
decode = concatMap f
  where f (Single a)     = [a]
        f (Multiple n a) = replicate n a

-- 14.
dup = concatMap (replicate 2)

-- 15.
repli xs n = concatMap (replicate n) xs


-- 16.
dropEvery [] _ = []
dropEvery xs n | length xs < n = xs
dropEvery xs n = (init (take n xs)) ++ dropEvery (drop n xs) n

-- 17.
split xs n = ((take n xs), (drop n xs))

-- 18.
slice xs a b = fst $ unzip $ filter ((>=a) . snd) $ zip xs [1..b]

-- 19.
rotate xs n | n >= 0    = drop n xs ++ take n xs
            | otherwise = take (length xs + n) xs ++ drop (length xs + n) xs

-- 20
removeAt n xs = (e, remainder)
  where e         = xs !! (n-1)
        remainder = (take (n-1) xs ++ drop n xs)


-- 21.

