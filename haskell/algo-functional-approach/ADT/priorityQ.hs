module PQueue(PQueue, emptyPQ, pqEmpty, enPQ, dePQ, frontPQ) where

newtype PQueue a = PQ[a]

enPQ x (PQ q) = PQ (inset x q)
  where insert x []       = [x]
        insert x r@(e:r') | x >= e    = e : insert x r'
                          | otherwise = x : r

dePQ (PQ []) = error "blah"
dePQ (PQ (x:xs)) = PQ xs
