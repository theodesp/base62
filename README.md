# base62
Simple base62 encoder/decoder in Racket Scheme

## What is Base62 encoding?

Base62 encoding converts numbers to ASCII strings (0-9, a-z and A-Z) and vice
versa, which typically results in comparatively short strings. Such identifiers
also tend to more readily identifiable by humans.

* `999` ≙ `"g7"`
* `9999` ≙ `"2Bh"`
* `238327` ≙ `"ZZZ"`

Example
--

```racket
#lang racket
(require "base62.rkt")

(base62-encode 100) ; "1C"
(base62-decode "1C") ; 100

(base62-encode "!") ; Throws
(base62-decode 1) ; Throws
```

License
---
MIT License © 2018 Theo Despoudis

