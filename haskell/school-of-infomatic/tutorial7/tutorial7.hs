-- Informatics 1 - Functional Programming
-- Tutorial 7
--
-- Week 9 - Due: 14/15 Nov.


import LSystem
import Test.QuickCheck

-- Exercise 1

-- 1a. split
--Main> split (Go 3 :#: Turn 4 :#: Go 7)
--            [Go 3, Turn 4, Go 7]
--            no Sit or #

split :: Command -> [Command]
split Sit       = []
split (c :#: d) = split c ++ split d
split cmd = [cmd]

-- 1b. join
join :: [Command] -> Command
join = foldr (:#:) Sit

-- 1c  equivalent
equivalent c1 c2 = (join $ split c1) == (join $ split c2)

-- 1d. testing join and split
prop_split_join :: Command -> Bool
prop_split_join c = equivalent c (join (split c))

prop_split c = all f (split c)
  where
    f Sit        = False
    f (_ :#: _)  = False
    f _          = True



-- Exercise 2
-- 2a. copy
copy :: Int -> Command -> Command
copy n c = join $ concat (replicate n $ split c)

-- ?
-- 2b. pentagon
pentagon :: Distance -> Command
pentagon d = copy 5 (Go d :#: Turn 72.0)

-- 2c. polygon
polygon :: Distance -> Int -> Command
polygon d i = copy i (Go d :#: Turn a)
  where a = 360 / fromIntegral i


-- Exercise 3
-- spiral *
spiral :: Distance -> Int -> Distance -> Angle -> Command
spiral d n c a = join $ helper d n c a

helper d 0 change a = []
helper 0 _ _ _ = []
helper d 1 _ a = [(Go d :#: Turn a)]
helper d n c a = (Go d :#: Turn a) : helper (d+c) (n-1) c a


-- Exercise 4
-- optimise
optimise :: Command -> Command
optimise = join . filter p . combine . filter p . split
  where p c                            = c /= (Turn 0) && c /= (Go 0) && c /= (Sit)
        combine []                     = []
        combine ((Go e):(Go d):ys)     = combine (Go (e+d) : combine ys)
        combine ((Turn e):(Turn d):ys) = combine (Turn (e+d) : combine ys)
        combine (x:xs)                 = x : combine xs


-- L-Systems

-- 5. arrowhead
arrowhead :: Int -> Command
arrowhead = undefined

-- 6. snowflake
snowflake :: Int -> Command
snowflake = undefined

-- 7. hilbert
hilbert :: Int -> Command
hilbert = undefined

