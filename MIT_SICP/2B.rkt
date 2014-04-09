(define (make-rat n d)
  (let ([g (gcd n d)])
    (cons (/ n g)
          (/ d g))))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (cal-rat x) (/ (numer x) (denom x)))

(define (mulp-make-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom x))))

(define (plus-make-rat x y)
  (make-rat (+ (* (numer x) (denom y)) (* (numer y) (denom x)))
            (* (denom x) (denom y))))



(define (make-seg p q) (cons p q))
(define (seg-start s) (cons s))
(define (seg-end s) (cdr s))

(define (xcor x) (car x))
(define (ycor x) (cdr x))

(define (midpoint s)
  (let ([a (seg-start s)]
        [b (seg-end s)])
    (make-vector
      (average (xcor a) (xcor b))
      (average (ycor a) (ycor b)))))

(define (length s)
  (let ([dx (- (xcor (seg-end s))
               (xcor (seg-start s)))]
        [dy (- (ycor (seg-end s))
               (ycor (seg-start s)))])
    (sqrt (+ (square dx)
             (square dy)))))


