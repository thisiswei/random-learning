(define (repeated f n)
  (lambda (x)
    (if (= n 1) (f x)
      (repeated f (- n 1) (f x)))))
