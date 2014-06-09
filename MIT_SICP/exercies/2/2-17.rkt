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

; june 06/ 2014
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
(define (square-list t)
  (map (lambda (s-t)
         (if (pair? s-t) (square-list s-t)
           (* s-t s-t)))
       t))

(define (square-list-i t)
  (cond [(null? t) null]
        [(not (pair? t)) (* t t)]
        [#t (cons (square-list-i (car t)) (square-list-i (cdr t)))]))

;2.31
(define (square x) (* x x))
(define (square-tree-another t) (tree-map square t))

(define (tree-map f t)
  (map (lambda (s-t)
         (if (pair? s-t) (tree-map f s-t)
           (f s-t)))
       t))

;2.32
;[1, 2, 3] -> [[], [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3]]

(define (subsets s)
 (if (null? s) (list null)
   (let ([rest (subsets (cdr s))])
     (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(define (accumulate op initial seq)
  (if (null? seq)
    initial
    (op (car seq)
        (accumulate op initial (cdr seq)))))

;2.33
(define (map p seq)
  (accumulate (lambda (x y) (cons x y)) null seq))

(define (append sq1 sq2)
  (accumulate cons sq2 sq1))

(define (length seq)
  (accumulate (lambda (x y) (+ 1 y)) 0 seq))

;2.34
(define (horner-eval x coeff-seq)
  (accumulate (lambda (coe hterm) (+ coe (* x hterm))) 0 coeff-seq))

;2.35
(define (count-leaves-acc t)
  (accumulate + 0 (map (lambda (x) (if (not (pair? x)) 1 (count-leaves-acc x))) t)))

;2.36
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    null
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs)))))

;2.37
(define (transpose mat)
  (accumulate-n cons null mat))

(define (matrix-*-vector m v)
  (map <??> m))

(define (matrix-*-matrix m n)
  (let ([cols (transpose n)])
    (map <??> m)))

;2.38
; + should do it
(define (fold-left op init seq)
  (define (iter a aux)
    (if (null? a) aux
      (iter (cdr a) (op aux (car a)))))
  (iter seq init))

(define (accumulate op initial seq)
  (if (null? seq)
    initial
    (op (car seq)
        (accumulate op initial (cdr seq)))))

(define fold-right accumulate)
;2.39
(define (reverse-foldr seq)
  (fold-right (lambda (x y) (append y (list x))) null seq))

(define (reverse-foldl seq)
  (fold-left (lambda (x y) (cons y x)) null seq))

; nested mapping
(define (flatmap proc seq) (accumulate append null (map proc seq)))

(define (permutations s)
  (if (null? s) (list null)
    (flatmap (lambda (x) (map (lambda (p) (cons x p)) (permutations (remove x s))))
               s)))
(define (remove item s)
  (filter (lambda (x) (not (= item x))) s))

;2.40
(define (enumerate-interval low high)
  (if (> low high) null (cons low (enumerate-interval (+ 1 low) high))))

(define (unique-pairs n)
  (flatmap (lambda (i) (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1))) (enumerate-interval 1 n)))

;2.41
(define (mk-triples n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

;2.42
