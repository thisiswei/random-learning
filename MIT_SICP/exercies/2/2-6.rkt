
; given that zero and add-1 is define below
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n) (lambda (f) (lambda (x) (f ((n f) x)))))

; one is (define one (add-1 zero))
; substitue zero with (lambda (f) ....) will result follow
(lambda (f) (lambda (x) (f x)))

(define two (add-1 one))
(lambda (f) (lambda (x) (f (f x))))
