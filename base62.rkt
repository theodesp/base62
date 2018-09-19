#lang racket
(require racket/provide)

;;;  "base62 encoding/decoding functions"

(define default-charset "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

(define (base62-encode n)
  (unless (number? n)
    (error "base62-encode: Expected a number, but got something else!"))
  (if (< n 10)
      (substring default-charset n (add1 n))
      (base62-encode-helper n "")))

(define (base62-encode-helper n acc)
  (if (= n 0)
      acc
      (let* ((index (modulo n 62))
             (ch (string-ref default-charset index)))
        (base62-encode-helper (floor (/ n 62)) (string-append (string ch) acc)))))

(define (char->number ch)
  (- (char->integer ch) 48))

(define (char->uppercase ch)
  (- (char->integer ch) 29))

(define (char->lowercase ch)
  (- (char->integer ch) 87))

(define (calc-next ch str index)
  ((lambda (base)
    (* base (expt 62 (- (string-length str) index 1))))
  (get-base ch)))

(define (get-base ch)
   (cond ((char-numeric? ch) (char->number ch))
        ((char-upper-case? ch) (char->uppercase ch))
        (else (char->lowercase ch))))

(define (base62-decode str)
  (unless (string? str)
    (error "base62-decode: Expected a string, but got something else!"))
  (base62-decode-helper str 0 0))

(define (base62-decode-helper str n index)
  (if (= (string-length str) index)
      n
       (let ((ch (string-ref str index)))
         (+ n (base62-decode-helper str (calc-next ch str index) (add1 index))))))
          
(provide base62-encode base62-decode)
