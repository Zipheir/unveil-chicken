(module (unveil)
  (unveil unveil-lock)

  (import (only (chicken base) include)
          (chicken foreign))

  (include "unveil-impl.scm"))
