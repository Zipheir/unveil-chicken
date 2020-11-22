(foreign-declare "#include <unistd.h>")
(foreign-declare "#include <errno.h")

(define-foreign-variable errno/2big int "E2BIG")

(define c-unveil
  (foreign-lambda int unveil (const c-string) (const c-string)))

(define (unveil path permissions)
  (unless (zero? (c-unveil path permissions))
    (handle-unveil-error)))

(define (unveil-lock)
  (unless (zero? (c-unveil #f #f))
    (handle-unveil-error)))

(define (handle-unveil-error)
  (error (case (errno)
           ((errno/2big)  "per-process unveil limit exceeded")
           ((errno/noent) "unreadable path")
           ((errno/inval) "invalid permission string")
           ((errno/eperm) "access violation or unveil() already locked")
           (else          "(unknown error)"))))
