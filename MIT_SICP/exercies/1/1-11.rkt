(define (f n)
  (if (< n 3) n
    (+ (f (- n 1))
       (* 2 (f (- n 2)))
       (* 3 (f (- n 3))))))

;iterative
(define (f-1 n)
  (f-1 0 1 2 n))

(define (f-1 a b c n)
  (if (= n 0) a
    (f-1 b c (+ c (* 2 b) (* 3 a)) (- n 1))))
