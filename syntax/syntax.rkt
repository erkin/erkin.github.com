#lang racket/base
(require racket/format
         racket/string)
(require syntax-color/racket-lexer)

(define (lexinate results depth)
  (define (make-span depth str)
    (format "<span class=\"paren-~a\">~a</span>" depth str))
  (define-values (str type paren start end) (racket-lexer (current-input-port)))
  (if (eof-object? str)
      (string-join (reverse results) "")
      (case paren
        ((\( \[ \{)
         (lexinate (cons (make-span depth str) results) (add1 depth)))
        ((\) \] \})
         (lexinate (cons (make-span (sub1 depth) str) results) (sub1 depth)))
        (else
         (lexinate (cons str results) depth)))))

(module+ main
  (display "<code>")
  (displayln (lexinate '() 0))
  (displayln "</code>"))
