;2-17
(define (last-pair p)
  (if (null? (cdr p)) (car p)
    (last-pair (cdr p))))

;2-18
(define (reverse p)
  (define (iter a result)
    (if (null? a) result
      (iter (cdr a) (cons (car a) result))))
  (iter p null))

;2-19
(define (cc amount coin-vals)
  (cond [(= amount 0) 1]
        [(or (< amount 0) (null? coin-vals)) 0]
        [#t (+ (cc (- amount (car coin-vals)) coin-vals)
               (cc amount (cdr coin-vals)))]))

;2-20
(define (same-parity x . z)
  (define (iter p? a b)
    (cond [(null? a) (cons b null)]
          [(p? (car a)) (iter p? (cdr a) (cons (car a) b))]
          [#t (iter p? (cdr a) b)]))
  (let ([p (if (even? x) even? odd?)])
    (reverse (car (iter p z (cons x null))))))

;2-21
(define (square-list p)
  (map (lambda (x) (* x x)) p))

;2-23
(define (for-each p args)
  (p (car args))
  (null? args) #t (for-each p (cdr args)))

(define (count-leaves x)
  (cond [(null? x) 0]
        [(not (pair? x)) 1]
        [#t (+ (count-leaves (car x))
               (count-leaves (cdr x)))]))

;2-25
(define a '(1 3 '(5 7) 9))
(cdr (cdr (cdr a)))
(define b (cons (cons 7 null) null))
(car (car b))
(define d (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 (cons 6 7)))))))
(cdr (cdr (cdr (cdr (cdr (cdr d))))))

;.. trickky
;2-27 deep-reverse
(define (deep-reverse p)
  (if (pair? p)
    (append (deep-reverse (cdr p))
            (list (deep-reverse (car p))))
    p))

; 2.28
(define (fringe t)
  (cond [(null? t) t]
        [(not (pair? t)) (list t)]
        [#t (append (fringe (car t)) (fringe (cdr t)))]))

; these exercises are really good for practicing recursion
;2-29
(define (make-mobile left right)
  (list left right))

(define (make-branch len struct)
  (list len struct))

(define (left-branch mobile) (car mobile))

(define (right-branch mobile) (cdr mobile))

(define (branch-length br)
  (define (get-len p)
    (if (pair? p) (+ (get-len (car p)) (get-len (cdr p)))
      p))
  (get-len br))

(define (branch-structure br)
  (cond [(null? br) null]
        [(pair? br) (append (car br) (branch-structure (cdr br)))]
        [#t (list br)]))

;scale-tree implement
(define (scale-tree t factor)
  (cond [(null? t) null]
        [(not (pair? t)) (* t factor)]
        [#t (cons (scale-tree (car t) factor)
                  (scale-tree (cdr t) factor))]))

(define (scale-tree-map t factor)
  (map (lambda (s-t)
         (if (pair? s-t) (scale-tree-map s-t factor)
           (* s-t factor)))
       t))

;2.30
(define (square-tree t))
