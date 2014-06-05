(define (fst-expn b n)
  (define (iter a b n)
    (cond [(= n 0) a]
          [(even? n) (iter a (square b) (/ n 2))]
          [#t (iter (* a b) b (- n 1))]))
  (iter 1 b n))

(define (slow-expn b n)
  (if (= n 0) 1
    (* b (slow-expn b (- n 1)))))
