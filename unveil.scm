(module (unveil)
  (unveil unveil-lock)

  (import (scheme)
          (only (chicken base) declare include error unless)
          (chicken errno)
          (chicken foreign))

  (declare (disable-interrupts))
  (include "unveil-impl.scm"))
