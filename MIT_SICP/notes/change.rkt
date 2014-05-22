#lang racket
; making changes for given amount and kind of coins

(define (change amt)
  (cc amt 5))

; change without using the first-kind-of-coins
; change using the all-kinds-of-coins, but since first kind is already predetermined, it's
; equvilent to make change for the remainder of that amount after minus the first-kind
(define (cc amount kind-of-coins)
    (cond
      [(= amount 0) 1]
      [(or (< amount 0) (= kind-of-coins 0)) 0]
      [#t (+ (cc amount (- kind-of-coins 1))
             (cc (- amount (denomr kind-of-coins)) kind-of-coins))]))

(define (denomr kind-of-coins)
        (cond
          [(= kind-of-coins 5) 50]
          [(= kind-of-coins 4) 25]
          [(= kind-of-coins 3) 10]
          [(= kind-of-coins 2) 5]
          [(= kind-of-coins 1) 1]))
