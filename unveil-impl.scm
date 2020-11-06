(foreign-declare "#include <unistd.h>")

(define c-unveil
  (foreign-lambda int unveil (const c-string) (const c-string)))

(define (unveil path permissions)
  (c-unveil path permissions))

(define (unveil-lock) (c-unveil #f #f))
