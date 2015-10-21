;;
;; TEST PROGRAM
;; 해당 객체의 속성을 표시해줍니다.
;;

(defun c:test ( / *error* nt buffer)
(defun *error* (x) (if nt(redraw nt 4)) (princ))
(setq nt (car (entsel)))
(princ nt)
(redraw nt 3)
(while nt
   (initget "Object Entity")
   (setq buffer (getkword (strcat "\n표시할 옵션 입력 [Entity(E)/VLA-Object(O)]: ")))
   (princ "\n")
      (cond
	((= buffer "Object")(princ (vlax-dump-object (vlax-ename->vla-object nt) t)))
	((= buffer "Entity")(princ (entget nt)))
      )
   (princ "\n\n")
)
(redraw nt 4)
(princ)
)
