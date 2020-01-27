#lang racket
(define (gopher host port path)
  (define-values (in out) (tcp-connect host port))
  (display (string-append path "\r\n") out)
  (flush-output out)
  (display (string-join (port->lines in #:line-mode 'return-linefeed) "\n"))
  (close-output-port out))

(module+ main
  (command-line
   #:args args
   (gopher (car args) (string->number (cadr args)))))

;; Example use: % racket gopher.rkt suika.erkin.party 70 /files/keeb.txt
