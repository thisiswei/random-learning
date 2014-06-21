(define (fast-expn b n)
  (cond [(= n 0) 1]
        [(even? n) (square (fast-expn b (/ n 2)))]
        [#t (* b (fast-expn b (- n 1)))]))

(define (even? b)
  (= (remainder b 2) 0))

(define (square n)
  (* n n))

