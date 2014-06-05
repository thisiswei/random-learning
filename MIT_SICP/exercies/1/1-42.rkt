;1-42
(define (compose f g)
  (lambda (x)
    (f (g x))))

;1-43
(define (repeated f n)
    (if (< n 1) (lambda (x) x)
      (compose f (repeated f (- n 1)))))
;1-44
(define (smooth f)
  (lambda (x)
    (let ([dx 0.0000001])
      (/ (+ (f (- x dx))
            (f x)
            (f (+ x dx)))
         3))))

(define (repeated-smooth f n)
  ((repeated smooth n) f))
