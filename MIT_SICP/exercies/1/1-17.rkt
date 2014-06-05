(define (* a b)
  (cond [(= b 0) 0]
        [(even? b) (double (* a (halve b)))]
        [#t (+ a (* a (- b 1)))]))

(define (double n) (+ n n))

(define (halve b) (/ n 2))

(define (even? n) (= (remainder n 2) 0))

