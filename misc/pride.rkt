#lang racket ; -*- racket -*-

(define gay
  '((228 003 003) ; red
    (255 140 000) ; orange
    (255 237 000) ; yellow
    (000 128 038) ; green
    (000 077 255) ; blue
    (117 007 135) ; purple
    ))
(define lesbian
  '((163 002 098) ; red
    (211 098 164) ; orange
    (255 255 255) ; white
    (255 154 086) ; pink
    (213 045 000) ; purple
    ))
(define trans
  '((091 206 250) ; blue
    (245 169 184) ; pink
    (255 255 255) ; white
    (245 169 184) ; pink
    (091 206 250) ; blue
    ))
(define enby
  '((255 244 048) ; yellow
    (255 255 255) ; white
    (156 089 209) ; purple
    (000 000 000) ; black
    ))
(define bi
  '((214 002 112) ; pink
    (214 002 112) ; pink
    (155 079 150) ; purple
    (000 056 168) ; blue
    (000 056 168) ; blue
    ))
(define pan
  '((255 033 140) ; pink
    (255 216 000) ; yellow
    (033 177 255) ; blue
    ))
(define queer
  '((181 126 220) ; purple
    (255 255 255) ; white
    (074 129 035) ; green
    ))
(define ace
  '((000 000 000) ; black
    (169 163 163) ; grey
    (255 255 255) ; white
    (128 000 128) ; purple
    ))
(define old
  '((255 105 180) ; pink
    (255 000 000) ; red
    (255 142 000) ; orange
    (255 255 000) ; yellow
    (000 142 000) ; green
    (000 192 192) ; blue
    (064 000 152) ; indigo
    (142 000 142) ; purple
    ))
(define rainbow gay)
(define pride
  (append
   '((000 000 000) ; black
     (120 079 023) ; brown
     ) rainbow))

;;; Fill a row with colour
(define (display-colour colour columns)
  (printf "\e[48;2;~A;~A;~Am~a\e[0m~%"
          (car   colour) ; Red
          (cadr  colour) ; Green
          (caddr colour) ; Blue
          (make-string columns #\space)))

(define (display-pride flag rows columns)
  (unless (null? flag)
    (for ((_ rows))
      (display-colour (car flag) columns))
    (display-pride (cdr flag) rows columns)))

(define-syntax ->>
  (syntax-rules ()
    ((_ val)
     val)
    ((_ val (fun args ...) rest ...)
     (->> (fun args ... val) rest ...))
    ((_ val fun rest ...)
     (->> (fun val) rest ...))))

(define (get-screen-size)
  (->> (thunk (system "stty size"))
       with-output-to-string
       string-normalize-spaces
       string-split
       (map string->number)
       (apply values)))

(module+ main
  (unless (getenv "COLORTERM")
    (error "Sorry baby, your terminal does not support true colour.")
    (exit -1))
  (let-values (((rows columns) (get-screen-size)))
    (display-pride rainbow 5 columns)))
