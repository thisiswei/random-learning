import Data.List

data BinTree a = Empty | NodeBT a (BinTree a) (BinTree a)
  deriving Show

-- 4.2
comp f g l = [ f x | x <- (map g l), x > 10 ]
comp' f g l = filter (> 10) $ map (f . g) l
comp'' f g l = [ x | x <- map (f . g) l, x > 10 ]


split x l = ([ y | y <- l, y <= x ], [ y | y <- l, y > x ])

-- 4.3
split' :: Int -> [Int] -> ([Int], [Int])
split' x l = split'' x l [] []
  where
    split'' :: Int -> [Int] -> [Int] -> [Int] -> ([Int], [Int])
    split'' _ [] l r                  = (l, r)
    split'' y (y':ys) l r | y >= y'   = split'' y ys (y':l) r
                          | otherwise = split'' y ys l (y':r)


split'' :: Int -> [Int] -> ([Int], [Int])
split'' _ []     = ([], [])
split'' x (y:ys) | y <= x    = (y:ys1, ys2)
                 | otherwise = (ys1, y:ys2)
  where (ys1, ys2) = split x ys

-- 4.5
sm :: BinTree a -> BinTree a -> Bool
sm Empty Empty = True
sm (NodeBT a l1 r1) (NodeBT b l2 r2) | a != b = False
                                     | (sm l1 l2) && (sm r1 r2)

-- 4.6
