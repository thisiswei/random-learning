;cube-root can be express as average-damp y -> x/y^2
(define (fixed-point f fst-guess)
  (define (close-enough? v1 v2)
    (< tolerance (abs (- v1 v2))))
  (define (try guess)
    (let ([next (f guess)])
      (if (close-enough? next guess)
        next
        (try next))))
  (try fst-guess))

(define (cube-root x)
  (fixed-point (average-damp
                 (lambda (y) (/ x (square y))))
               1.0))

(define (square x)
  (* x x))
