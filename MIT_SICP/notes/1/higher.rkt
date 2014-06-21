(define (h f next a b)
  (if (> a b)
    0
    (+ (f a) (h f next (next a) b))))

