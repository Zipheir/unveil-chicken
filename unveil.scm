(module (unveil)
  (unveil unveil-lock)

  (import (scheme)
          (only (chicken base) include)
          (chicken foreign))

  (include "unveil-impl.scm"))
