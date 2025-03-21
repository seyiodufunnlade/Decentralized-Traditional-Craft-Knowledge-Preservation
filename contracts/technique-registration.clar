;; Technique Registration Contract
;; Documents traditional crafting methods

(define-data-var last-technique-id uint u0)

(define-map techniques
  { id: uint }
  {
    name: (string-ascii 100),
    description: (string-ascii 500),
    origin: (string-ascii 100),
    registrar: principal
  }
)

;; Register a new technique
(define-public (register-technique
    (name (string-ascii 100))
    (description (string-ascii 500))
    (origin (string-ascii 100))
  )
  (let
    (
      (new-id (+ (var-get last-technique-id) u1))
    )
    (var-set last-technique-id new-id)

    (map-set techniques
      { id: new-id }
      {
        name: name,
        description: description,
        origin: origin,
        registrar: tx-sender
      }
    )

    (ok new-id)
  )
)

;; Get technique details
(define-read-only (get-technique (technique-id uint))
  (map-get? techniques { id: technique-id })
)

;; Get total technique count
(define-read-only (get-technique-count)
  (var-get last-technique-id)
)
