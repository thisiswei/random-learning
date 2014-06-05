(define (double proc)
  (lambda (x) (proc (proc x))))
