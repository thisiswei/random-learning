-- Informatics 1 - Functional Programming
-- Tutorial 3
--
-- Week 5 - Due: 17/18 Oct.

import Data.Char
import Test.QuickCheck



-- 1. Map
-- a.
uppers :: String -> String
uppers = map toUpper

-- b.
doubles :: [Int] -> [Int]
doubles = map (* 2)

-- c.
penceToPounds :: [Int] -> [Float]
penceToPounds xs = map f xs
    where f x = fromInteger (toInteger x) * 0.01

-- d.
uppers' :: String -> String
uppers' xs = [ toUpper(c) | c <- xs ]

prop_uppers :: String -> Bool
prop_uppers = undefined

-- 2. Filter
-- a.
alphas :: String -> String
alphas = filter isAlpha

-- b.
rmChar ::  Char -> String -> String
rmChar c = filter (\c' -> c' /= c)

-- c.
above :: Int -> [Int] -> [Int]
above i = filter (\i' -> i' > i)

-- d.
unequals :: [(Int,Int)] -> [(Int,Int)]
unequals = filter (\(x,y) -> x /= y)

-- e.
rmCharComp :: Char -> String -> String
rmCharComp = undefined

prop_rmChar :: Char -> String -> Bool
prop_rmChar = undefined


-- 3. Comprehensions vs. map & filter
-- a.
upperChars :: String -> String
upperChars s = [toUpper c | c <- s, isAlpha c]

upperChars' :: String -> String
upperChars' = map toUpper . filter isAlpha

prop_upperChars :: String -> Bool
prop_upperChars s = upperChars s == upperChars' s

-- b.
largeDoubles :: [Int] -> [Int]
largeDoubles xs = [2 * x | x <- xs, x > 3]

largeDoubles' :: [Int] -> [Int]
largeDoubles' = filter (> 3) . map (* 2)

prop_largeDoubles :: [Int] -> Bool
prop_largeDoubles xs = largeDoubles xs == largeDoubles' xs 

-- c.
reverseEven :: [String] -> [String]
reverseEven strs = [reverse s | s <- strs, even (length s)]

reverseEven' :: [String] -> [String]
reverseEven' = filter (even . length) . map reverse

prop_reverseEven :: [String] -> Bool
prop_reverseEven strs = reverseEven strs == reverseEven' strs



-- 4. Foldr
-- a.
productRec :: [Int] -> Int
productRec []     = 1
productRec (x:xs) = x * productRec xs

productFold :: [Int] -> Int
productFold = foldr (+) 0

prop_product :: [Int] -> Bool
prop_product xs = productRec xs == productFold xs

-- b.
-- ??? review later
andRec :: [Bool] -> Bool
andRec [] = True
andRec (x:xs) = x && andRec xs

andFold :: [Bool] -> Bool
andFold = foldr (&&) True

prop_and :: [Bool] -> Bool
prop_and xs = andRec xs == andFold xs

-- c.
concatRec :: [[a]] -> [a]
concatRec [[]] = []
concatRec (x:xs) = x ++ concatRec xs

concatFold :: [[a]] -> [a]
concatFold = foldr (++) []

prop_concat :: [String] -> Bool
prop_concat strs = concatRec strs == concatFold strs

-- d.
rmCharsRec :: String -> String -> String
rmCharsRec _ [] = []
rmCharsRec [] x = x
rmCharsRec (x:xs) ys = rmChar x (rmCharsRec xs ys)

rmCharsFold :: String -> String -> String
rmCharsFold xs ys = foldr (\c -> rmChar c) ys xs

prop_rmChars :: String -> String -> Bool
prop_rmChars chars str = rmCharsRec chars str == rmCharsFold chars str


type Matrix = [[Int]]


-- 5
-- a.
uniform :: [Int] -> Bool
uniform [] = True
uniform [_] = True
uniform (x:xs) = all (\x' -> x' == x) xs
-- solution from instructor, kinda neat:
-- uniform xs = all (== head xs) (tail xs)

-- b.
valid :: Matrix -> Bool
valid xs = sameLength && cols >= 1 && rows >= 1
  where sameLength      = uniform lengths
        lengths         = map length xs
        cols            = head lengths
        rows            = length xs

-- 6.
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f xs ys = [ f x y | (x, y) <- zip xs ys]

zipWith'' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith'' f xs ys = map (uncurry f) (zip xs ys)

-- 7.
plusM :: Matrix -> Matrix -> Matrix
plusM ms1 ms2 | ok        = plusMHelper ms1 ms2
              | otherwise = error "wtf"
  where ok =  valid ms1 && valid ms2
              && height ms1 == height ms2
              && width ms1 == width ms2

height m = length m
width m = length $ head m

-- totally forgot about zipWith
plusMHelper [] [] = []
plusMHelper (m:ms) (m':ms') = map (uncurry (+)) (zip m m') : plusMHelper ms ms'

-- should be following, `zipWith (zipWith (+)) m n` is fucking brillant

-- matrixWidth :: Matrix -> Int
-- matrixWidth m = length (head m)

-- matrixHeight :: Matrix -> Int
-- matrixHeight m = length m

-- plusM :: Matrix -> Matrix -> Matrix
-- plusM m n | ok = zipWith (zipWith (+)) m n
--   where ok = matrixWidth m == matrixWidth n
--              && matrixHeight m == matrixHeight n
--              && valid m && valid n

-- 8.
timesM :: Matrix -> Matrix -> Matrix
timesM = undefined

-- Optional material
-- 9.
