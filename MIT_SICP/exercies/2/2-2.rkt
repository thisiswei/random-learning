;2.2
(define (make-segment p1 p2) (cons p1 p2))

(define (start-segment p) (car p))

(define (end-segment p) (cdr p))

(define (make-point x y) (cons x y))

(define (x-point p) (car p))

(define (y-point p) (cdr p))

(define (midpoint-segment s)
  (define (aver a b) (/ (+ a b) 2))
  (let ([s (start-segment s)]
        [e (end-segment s)])
    (make-point (aver (x-point s)
                      (x-point e))
                (aver (y-point s)
                      (y-point e)))))
