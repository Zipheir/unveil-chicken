(foreign-declare "#include <unistd.h>")
(foreign-declare "#include <errno.h>")

(define-foreign-variable errno/2big int "E2BIG")

(define c-unveil
  (foreign-lambda int unveil (const c-string) (const c-string)))

(define (unveil path permissions)
  (unless (zero? (c-unveil path permissions))
    (handle-unveil-error (errno))))

(define (unveil-lock)
  (unless (zero? (c-unveil #f #f))
    (handle-unveil-error (errno))))

(define (handle-unveil-error err)
  (let ((desc `((,errno/2big .  "per-process unveil limit exceeded")
                (,errno/noent . "unreadable path")
                (,errno/inval . "invalid permission string")
                (,errno/perm  . "access violation or unveil already locked"))))
    (error (cond ((assv err desc) => cdr)
                 (else "(unknown error)"))
           err)))
