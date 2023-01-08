((fn pair-fst (input-list)
  (car (car input-list)))
 (fn pair-snd (input-list)
  (car (cdr (car input-list))))
 (fn let-list-helper (bindings body)
  (if (empty? bindings)
   body
   (list (quote let) (pair-fst bindings) (pair-snd bindings)
    (let-list-helper (cdr bindings) body))))
 (macro let-list (bindings body)
  (let-list-helper bindings body))
 (fn cond-helper (branch-list)
  (if (== (pair-fst branch-list) (quote else))
   (pair-snd branch-list)
   (list (quote if) (pair-fst branch-list)
    (pair-snd branch-list)
    (cond-helper (cdr branch-list)))))
 (macro cond (branch-list)
  (cond-helper branch-list))
 (fn length (input-list)
  (if (empty? input-list) 0 (+ 1 (length (cdr input-list)))))
 (fn merge (input-list-1 input-list-2)
  (cond (((empty? input-list-1) input-list-2)
         ((empty? input-list-2) input-list-1)
         (else (let elem-1 (car input-list-1)
                 (let elem-2 (car input-list-2)
                   (if (< elem-1 elem-2)
                    (cons elem-1
                     (merge (cdr input-list-1) input-list-2))
                    (cons elem-2
                     (merge input-list-1 (cdr input-list-2))))))))))
 (fn take (num input-list)
  (if (== num 0)
   (list)
   (cons (car input-list) (take (- num 1) (cdr input-list)))))
 (fn drop (num input-list)
  (if (== num 0) input-list (drop (- num 1) (cdr input-list))))
 (fn sort (input-list)
  (if (|| (empty? input-list) (== (length input-list) 1))
   input-list
   (let half-length (/ (length input-list) 2)
    (merge (sort (take half-length input-list))
     (sort (drop half-length input-list))))))
 (sort (list 8 3 4 11 7 11 7)))

