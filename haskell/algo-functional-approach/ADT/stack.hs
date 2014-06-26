module Stack(Stack, push, pop, top, emptyStack, stackEmpty) where


data Stack a  = EmptyStk
              | Stk a (Stack a)

push :: a -> Stack a -> Stack a
push x s = Stk x s

pop :: Stack a -> Stack a
pop EmptyStk = error "wtf"
pop (Stk _ s) = s

top :: Stack a -> a
top EmptyStk = error "wtf"
top (Stk x _) = x

emptyStack :: Stack a
emptyStack = EmptyStk

stackEmpty :: Stack a -> Bool
stackEmpty EmptyStk = True
stackEmpty _ = False

instance (Show a) => Show (Stack a) where
  showsPrec _ EmptyStk str = showChar '-' str
  showsPrec _ (Stk x s) str = shows x (showChar '|' (shows s str))
