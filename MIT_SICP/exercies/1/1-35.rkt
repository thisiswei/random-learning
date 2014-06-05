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

; show that golden ration is a fixed point of the transformation
; x -> 1 + 1/x

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
