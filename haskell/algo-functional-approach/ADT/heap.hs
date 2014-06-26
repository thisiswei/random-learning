data (Ord a) => Heap a = EmptyHP
                       | HP a Int (HP a) (HP a)
  deriving Show

rank :: (Ord a) => Heap a -> Int
rank EmptyHP = 0
rank (HP _ r _ _) = r

makeHP :: (Ord a) => a -> Heap a -> Heap a -> Heap a
makeHP x a b | rank a >= rank b = HP x (rank b + 1) a b
             | otherwise        = HP x (rank a + 1) b a

merge :: (Ord a) => Heap a -> Heap a -> Heap a
merge h EmptyHP = h
merge EmptyHP h = h
merge h1@(HP v _ l1 r1)  h2@(HP v' _ l2 r2) | v <= v' = makeHP v l1 (merge r1 h2)
                                            | otherwise = makeHP v' (merge h1 l2) r2

delHeap EmptyHP = error "wtf"
delHeap (HP x _ a b) = merge a b
