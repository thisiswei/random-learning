(define (SUM term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term
            (next a)
            next
            b))))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  (define tolerance 0.00001)
  (define (good-enuf? y)
    (< (abs (- (* y y) x)) tolerance))
  (define (improve y)
    (average (/ x y) y))
  (define (try y)
    (if (good-enuf? y)
      y
      (try (improve y))))
  (try 1))

(define (sqrt-2 x)
  (fixed-point
    (lambda (y) (average (/ x y) y))
    1))

(define (fixed-point f start)
  (define tolerance 0.00001)
  (define (close-enuf? n o)
    (< (abs (- n o)) tolerance))
  (define (iter old new)
    (if (close-enuf? old new)
      new
      (iter new (f new))))
  (iter start (f start)))

(define (sqrt-3 x)
  (fixed-point
    (average-damp (lambda (y) (/ x y)))
    1))

(define average-damp
  (lambda (f)
    (lambda (x) (average (f x) x))))

;newton's method
(define (sqrt-4 x)
  (newton (lambda (y) (- x (square y)))
          1))

(define (newton f guess)
  (define df (derivative f))
  (fixed-point (lambda (x) (- x (/ (f x) (df x))))
               guess))

(define derivative
  (define dx 0.00000001)
  (lambda (f)
    (lambda (x)
      (/ (- (f (+ x dx))
            (f x))
         dx))))

(define (square x) (* x x))
