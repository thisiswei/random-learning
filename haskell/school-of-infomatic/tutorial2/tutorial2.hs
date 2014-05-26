-- Informatics 1 - Functional Programming
-- Tutorial 2
--
-- Week 4 - due: 10/11 Oct.

import Data.Char
import Data.List
import Test.QuickCheck


-- 1.
rotate :: Int -> [Char] -> [Char]
rotate n xs | n > length xs = error "WTF"
            | otherwise     = drop n xs ++ take n xs

-- 2.
prop_rotate :: Int -> String -> Bool
prop_rotate k str = rotate (l - m) (rotate m str) == str
                        where l = length str
                              m = if l == 0 then 0 else k `mod` l

-- 3.
makeKey :: Int -> [(Char, Char)]
makeKey n = zip alpha (rotate n alpha)
  where alpha = ['A'..'Z']


-- 4.
lookUp :: Char -> [(Char, Char)] -> Char
lookUp key pairs = case found of
                    []         -> key
                    (k, v):xs  -> v
  where found = dropWhile (\(k, v) -> k /= key) pairs

-- 5.
-- ????
encipher :: Int -> Char -> Char
encipher n c = lookUp c (makeKey n)
-- encipher n c = chr (65 + (26 + n + (ord c - ord 'A')) `mod` 26)

-- 6.
normalize :: String -> String
normalize = map toUpper . filter (\c -> isAlpha c || isDigit c)

-- 7.
encipherStr :: Int -> String -> String
encipherStr n s = map (encipher n) $ normalize  s

-- 8.
reverseKey :: [(Char, Char)] -> [(Char, Char)]
reverseKey [] = []
reverseKey ((fst, snd) : xs) = ((snd, fst) : reverseKey xs)

-- 9.
decipherStr :: Int -> String -> String
decipherStr n s = map (\c -> lookUp c pairs) (normalize s)
  where pairs = reverseKey (makeKey n)

-- 10.
contains :: String -> String -> Bool
contains _ [] = True
contains [] _ = False
contains s1@(x:xs) s2 | isPrefixOf s2 s1 = True
                      | otherwise        = contains xs s2

-- 11.
candidates :: String -> [(Int, String)]
candidates s = filter (\(_,s) -> contains s "THE" || contains s "AND") allPossible
  where allPossible = [(n, decipherStr n s) | n <- [1..26]]


-- Optional Material
-- haskell is AWESOME!
-- 12.
splitEachFive :: String -> [String]
splitEachFive = map f . splitFive
  where f = (\x -> take 5 $ x ++ repeat 'X')

splitFive [] = []
splitFive s = take 5 s : splitEachFive (drop 5 s)

-- 13.
prop_transpose :: String -> Bool
prop_transpose = undefined

-- 14.
encrypt :: Int -> String -> String
encrypt n = concat . transpose . splitEachFive . encipherStr n


-- 15.
-- >>> decrpyt 12 "EFMQYSOQQDEXQEX"
--     "SECRET MESSAGE"

decrypt n = f . transpose . splitAtN . decipherStr n
  where f [y] = filter (\x -> x /= 'X') y
        f (x:xs) = x ++ f xs

splitAtN xs = splitHelper (length xs `div` 5) xs
splitHelper _ [] = []
splitHelper n xs = take n xs : splitHelper n (drop n xs)

-- Challenge (Optional)

-- problems encounter: not able to define dedup without `elem`
-- 16.
countFreqs :: String -> [(Char, Int)]
countFreqs xs = dedup (zip xs $ count xs)

count xs = map (\x -> length $ elemIndices x xs) xs

dedup xs = dedup' xs []

dedup' [] aux = aux
dedup' (x:xs) aux | x `elem` aux = dedup' xs aux
                  | otherwise = dedup' xs (aux++[x])


-- 17
-- dont understand the question..

