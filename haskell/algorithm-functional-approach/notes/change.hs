-- given amount a, calculate n ways of giving the change

change :: Int -> Int
change a = changeH' a 5

changeH' :: Int -> Int -> Int
changeH' 0 _ = 1
changeH' _ 0 = 0
changeH' amt n | amt < 0 = 0
               | otherwise = waysOfUsingFstCoin + waysWithOutFstCoin
  where waysOfUsingFstCoin = changeH' (amt - denominator n) n
        waysWithOutFstCoin = changeH' amt (n-1)

denominator 5 = 50
denominator 4 = 25
denominator 3 = 10
denominator 2 = 5
denominator 1 = 1
