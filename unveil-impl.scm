(foreign-declare "#include <unistd.h>")
(foreign-declare "#include <errno.h>")

(define-foreign-variable errno/2big int "E2BIG")

(define-foreign-variable _errno int "errno")

(define c-unveil
  (foreign-lambda int unveil (const c-string) (const c-string)))

(define (unveil path permissions)
  (unless (zero? (c-unveil path permissions))
    (handle-unveil-error path permissions)))

(define (unveil-lock)
  (unless (zero? (c-unveil #f #f))
    (handle-unveil-error #f #f)))

(define (handle-unveil-error . irritants)
  (let ((desc `((,errno/2big .  "unveil: per-process unveil limit exceeded")
                (,errno/noent . "unveil: unreadable path")
                (,errno/inval . "unveil: invalid permission string")
                (,errno/perm  . "unveil: access violation"))))
    (apply error
           (cond ((assv _errno desc) => cdr)
                 (else "(unknown error)"))
           irritants)))
