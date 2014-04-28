{-
questions from http://www.cis.upenn.edu/~cis194/hw/01-intro.pdf

toDigits 0 = []
toDigits (-18) = []
toDigits 1234 = [1, 2, 3, 4]
-}

toDigitsRev :: Integer -> [Integer]
toDigitsRev x
  | x <= 0 = []
  | otherwise = x `mod` 10 : toDigitsRev(x `div` 10)

toDigits :: Integer -> [Integer]
toDigits = reverse . toDigitsRev

{-
doubleEveryOther [1, 2, 3] => [1, 4, 3]
doubleEveryOther [1, 2, 3, 4] => [2, 2, 6, 4]
-}

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther (x:xs)
  | length(xs) `mod` 2 == 0 = [x] ++ doubleEveryOther(xs)
  | otherwise               = [2*x] ++ doubleEveryOther(xs)

-- sumDigits [16, 7, 12, 5] = 1 + 6 + 7 + 1 + 2 + 5

sumDigits xs = sum $ map (\x -> helper(x, 0)) xs
  where helper(x, acc) = if x `div` 10 == 0 then (acc + (x `mod` 10))
                                            else helper((x `div` 10), (acc + (x `mod` 10)))

validate :: Integer -> Bool
validate n = ((helper n) `mod` 10 == 0)
  where helper = sumDigits . doubleEveryOther . toDigits
