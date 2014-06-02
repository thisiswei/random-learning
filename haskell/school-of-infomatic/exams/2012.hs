import Data.List
import Data.Char

{- 1 a)
ord :: Char -> Int
chr :: Int -> Char
-}

f :: Char -> Bool
f c | isAlpha c = ord (toUpper c) <= m'
    | otherwise = error "error"
  where m' = ord 'M'

-- 1 b)
g str = lenFirstHalf > lenSndHalf
  where lenFirstHalf = length $ filter f $ filter isAlpha str
        lenSndHalf   = length str - lenFirstHalf

-- 2 a)
c :: [Int] -> [Int]
c = concatMap f'' . group
  where
    f'' [_]    = []
    f'' (x:xs) = x : f'' xs

-- 2 b)
d :: [Int] -> [Int]

