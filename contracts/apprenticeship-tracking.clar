;; Apprenticeship Tracking Contract
;; Records training and skill development

(define-data-var last-apprenticeship-id uint u0)

(define-map apprenticeships
  { id: uint }
  {
    apprentice: principal,
    master: principal,
    craft: (string-ascii 100),
    start-date: uint,
    status: (string-ascii 20) ;; "active", "completed", "terminated"
  }
)

;; Start a new apprenticeship
(define-public (start-apprenticeship
    (apprentice principal)
    (craft (string-ascii 100))
  )
  (let
    (
      (new-id (+ (var-get last-apprenticeship-id) u1))
    )
    (var-set last-apprenticeship-id new-id)

    (map-set apprenticeships
      { id: new-id }
      {
        apprentice: apprentice,
        master: tx-sender,
        craft: craft,
        start-date: block-height,
        status: "active"
      }
    )

    (ok new-id)
  )
)

;; Complete an apprenticeship
(define-public (complete-apprenticeship (apprenticeship-id uint))
  (let
    (
      (apprenticeship (unwrap! (map-get? apprenticeships { id: apprenticeship-id }) (err u404)))
    )
    (asserts! (is-eq tx-sender (get master apprenticeship)) (err u403))

    (map-set apprenticeships
      { id: apprenticeship-id }
      (merge apprenticeship { status: "completed" })
    )

    (ok true)
  )
)

;; Get apprenticeship details
(define-read-only (get-apprenticeship (apprenticeship-id uint))
  (map-get? apprenticeships { id: apprenticeship-id })
)
