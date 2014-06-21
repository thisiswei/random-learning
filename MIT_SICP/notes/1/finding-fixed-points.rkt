; A number x is called point of a function f if x satisfies
; x = f(x)

(define tolerance 0.00001)
(define (fixed-point f fst-guess)
  (define (close-enough? v1 v2)
    (< tolerance (abs (- v1 v2))))
  (define (try guess)
    (let ([next (f guess)])
      (if (close-enough? next guess)
        next
        (try next))))
  (try fst-guess))
