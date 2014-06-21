fastExpn :: Int -> Int -> Int
fastExpn b n | n == 0    = 1
             | even n    = square $ fastExpn b (n `div` 2)
             | otherwise = b * (fastExpn b (n-1))

square n = n * n
