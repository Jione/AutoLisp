;;
;; 3D 가속 활성화 단축명령어
;;

(defun c:3D nil 
(setvar 'cmdecho 0)
(command "-3dconfig" "Plot" "OFF" "acceLeration" "Hardware" "Enhanced" "ON" "Smooth" "OFF" "Material" "OFF" "gOoch" "OFF" "Per-pixel" "OFF" "Full" "OFF" "Texture" "OFF" "eXit")
(setvar 'cmdecho 1)
(princ)
)
