(define (filtered-acc combiner nv term a next b p)
  (define (iter a res)
    (if (> a b) res
      (let ([t (if (p a) (term a) nv)])
        (iter (next a) (combiner res t)))))
  (iter a nv))
