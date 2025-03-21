;; Material Sourcing Contract
;; Tracks traditional and sustainable materials

(define-data-var last-material-id uint u0)

(define-map materials
  { id: uint }
  {
    name: (string-ascii 100),
    source: (string-ascii 100),
    sustainable: bool,
    registrar: principal
  }
)

;; Register a new material
(define-public (register-material
    (name (string-ascii 100))
    (source (string-ascii 100))
    (sustainable bool)
  )
  (let
    (
      (new-id (+ (var-get last-material-id) u1))
    )
    (var-set last-material-id new-id)

    (map-set materials
      { id: new-id }
      {
        name: name,
        source: source,
        sustainable: sustainable,
        registrar: tx-sender
      }
    )

    (ok new-id)
  )
)

;; Get material details
(define-read-only (get-material (material-id uint))
  (map-get? materials { id: material-id })
)

;; Get total material count
(define-read-only (get-material-count)
  (var-get last-material-id)
)
