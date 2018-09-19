#lang racket/base
(require rackunit/text-ui)
(require rackunit "./base62.rkt")

(define base62-tests
  (test-suite
   "Tests for base62.rkt"

   (test-case
    "Throws error if base62-encode not provided a parameter"
    (check-exn
     exn:fail?
     (lambda ()
       (base62-encode))))

   (test-case
    "Throws error if base62-encode not provided a number"
    (check-exn
     exn:fail?
     (lambda ()
       (base62-encode "1"))))

   (test-case
    "Throws error if base62-decode not provided a parameter"
    (check-exn
     exn:fail?
     (lambda ()
       (base62-decode))))

   (test-case
    "Throws error if base62-decode not provided a string"
    (check-exn
     exn:fail?
     (lambda ()
       (base62-decode 1))))

   (test-case
    "Encodes correctly"
      (check-equal? (base62-encode 0) "0")
      (check-equal? (base62-encode 4) "4")
      (check-equal? (base62-encode 16) "g")
      (check-equal? (base62-encode 65) "13")
      (check-equal? (base62-encode 238327) "ZZZ"))

   (test-case
    "Decodes correctly"
      (check-equal? (base62-decode "0") 0)
      (check-equal? (base62-decode "4") 4)
      (check-equal? (base62-decode "g") 16)
      (check-equal? (base62-decode "13") 65)
      (check-equal? (base62-decode "ZZZ") 238327))
   ))

(run-tests base62-tests)
