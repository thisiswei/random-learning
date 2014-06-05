(define (acc combiner nv term a next b)
  (if (> a b) nv
    (combiner (term a) (acc combiner nv term (term a) next b))))

(define (acc combiner nv term a next b)
  (define (iter a res)
    (if (> a b) res
      (iter (next a) (combiner res (term a)))))
  (iter a nv))

