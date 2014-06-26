module Queue(Queue, emptyQueue, queueEmpty, enqueue, dequeue, front) where

newtype Queue a = Q [a]
  deriving Show

emptyQueue :: Queue a
emptyQueue = Q []

queueEmpty :: Queue a -> Bool
queueEmpty (Q []) = True
queueEmpty _ = False

enqueue :: a -> Queue a -> Queue a -> Queue a
enqueue x (Q q) = Q (q ++ [x])

dequeue :: Queue a -> Queue a
dequeue (Q (_:xs)) = Q xs
dequeue (Q _) = error "wtf"

front :: Queue a -> a
front (Q (x:_)) = x
front (Q []) = error "bitch"
