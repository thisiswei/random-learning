-- Informatics 1 - Functional Programming 
-- Tutorial 1
--
-- Due: the tutorial of week 3 (4/5 Oct.)

import Data.Char
import Data.List
import Test.QuickCheck



-- 1. halveEvens

-- List-comprehension version
halveEvens :: [Int] -> [Int]
halveEvens = map (`div` 2) . filter (even)

halveEvens' :: [Int] -> [Int]
halveEvens' xs = [x `div` 2 | x <- xs, even x]

-- Recursive version
halveEvensRec :: [Int] -> [Int]
halveEvensRec [] = []
halveEvensRec (x:xs) | even x    = (x `div` 2) : halveEvensRec xs
                     | otherwise = halveEvensRec xs

-- Mutual test
prop_halveEvens :: [Int] -> Bool
prop_halveEvens xs = halveEvensRec xs == halveEvens xs



-- 2. inRange

-- List-comprehension version
inRange :: Int -> Int -> [Int] -> [Int]
inRange lo hi xs = [x | x <- xs, x >= lo && x <= hi]

-- Recursive version
inRangeRec :: Int -> Int -> [Int] -> [Int]
inRangeRec _ _ [] = []
inRangeRec lo hi (x:xs) | x >= lo || x <= hi = (x : inRangeRec lo hi xs)
                        | otherwise          = inRangeRec lo hi xs

-- Mutual test
prop_inRange :: Int -> Int -> [Int] -> Bool
prop_inRange lo hi xs = inRange lo hi xs == inRangeRec lo hi xs



-- 3. sumPositives: sum up all the positive numbers in a list

-- List-comprehension version
countPositives :: [Int] -> Int
countPositives xs = sum [1 | x <- xs, x > 0]

-- Recursive version
countPositivesRec :: [Int] -> Int
countPositivesRec [] = 0
countPositivesRec (x:xs) | x > 0     = 1 + countPositivesRec xs
                         | otherwise = countPositivesRec xs

-- Mutual test
prop_countPositives :: [Int] -> Bool
prop_countPositives = undefined



-- 4. pennypincher

-- Helper function
discount :: Int -> Int
discount = (\x -> x - round (fromIntegral x / 10))

-- List-comprehension version
pennypincher :: [Int] -> Int
pennypincher xs = sum [ discount x | x <- xs, x > 19900]

-- Recursive version
pennypincherRec :: [Int] -> Int
pennypincherRec [] = 0
pennypincherRec (x:xs) | x > 19900 = pennypincherRec xs
                       | otherwise = discount x + pennypincherRec xs
-- Mutual test
prop_pennypincher :: [Int] -> Bool
prop_pennypincher = undefined



-- 5. sumDigits

-- List-comprehension version
multDigits' :: String -> Int
multDigits' = product . map digitToInt . filter isDigit

-- Recursive version
multDigitsRec :: String -> Int
multDigitsRec = undefined

-- Mutual test
prop_multDigits :: String -> Bool
prop_multDigits = undefined



-- 6. capitalise

-- List-comprehension version
capitalise :: String -> String
capitalise [] = []
capitalise (x:xs) = toUpper x : [toLower x' | x' <- xs]

-- Recursive version
capitaliseRec :: String -> String
capitaliseRec [] = []
capitaliseRec (x:xs) = toUpper x : lowRec xs

lowRec :: String -> String
lowRec [] = []
lowRec (x:xs) = toLower x : lowRec xs

-- Mutual test
prop_capitalise :: String -> Bool
prop_capitalise = undefined



-- 7. title

-- List-comprehension version
title :: [String] -> [String]
title = map (\x -> if (length x) >= 4 then capitalise x else lowRec x)

-- Recursive version
titleRec :: [String] -> [String]
titleRec = undefined

-- mutual test
prop_title :: [String] -> Bool
prop_title = undefined




-- Optional Material

-- 8. crosswordFind

-- List-comprehension version
crosswordFind :: Char -> Int -> Int -> [String] -> [String]
crosswordFind = undefined

-- Recursive version
crosswordFindRec :: Char -> Int -> Int -> [String] -> [String]
crosswordFindRec = undefined

-- Mutual test
prop_crosswordFind :: Char -> Int -> Int -> [String] -> Bool
prop_crosswordFind = undefined 



-- 9. search

-- List-comprehension version

search :: String -> Char -> [Int]
search = undefined

-- Recursive version
searchRec :: String -> Char -> [Int]
searchRec = undefined

-- Mutual test
prop_search :: String -> Char -> Bool
prop_search = undefined


-- 10. contains

-- List-comprehension version
contains :: String -> String -> Bool
contains = undefined

-- Recursive version
containsRec :: String -> String -> Bool
containsRec = undefined

-- Mutual test
prop_contains :: String -> String -> Bool
prop_contains = undefined

