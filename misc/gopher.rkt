#lang racket
(define (gopher host (port "70") (path "/"))
  (define-values (in out) (tcp-connect host (string->number port)))
  (display (string-append path "\r\n") out)
  (flush-output out)
  (for-each displayln (port->lines in #:line-mode 'return-linefeed))
  (close-output-port out))

(module+ main
  (command-line
   #:args args
   (apply gopher args)))

;; Example use: % racket gopher.rkt gopher.erkin.party 70 /files/keeb.txt
