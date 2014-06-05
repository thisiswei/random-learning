-- pascal triangle

p 0 0 = 1
p 0 _ = 1
p x y | x == y    = 1
      | otherwise = p x (y-1) + p (x-1) (y-1)

p' = (\(x, y) -> p x y)

unfold p h t x | p x       = []
               | otherwise = h x : unfold p h t (t x)

pascal = (unfold (const False) (take n) (drop n) paList)
            where paList = tail $ map p' [(x, y) | y <- [0..], x <- [0..y]]
