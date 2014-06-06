(define (repeated f n)
  (lambda (x)
    (if (= n 1) (f x)
      (repeated f (- n 1) (f x)))))

(define (compose f g) (lambda (x) (f (g x))))

(define (repeated-i f n)
  (define (iter b aux)
    (if (= b 0) aux
      (iter (- b 1) (compose f aux))))
  (iter n (lambda (x) x)))
