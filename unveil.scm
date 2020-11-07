(module (unveil)
  (unveil unveil-lock)

  (import (scheme)
          (only (chicken base) declare include)
          (chicken foreign))

  (declare (disable-interrupts))
  (include "unveil-impl.scm"))
