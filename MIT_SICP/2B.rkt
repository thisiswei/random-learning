(define (make-rat n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))
(define (cal-rat x) (/ (numer x) (denom x)))

(define (mulp-make-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom x))))

(define (plus-make-rat x y)
  (make-rat (+ (* (numer x) (denom y)) (* (numer y) (denom x)))
            (* (denom x) (denom y))))
