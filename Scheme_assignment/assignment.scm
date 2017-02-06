;;; Problem 1
;;; Base Case: L is empty, return 0
;;; Assumption: (count-numbers M) returns a count of the numbers in M, for
;;; any list M smaller than L (including (car L) and (cdr L)).
;;; Step: If (car L) is a list, then return the sum of the count of the
;;; numbers in (car L) and the count of the numbers in (cdr L).
;;; If (car L) is a number, return 1 plus the count of the numbers in
;;; (cdr L). Otherwise, return the count of the numbers in (cdr L).

(define (count-numbers L)
    (cond ((null? L) 0)
          ((number? (car L)) (+ 1 (count-numbers (cdr L))))
          ((list? (car L)) (+ (count-numbers (car L)) (count-numbers (cdr L))))
          ((symbol? (car L)) (+ 0 (count-numbers (cdr L))))
          ) )

;;; Problem 2
;;; Base Case: L is empty, return (cons x L)
;;;Assumption (where the size of L is N), assume insert works on a list with N-1 elements. That is, assume (insert x (cdr L)) works
;;;Step: If x is less than or equal to (car L), return (cons x L). Else return (cons (car L) (insert x (cdr L))  )

(define (insert x L)
    (cond ((null? L) (cons x L))
          ((>= (car L) x) (cons x L))
          (else (cons (car L) (insert x (cdr L))  ) ) ) )

;;; Problem 3
;;; Base Case: L is empty, return M
;;;Assumption (where the size of L is N), assume insert-all works on a list with N-1 elements. That is, assume (insert-all (cdr L)) works
;;;Step: Call (insert (car L) M), and then call insert-all on (cdr L) and the resulting list from (insert (car L) M)

(define (insert-all L M)
  (cond ((null? L) M)
        (else (insert-all (cdr L) (insert (car L) M) ) )
  )
)

;;; Problem 4
;;; Basically a lambda version of insert and insert-all

(define (sort L)
  (letrec 
    (
           
           (insert (lambda (x L)
                     (cond ((null? L) (cons x L))
                           ((>= (car L) x) (cons x L))
                           (else (cons (car L) (insert x (cdr L)) )   )
                     )
                   )
           )
           
           (insert-all (lambda (L M)
                         (cond ((null? L) M)
                               (else (insert-all (cdr L) (insert (car L) M) ))
                          )
                       )
           )
     )
   (insert-all L '() ) 
   )
  )


;;;Problem 5
(define (translate a)
  (cond ((eq? '+ a) +)
        ((eq? '- a) -)
        ((eq? '* a) *)
        ((eq? '/ a) /)
  )
)

;;; Problem 6
;;;Base case: if exp is a list, take the third element to be the operator (convert from symbol to operator by using translate), and call postfix-eval on the second and third elements to get the first and second operands respectively
;;;Assumption: In a list, the third element is always the operand. 
;;;Step: if the base case isn't true, return the expression as it is

(define (postfix-eval exp)
        (cond ((list? exp) ((translate (caddr exp)) (postfix-eval (car exp)) (postfix-eval (cadr exp))) )
              (else exp)
        )
)

;;;Problem 7
;;; Base Case: L is empty, return the set containing the empty
;;; set, i.e. ’(()).
;;; Assumption: (powerset M) returns the powerset of M, for any set M
;;; smaller than L (including (cdr L)).
;;; Step: The powerset of L and the powerset of (cdr L) differ only in the elements that have (car L), i.e. the powerset of (cdr L) is a subset of the powerset of L. Therefore, to get the powerset of L, we get the powerset of (cdr L), and to each element (which is a list) in the latter set, we perform a (cons (car L) element)

(define (powerset L)
 (cond ((null? L) '(()))
       (else (let ((remaining_elements_powerset (powerset (cdr L))))
             (append 
             (map (lambda (L_subset) (cons (car L) L_subset))
             remaining_elements_powerset)
             remaining_elements_powerset )))))

