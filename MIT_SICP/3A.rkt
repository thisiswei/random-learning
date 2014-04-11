(define (vect v1 v2)
  (make-vector
    (+ (xcor v1) (xcor v2))
    (+ (ycor v1) (ycor v2))))

(define (scale s v)
  (make-vector
    (* s (xcor v))
    (* s (ycor v))))

(define make-vector cons)
(define xcor cons)
(define ycor cdr)

(define (scale-list s l)
  (if (null l)
    null
    (cons (* s (car l))
          (scale-list s (cdr l)))))

(define (map p l)
  (if (null l)
    null
    (cons (p (car l))
          (map p (cdr l)))))

(define (scale-list-2 s l)
  (map (lambda (x) (* s x)) l))

(define (for-each proc l)
  (cond [(null l) "done"]
        [else (proc (car l))
              (for-each proc (cdr l))]))
