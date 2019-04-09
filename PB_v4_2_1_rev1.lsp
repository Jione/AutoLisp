;;;
;;; CTB, PRINTER, PAPER 설정
;;;
;;; 이 부분의 변수 ctb_file, prt_name, paper_size 에 ctb파일이름,프린터설정세이브파일이름,용지설정이름으로 
;;; 대체한후 AutoCAD에서 로드하여야 한다.
;;; 
;;;

;Plot Device 설정
(setq prt_name "SINDOH N600 Series PCL")			;; 프린터 이름 설정
;(setq prt_name "\\\\YYB-01\\RICOH Aficio MP 1812L")		;; 중국용 프린터
(setq ctb_file "monochrome.ctb")				;; 펜 설정
;(setq paper_size_A1 "A1")					;; A1 용지 설정
;(setq paper_size_A2 "A2")					;; A2 용지 설정
(setq paper_size_A3 "A3")					;; A3 용지 설정
(setq paper_size_A4 "A4")					;; A4 용지 설정

;PDF Device 설정: ACAD2012
(setq pdf_prt_name "DWG To PDF.pc3")				;; 프린터 이름 설정
(setq pdf_ctb_file "monochrome.ctb")				;; 펜 설정
;(setq pdf_paper_size_A1 "ISO_expand_A1_(594.00_x_841.00_MM)")	;; A1 용지 설정
;(setq pdf_paper_size_A2 "ISO_expand_A2_(420.00_x_594.00_MM)")	;; A2 용지 설정
(setq pdf_paper_size_A3 "ISO_expand_A3_(297.00_x_420.00_MM)")	;; A3 용지 설정
(setq pdf_paper_size_A4 "ISO_expand_A4_(210.00_x_297.00_MM)")	;; A4 용지 설정

;정렬순서 선택(좌하단:"BL", 좌상단:"TL", 우상단:"TR", 우하단:"BR") -대문자로 작성-
(setq #Sort_Align "BL")

;출력용 Layer명 지정(PLOTBOX)
(setq #PlotClayer "0")			;;플롯용 박스 기본 레이어 설정 (Default: "0" , 다중 값 적용 시 "0,CL,HL" 형식)
(setq #PlotColor '(2 3 4 5))		;;플롯용 박스 색상 설정 (Default: nil, 값 적용시에는 '(1 2 3 4) 형식)


;;;
;;; PLOT 설정값 확인
;;;
;;; 평소 사용하는 환경으로 PLOT설정을 배치에 적용한 뒤,
;;; PLOTNAME 명령으로 위의 값을 확인할 수 있다.
;;;

(defun c:PLOTNAME ()
(princ "\n플로터 이름: ") (prin1 (vla-get-ConfigName LayObj))
(princ "\n용지 이름: ") (prin1 (vla-get-CanonicalMediaName LayObj))
(princ "\n펜 이름: ") (prin1 (vla-get-StyleSheet LayObj))
(princ "\n")(princ)
)

;;;
;;;
;;; 출력 명령어 설정
;;; C:OOO 를 원하는 명령으로 바꾼다.
;;;
;;; -기본 명령어-
;;; PX: 박스로 된 도면외각을 선택하여 출력한다.
;;; PA: 블록 및 박스로 된 도면외각을 선택하여 출력한다.
;;; PXX: 도면 전체를 출력한다.
;;; RV: 도면 출력과 동일하게 미리보기를 한다.
;;; PB: PLOT 전용 사각박스를 생성한다.
;;; PDF: 박스로 된 도면외각을 PDF파일로 출력한다.
;;; CT: 출력 가능한 박스로 된 도면외각을 검사한다.
;;; CA: 출력 가능한 블록 및 박스로 된 도면외각을 검사한다.
;;;
;;;

(defun C:PI () (prompt (strcat "PLOTINSERT\n출력할 블록 도곽을 선택...")) (#PLOT_EXPRESS "PI_Mode" paper_size_A4))
(defun C:PX () (prompt (strcat "PLOTEXPRESS\n출력할 도면 선택...")) (#PLOT_EXPRESS "Plot_Mode" paper_size_A4))
(defun C:PA () (prompt (strcat "PLOTALL\n출력할 모든 도면 선택...")) (#PLOT_EXPRESS "ALLPlot_Mode" paper_size_A4))
(defun C:PXX () (prompt (strcat "PLOTEXPRESSALL\nPLOT전용 LAYER 전체 출력...")) (#PLOT_EXPRESS "AP_Mode" paper_size_A4))
(defun C:RV () (prompt (strcat "DREVIEW\n미리보기 할 도면 선택...")) (#PLOT_EXPRESS "RV_Mode" nil))
(defun C:PB () (prompt (strcat "PLOTBOX\nPLOT전용 BOX 생성...")) (c:PLOTBOX))
(defun C:PDF () (prompt (strcat "PDFOUT\nPDF로 내보내기...")) (#PLOT_EXPRESS "PDF_Mode" pdf_paper_size_A4))
(defun C:CT () (prompt (strcat "CHKPLOT\nPLOT이 가능한 객체 확인하기...")) (#PLOT_EXPRESS "CHK_Mode" nil))
(defun C:CA () (prompt (strcat "CHKPLOTALL\nPLOT이 가능한 모든 객체 확인하기...")) (#PLOT_EXPRESS "ALLCHK_Mode" nil))

;;;
;;;A3 대응 명령어
;;;

(defun C:PX3 () (prompt (strcat "PLOTEXPRESS\n출력할 도면 선택...")) (#PLOT_EXPRESS "Plot_Mode" paper_size_A3))
(defun C:PA3 () (prompt (strcat "PLOTALL\n출력할 모든 도면 선택...")) (#PLOT_EXPRESS "ALLPlot_Mode" paper_size_A3))
;(defun C:PXX3 () (prompt (strcat "PLOTEXPRESSALL\nPLOT전용 LAYER 전체 출력...")) (#PLOT_EXPRESS "AP_Mode" paper_size_A3))
;(defun C:PDF3 () (prompt (strcat "PDFOUT\nPDF로 내보내기...")) (#PLOT_EXPRESS "PDF_Mode" pdf_paper_size_A3))


;;;
;;;
;;; 도면 Open 시 자동으로 플로터 확인
;;;
;;;

(vl-load-com)
(setq AcDoc (vla-get-ActiveDocument (vlax-get-acad-object)))
(setq LayObj (vla-get-ActiveLayout AcDoc))

(and
  (or
    (and
      (member prt_name (vlax-safearray->list (vlax-variant-value (vla-GetPlotDeviceNames LayObj))))
      (member ctb_file (vlax-safearray->list (vlax-variant-value (vla-GetPlotStyleTableNames LayObj))))
      ;;(member paper_size (vlax-safearray->list (vlax-variant-value (vla-GetCanonicalMediaNames LayObj))))
    )
    (prompt "\nLISP: 플롯 설정값이 올바르지 않음. PLOTNAME 명령으로 현재 설정값을 확인하십시오.")
  )
  (or
    (/= (vla-get-ConfigName LayObj) prt_name)
    (/= (vla-get-StyleSheet LayObj) ctb_file)
    (/= (vla-get-CanonicalMediaName LayObj) paper_size_A4)
  )
  (progn
    (vla-put-ConfigName LayObj prt_name)
    (vla-put-StyleSheet LayObj ctb_file)
    (vla-put-CanonicalMediaName LayObj paper_size_A4)
  )
)

;;;
;;;
;;; 도면 Open 시 자동으로 UCS 초기화
;;;
;;;

(if (= (getvar "worlducs") 0) (and (setvar "cmdecho" 0) (vl-cmdf "UCS" "") (setvar "cmdecho" 1) (prompt (strcat "\n **UCS Initialized** "))))

;;;
;;;
;;; 카메라뷰 초기화
;;;
;;;

(while (> (vla-get-count (vla-get-views AcDoc)) 0) (vla-delete (vla-item (vla-get-views AcDoc) 0)))
(or (equal (getvar 'target) '(0 0 0)) (and (setvar "cmdecho" 0) (vl-cmdf "dview" "" "point" '(0 0 0) '(0 0 1) "" "zoom" "extent") (setvar "cmdecho" 1) (prompt (strcat "\n **Camera Initialized** "))))

;;;
;;;
;;; 치수 연관 해제
;;;
;;;

(or (= (getvar 'DIMASSOC) 1) (setvar 'DIMASSOC 1))

;;;
;;;
;;; 소수점 단위환산 초기화
;;;
;;;

(or (> (getvar 'luprec) 3) (setvar 'luprec 4))

;;;
;;;
;;;    플롯박스 만들기
;;;
;;; CLA에 해당하는 layer에 4각 폴리곤을 작성한다.
;;; 해당 layer가 없을 경우 자동으로 작성한다.
;;; 4각 폴리곤을 도면폼 외곽에 씌우면 차후에 일괄출력에 활용가능하다.
;;;
;;;

(defun c:PLOTBOX ( / COL CLA pt)
(if (= (getvar "worlducs") 0) (and (setvar "cmdecho" 0) (vl-cmdf "UCS" "") (setvar "cmdecho" 1)))
(if #PlotClayer
  (or (and (vl-string-search ","  #PlotClayer) (setq CLA (substr #PlotClayer 1 (vl-string-search "," #PlotClayer)))) (setq CLA #PlotClayer))
)
(and #PlotColor (listp #PlotColor) (setq COL (car #PlotColor)))
(if (= nil (tblsearch "layer" CLA))
  (entmake (list (cons 0 "LAYER") (cons 100 "AcDbSymbolTableRecord") (cons 100 "AcDbLayerTableRecord")
		 (cons 2 CLA) (cons 6 "CONTINUOUS") (cons 62 2) (cons 70 0)
	   )
  )
)
(and (setq pt (getpoint "첫 번째 구석점 지정: "))
     (cadr (setq pt (list pt (getcorner pt "다른 구석점 지정: "))))
     (setq pt (list (list (caar pt) (caadr pt)) (list (cadar pt) (cadadr pt))))
)
(if (= (length pt) 2)
  (entmake 
    (vl-remove-if 'not
	(list (cons 0 "LWPOLYLINE") (cons 100 "AcDbEntity") (cons 8 CLA)
	      (if COL (cons 62 COL)) (cons 100 "AcDbPolyline") (cons 90 4) (cons 70 1)
	      (cons 10 (list (apply 'min (car pt)) (apply 'min (cadr pt))))
	      (cons 10 (list (apply 'max (car pt)) (apply 'min (cadr pt))))
	      (cons 10 (list (apply 'max (car pt)) (apply 'max (cadr pt))))
	      (cons 10 (list (apply 'min (car pt)) (apply 'max (cadr pt))))
	)
    )
  )
)(princ)
)

;;;
;;;
;;;    박스 정렬
;;;
;;; 박스를 선택한 순서를 기준으로 x축 방향으로 재정렬한다.
;;;
;;;

(defun PTE:highlight (ss x) (mapcar '(lambda (ent)(redraw ent x)) (vl-remove-if 'listp (mapcar 'cadr (ssnamex ss)))))

(defun #SS_Sort_Sub (ss / n buffer ss_lst)
(setq n (cadddr (car (ssnamex ss))))
(foreach x (ssnamex ss)
  (if (equal n (cadddr x))
    (setq buffer (append buffer (list (cadr x))))
    (setq ss_lst (append ss_lst (list (list n buffer))) n (cadddr x) buffer (list (cadr x)))
  )
)
(setq ss_lst (vl-remove-if '(lambda (x) (listp (car (cadr x)))) (append ss_lst (list (list n buffer)))))
ss_lst
)

(defun #SS_Sort_Main (ss / SortSS MinPt MaxPt MinPtB MaxPtB)
(setq SortSS (ssadd))
(foreach x (#SS_Sort_Sub ss)
  (if (= (length (cadr x)) 1)
    (ssadd (car (cadr x)) SortSS)
    (mapcar '(lambda (f) (ssadd f SortSS))
      (vl-sort (cadr x)
	'(lambda (a b)
	 (if
	  (equal 
	    (cadr
	      (progn (vla-GetBoundingBox (vlax-ename->vla-object a) 'MinPt 'MaxPt)
		(if (or (= #Sort_Align "TL") (= #Sort_Align "TR")) (vlax-safearray->list MaxPt) (vlax-safearray->list MinPt))
	      )
	    )
	    (cadr
	      (progn (vla-GetBoundingBox (vlax-ename->vla-object b) 'MinPtB 'MaxPtB)
		(if (or (= #Sort_Align "TL") (= #Sort_Align "TR")) (vlax-safearray->list MaxPtB) (vlax-safearray->list MinPtB))
	      )
	    )
	    40.0;무시하는 고저 차이값 범위
	  )
	  (if (or (= #Sort_Align "BR") (= #Sort_Align "TR"))
	    (< (car (vlax-safearray->list MaxPt)) (car (vlax-safearray->list MaxPtB)))
	    (< (car (vlax-safearray->list MinPt)) (car (vlax-safearray->list MinPtB)))
	  )
	  (if (or (= #Sort_Align "TL") (= #Sort_Align "TR"))
	    (> (cadr (vlax-safearray->list MaxPt)) (cadr (vlax-safearray->list MaxPtB)))
	    (> (cadr (vlax-safearray->list MinPt)) (cadr (vlax-safearray->list MinPtB)))
	  )
	 )
	)
      )
    )
  )
)SortSS
)

(defun List->Safearray (lst) (vlax-safearray-fill (vlax-make-safearray vlax-vbdouble (cons 0 (1- (length lst)))) lst))

(defun #PantaList ($CP $DS $LP / P0 P1 P2 P3 P4 P5)
(setq P0 (list (car $CP) (cadr $CP)))
(if (= $LP 1)
  (setq P1 (polar P0 (/ pi 2.0) (* $DS 0.2))
	P2 (polar P0 2.85184 (* $DS 0.35))
	P3 (polar P0 3.43134 (* $DS 0.35))
	P4 (polar P0 5.99343 (* $DS 0.35))
	P5 (polar P0 0.289752 (* $DS 0.35))
  )
  (setq P1 (polar P0 (/ pi 2.0) (* $DS 0.3))
	P2 (polar P0 2.32754 (* $DS 0.25))
	P3 (polar P0 3.95565 (* $DS 0.25))
	P4 (polar P0 5.46913 (* $DS 0.25))
	P5 (polar P0 0.814053 (* $DS 0.25))
  )
)(list P1 P2 P3 P4 P5)
)

(defun #BoxReaction (ss SF_List / en n MinPt MaxPt ns nb bf di LP)
(repeat (setq n (sslength ss))
  (and
    (setq en (ssname ss (setq n (1- n))))
    (progn
      (command "zoom" "object" en "")(graphscr)
      (vla-GetBoundingBox (vlax-ename->vla-object en) 'MinPt 'MaxPt)
      (setq MinPt (vlax-safearray->list MinPt) MaxPt (vlax-safearray->list MaxPt))
      (if
	(and
	  (< 70 (setq di (distance MinPt MaxPt)))
	  (or
	    (and (equal (setq bf (angle MinPt MaxPt)) 0.615504 0.03) (setq LP 1))
	    (and (equal bf 0.955293 0.03) (setq LP 0))
	  )
	  (or
	    (not (= (cdr (assoc 0 (setq bf (entget en)))) "INSERT"))
	    (not
	      (ssget "CP"
		(#PantaList
		  (list (/ (+ (car MinPt) (car MaxPt)) 2) (/ (+ (cadr MinPt) (cadr MaxPt)) 2))
		  di
		  LP
		)
		(list (cons 0 "INSERT") (cons 2 (cdr (assoc 2 bf))))
	      )
	    )
	  )
	)
	  (if (setq nb 0 ns (ssget "w" MinPt MaxPt SF_List))
	    (progn (ssdel en ns) (repeat (sslength ns) (ssdel (ssname ns nb) ss) (setq nb (1+ nb))))
	  )
	  (ssdel en ss)
      )
    )
  )
)ss
)


;;;
;;;   PDF 넘버링
;;;
;;; PDF파일의 넘버를 증가하거나 감소한다.
;;;
;;;

(defun $PDF_NUM_ADD ( / n TXT1 TXT2 FN F1 F2)
(setq n 0
      TXT1
        (vl-list->string
	  (reverse
	    (vl-remove-if '(lambda (f) (= 0 (if (= f 92) (setq n nil) n))) (reverse (vl-string->list #PDF_Filename)))
	  )
        )
      TXT2 (substr #PDF_Filename (1+ (strlen TXT1)))
      FN (substr TXT2 1 (- (setq n (strlen TXT2)) 4))
)
(if (< 4 n)
  (progn
    (setq n 0
	  F2 (reverse (vl-remove-if '(lambda (f) (= nil (if (or (< f 48) (> f 57)) (setq n nil) n))) (reverse (vl-string->list FN))))
	  F1 (substr FN 1 (- (strlen FN) (length F2)))
    )
    (setq F2 (vl-string->list (itoa (fix (1+ (atoi (vl-list->string F2)))))))
    (if (> 3 (length F2)) (while (> 3 (length F2)) (setq F2 (append (list 48) F2))))
    (setq F2 (vl-list->string F2) FN (strcat F1 F2))
  )
  (setq FN (strcat FN "001"))
)(setq #PDF_Filename (strcat TXT1 FN ".pdf"))#PDF_Filename
)


(defun $PDF_NUM_MINUS ( / n TXT1 TXT2 FN F1 F2)
(setq n 0
      TXT1
        (vl-list->string
	  (reverse
	    (vl-remove-if '(lambda (f) (= 0 (if (= f 92) (setq n nil) n))) (reverse (vl-string->list #PDF_Filename)))
	  )
        )
      TXT2 (substr #PDF_Filename (1+ (strlen TXT1)))
      FN (substr TXT2 1 (- (setq n (strlen TXT2)) 4))
)
(if (< 4 n)
  (progn
    (setq n 0
	  F2 (reverse (vl-remove-if '(lambda (f) (= nil (if (or (< f 48) (> f 57)) (setq n nil) n))) (reverse (vl-string->list FN))))
	  F1 (substr FN 1 (- (strlen FN) (length F2)))
    )
    (setq F2 (vl-string->list (itoa (fix (1- (atoi (vl-list->string F2)))))))
    (if (> 3 (length F2)) (while (> 3 (length F2)) (setq F2 (append (list 48) F2))))
    (setq F2 (vl-list->string F2) FN (strcat F1 F2))
  )
  (setq FN (strcat FN "001"))
)(setq #PDF_Filename (strcat TXT1 FN ".pdf"))#PDF_Filename
)


;;;
;;;   PDF PLOT설정값 적용함수
;;;
;;; 도각없이 PDF출력을 진행하기 전 PLOTTER 설정값을 변경한다.
;;;
;;;

(defun #PDF_Plot_Active (Paper / pdf_prt_name pdf_ctb_file pdf_paper_size_A1 pdf_paper_size_A2 pdf_paper_size_A3 pdf_paper_size_A4)
(setq pdf_prt_name "DWG To PDF.pc3")				;; 프린터 이름 설정
(setq pdf_ctb_file "monochrome.ctb")				;; 펜 설정
(setq pdf_paper_size_A1 "ISO_expand_A1_(594.00_x_841.00_MM)")	;; A1 용지 설정
(setq pdf_paper_size_A2 "ISO_expand_A2_(420.00_x_594.00_MM)")	;; A2 용지 설정
(setq pdf_paper_size_A3 "ISO_expand_A3_(297.00_x_420.00_MM)")	;; A3 용지 설정
(setq pdf_paper_size_A4 "ISO_expand_A4_(210.00_x_297.00_MM)")	;; A4 용지 설정

(vla-put-ConfigName LayObj pdf_prt_name)
(vla-put-StyleSheet LayObj pdf_ctb_file)
(foreach x 
  (list (list pdf_paper_size_A1 "*A1*") (list pdf_paper_size_A2 "*A2*") (list pdf_paper_size_A3 "*A3*") (list pdf_paper_size_A4 "*A4*"))
  (if (wcmatch Paper (cadr x)) (vla-put-CanonicalMediaName LayObj (car x)))
)

(setvar "backgroundplot" 0)
(vla-put-paperunits LayObj acmillimeters)
(vla-put-centerplot LayObj :vlax-true)
)


;;;
;;;   PDF출력
;;;
;;; PDF출력을 실행한다.
;;;
;;;

(defun #PDF_Plot (BPoint OffPoint LP PScale PDF_Filename / AcPlot DCSFix MinPt MaxPt)
(setq AcPlot (vla-get-plot (vla-get-ActiveDocument (vlax-get-acad-object)))
      DCSFix (trans '(0 0) 2 0)
      MinPt (List->Safearray (list (- (car BPoint) (car DCSFix)) (- (cadr BPoint) (cadr DCSFix))))
      MaxPt (List->Safearray (list (- (car OffPoint) (car DCSFix)) (- (cadr OffPoint) (cadr DCSFix))))
)
(vla-put-PlotRotation LayObj LP)
(if (= 1.0 PScale)
  (vla-SetCustomScale LayObj 1 1)
  (if (numberp PScale) (vla-SetCustomScale LayObj 1 PScale) (vla-put-standardscale LayObj acVpScaleToFit))
)
(vla-SetWindowToPlot LayObj MinPt MaxPt)
(vla-put-PlotType LayObj AcWindow)
(vla-PlotToFile AcPlot #PDF_Filename)
)


;;;
;;;   PDF 영역선택
;;;
;;; 도각없이 PDF출력을 진행할 영역을 선택한다.
;;;
;;;

(defun #PDF_Main (Pa Sc LS / *error* OSM P1 P2 Buffer)
(prompt "PDFPLOT\nPDF로 출력할 구역을 지정...")
(defun *error* (x) (setvar 'osmode OSM))
(setq OSM (getvar 'osmode))
(setvar 'osmode 191)

(or (setq P2 (getcorner (setq P1 (getpoint "\n첫번째 구석 지정: ")) "\n반대 구석 지정: ")) (quit))
(if #PDF_Filename ($PDF_NUM_ADD) (setq #PDF_Filename (strcat (getvar "mydocumentsprefix") "\\" (substr (getvar "dwgname") 1 (- (strlen (getvar "dwgname")) 4)) "_001.pdf")))
(if (setq Buffer (getfiled "PDF 파일 작성" #PDF_Filename "pdf" 1))
  (and
    (setq #PDF_Filename Buffer)
    ($PDF_NUM_ADD)
    ($PDF_NUM_MINUS)
  )
)
(#PDF_Plot_Active Pa)

(while T
  (setq buffer P1
	P1 (list (apply 'min (list (car P1) (car P2))) (apply 'min (list (cadr P1) (cadr P2))))
	P2 (list (apply 'max (list (car buffer) (car P2))) (apply 'max (list (cadr buffer) (cadr P2))))
  )
  (if (and LS (numberp LS))
    (setq LP (logand 1 (fix LS)))
    (if (< (- (car P1) (car P2)) (- (cadr P1) (cadr P2))) (setq LP 1) (setq LP 0))
  )
  (#PDF_Plot P1 P2 LP Sc #PDF_Filename)
  (prompt (strcat "\n경로: " #PDF_Filename " 로 저장 됨..."))
  (or (setq P2 (getcorner (setq P1 (getpoint "\n첫번째 구석 지정: ")) "\n반대 구석 지정: ")) (quit))
  ($PDF_NUM_ADD)
)(princ)
)


;;;
;;;
;;;   박스 출력
;;;
;;; 선택한 4각 폴리곤의 도면을 출력한다.
;;; 다중선택도 가능하다.
;;;
;;;

(defun #PLOT_EXPRESS ($Mode $Size / *error* AcDoc AcLay AcPlot paper_size sa ss n MinPt MaxPt LP SF_List CLA COL)
(defun *error* (x) (setvar 'cmdecho 1) (and AcDoc (vla-endundomark AcDoc)) (gc) (princ))
(if (= (getvar "worlducs") 0) (and (setvar "cmdecho" 0) (vl-cmdf "UCS" "") (setvar "cmdecho" 1)))
(setq CLA #PlotClayer);;전체 자동출력 시 Plot전용 Layer 설정값
(setq COL #PlotColor);;전체 자동출력 시 Plot전용 색상 설정값
(if (or (= $Mode "Plot_Mode") (= $Mode "CHK_Mode"))
  (setq SF_List
    (list
      (cons -4 "<OR")
	(cons -4 "<AND") (cons 0 "LWPOLYLINE") (cons 40 0) (cons 41 0) (cons 90 4) (cons -4 "AND>") ;열린 폴리선도 선택가능
	(cons -4 "<AND") (cons 0 "LWPOLYLINE") (cons 40 0) (cons 41 0) (cons 90 5) (cons -4 "AND>") ;닫힌 폴리선도 선택가능
      (cons -4 "OR>")
    )
  )
  (if (= $Mode "PI_Mode")
    (setq SF_List (list (cons 0 "INSERT")));기존명령 지원
    (setq SF_List
      (list
	(cons -4 "<OR")
	  (cons 0 "INSERT") ;BLOCK,BOX도곽 통합
	  (cons -4 "<AND") (cons 0 "LWPOLYLINE") (cons 40 0) (cons 41 0) (cons 90 4) (cons -4 "AND>") ;열린 폴리선도 선택가능
	  (cons -4 "<AND") (cons 0 "LWPOLYLINE") (cons 40 0) (cons 41 0) (cons 90 5) (cons -4 "AND>") ;닫힌 폴리선도 선택가능
	(cons -4 "OR>")
      )
    )
  )
)

(setq AcDoc (vla-get-ActiveDocument (vlax-get-acad-object))
      AcLay (vla-get-activelayout AcDoc)
      AcPlot (vla-get-plot AcDoc)
      n 0
)

(if $Size (setq paper_size $Size) (and (= $Mode "PDF_Mode") (setq paper_size pdf_paper_size_A4)))

(if (= $Mode "PDF_Mode")
  (and
    (if #PDF_Filename ($PDF_NUM_ADD) (setq #PDF_Filename (strcat (getvar "dwgprefix") (substr (getvar "dwgname") 1 (- (strlen (getvar "dwgname")) 4)) "_001.pdf")))
    (or
      (/= (vla-get-ConfigName AcLay) pdf_prt_name)
      (/= (vla-get-StyleSheet AcLay) pdf_ctb_file)
      (/= (vla-get-CanonicalMediaName AcLay) paper_size)
    )
    (progn
      (vla-put-ConfigName AcLay pdf_prt_name)
      (vla-put-StyleSheet AcLay pdf_ctb_file)
      (vla-put-CanonicalMediaName AcLay paper_size)
    )
  )
  (and
    $Size
    (and (/= $Mode "ALLCHK_Mode") (/= $Mode "CHK_Mode"))
    (or
      (/= (vla-get-ConfigName AcLay) prt_name)
      (/= (vla-get-StyleSheet AcLay) ctb_file)
      (/= (vla-get-CanonicalMediaName AcLay) paper_size)
    )
    (progn
      (vla-put-ConfigName AcLay prt_name)
      (vla-put-StyleSheet AcLay ctb_file)
      (vla-put-CanonicalMediaName AcLay paper_size)
    )
  )
)

(and 
  (if (= $Mode "PDF_Mode")
    (and
      (if (setq Buffer (getfiled "PDF 파일 작성" #PDF_Filename "pdf" 1))
	(and
	  (setq #PDF_Filename Buffer)
	  ($PDF_NUM_ADD)
	  ($PDF_NUM_MINUS)
	)
      )
    ) T
  )
  (if (= $Mode "AP_Mode")
    (progn
      (initget "Yes No")
      (if (/= (getkword (strcat "\n플롯 박스로 작성된 도면을 전체 출력하시겠습니까? (출력 레이어: \"" CLA "\"/ 색상: \""
				  (if (and COL (listp COL))
				    (setq Buffer (substr (setq Buffer (apply 'strcat (mapcar '(lambda (x) (strcat (rtos x) ",")) COL))) 1 (1- (strlen Buffer))))
				    (strcat "미지정")
				  )
				"\") [예(Y)/아니오(N)] <Y>: "
			)
	      )
	    "No"
	  )
	(setq sa
	  (ssget "x"
	    (append (list (cons -4 "<OR") (cons -4 "<AND"))
	      (vl-remove-if 'not 
		(append (list (cons 0 "LWPOLYLINE") (cons 8 CLA) (cons -4 "<OR") (cons 90 4) (cons 90 5) (cons -4 "OR>") (cons 40 0) (cons 41 0))
			(if (and COL (listp COL)) (append (list (cons -4 "<OR")) (mapcar '(lambda (x) (cons 62 x)) COL) (list (cons -4 "OR>"))))
		)
	      )
	      (list (cons -4 "AND>") (cons -4 "<AND"))
	      (vl-remove-if 'not 
		(append (list (cons 0 "INSERT") (cons 8 CLA))
			(if (and COL (listp COL)) (append (list (cons -4 "<OR")) (mapcar '(lambda (x) (cons 62 x)) COL) (list (cons -4 "OR>"))))
		)
	      )
	      (list (cons -4 "AND>") (cons -4 "OR>"))
	    )
	  )
	)
	(progn
	  (prompt (strcat "\n레이어 \"" CLA "\"/ 색상: \"" (if (and COL (listp COL)) (strcat Buffer) (strcat "미지정"))"\" 로 작성된 플롯 박스를 선택..."))
	  (setq sa
	    (ssget
	      (append (list (cons -4 "<OR") (cons -4 "<AND"))
		(vl-remove-if 'not 
		  (append (list (cons 0 "LWPOLYLINE") (cons 8 CLA) (cons -4 "<OR") (cons 90 4) (cons 90 5) (cons -4 "OR>") (cons 40 0) (cons 41 0))
			  (if (and COL (listp COL)) (append (list (cons -4 "<OR")) (mapcar '(lambda (x) (cons 62 x)) COL) (list (cons -4 "OR>"))))
		  )
		)
		(list (cons -4 "AND>") (cons -4 "<AND"))
		(vl-remove-if 'not 
		  (append (list (cons 0 "INSERT") (cons 8 CLA))
			  (if (and COL (listp COL)) (append (list (cons -4 "<OR")) (mapcar '(lambda (x) (cons 62 x)) COL) (list (cons -4 "OR>"))))
		  )
		)
		(list (cons -4 "AND>") (cons -4 "OR>"))
	      )
	    )
	  )
	)
      )
    )
    (setq sa (ssget SF_List))
  )
  (progn (vla-startundomark AcDoc) (setvar "cmdecho" 0) (command "zoom" "object" sa "")(graphscr) (setq ss (#SS_Sort_Main sa)))
  (#BoxReaction ss SF_List)
  (/= (sslength ss) 0)
  (if (or (= $Mode "ALLCHK_Mode") (= $Mode "CHK_Mode"))
    (progn
      (command "zoom" "object" ss "")(graphscr)
      (setq sa (ssadd))
      (repeat (sslength ss)
	(vla-GetBoundingBox (vlax-ename->vla-object (ssname ss n)) 'MinPt 'MaxPt)
	(setq MaxPt (vlax-safearray->list MaxPt) n (1+ n))
	(entmake (list (cons 0 "CIRCLE") (cons 8 "0") (cons 62 4) (cons 10 MaxPt) (cons 40 55.0)))
	(ssadd (entlast) sa)
      )
      (prompt (strcat "\n" (rtos n 2 0) "장 출력이 가능합니다."))
      (command "group" "Create" "*" "CHKPLOT" sa "" nil)
      (setvar "cmdecho" 1)
      (vlr-beep-reaction)
    )
    T
  )
  (progn
    (setvar "backgroundplot" 0)
    (vla-put-paperunits AcLay acmillimeters)
    ;(vla-put-standardscale AcLay acvpscaletofit)
    ;(vla-put-centerplot AcLay :vlax-true)
    (command "zoom" "object" ss "")(graphscr)
    (setvar "cmdecho" 1)
    (repeat (sslength ss)
      (vla-GetBoundingBox (vlax-ename->vla-object (ssname ss n)) 'MinPt 'MaxPt)
      (setq MinPt (vlax-safearray->list MinPt)
	    MaxPt (vlax-safearray->list MaxPt)
	    n (1+ n)
      )
      (ssget "W" MinPt MaxPt)
      (if (< (- (car MinPt) (car MaxPt)) (- (cadr MinPt) (cadr MaxPt)))	(setq LP 1) (setq LP 0))
      (setq DCSFix (trans '(0 0) 2 0)
	    MinPt (List->Safearray (list (- (car MinPt) (car DCSFix)) (- (cadr MinPt) (cadr DCSFix))))
	    MaxPt (List->Safearray (list (- (car MaxPt) (car DCSFix)) (- (cadr MaxPt) (cadr DCSFix))))
      )
      (vla-put-PlotRotation AcLay LP)
      (vla-SetWindowToPlot AcLay MinPt MaxPt)
      (vla-put-PlotType AcLay AcWindow)
      (vla-put-standardscale AcLay acvpscaletofit)
      (vla-put-centerplot AcLay :vlax-true)
      (vla-GetCustomScale AcLay 'MinPt 'MaxPt)
      (if (> 1.0 MaxPt)
        (progn
	  (setq MinPt (/ MinPt MaxPt 0.1) MaxPt 1.0)
	  (and (> (setq MinPt (float (fix MinPt))) 20.0) (setq MinPt (- MinPt (rem MinPt 5.0))))
	)
        (progn
	  (setq MaxPt (/ MaxPt MinPt) MinPt 1.0)
	  (and (> (setq MaxPt (float (fix MaxPt))) 20.0) (setq MaxPt (- MaxPt (rem MaxPt 5.0))))
	)
      )
      (vla-SetCustomScale AcLay MinPt MaxPt)
      (if (= $Mode "RV_Mode")
	(vla-DisplayPlotPreview AcPlot acPartialPreview)
	(if (= $Mode "PDF_Mode")
	  (progn (vla-PlotToFile AcPlot #PDF_Filename) ($PDF_NUM_ADD) (PTE:highlight (ssget "P") 2)) ;;출력객체 숨김 옵션 적용
	  (progn (vla-PlotToDevice AcPlot) (PTE:highlight (ssget "P") 2)) ;;출력객체 숨김 옵션
	)
      )
    )
    (sssetfirst nil ss) (ssget)
    (setvar "cmdecho" 1)
    (if (/= $Mode "RV_Mode")
      (prompt 
	(strcat "\n" (getvar "dwgprefix")(getvar "dwgname")
	  (if (= $Mode "PDF_Mode") "\n" "\n\n출력된 객체를 표현하려면 Regen명령으로 재생성...\n")
	  (rtos n 2 0) " 장이 출력되었습니다."
	)
      )
      (prompt (strcat "\n" (rtos n 2 0) "장을 미리보기 완료하였습니다."))
    )
    (if (and (/= $Mode "RV_Mode") (> n 1))
      (alert 
	(strcat "\n\t" (getvar "dwgname") "\n\t" (rtos n 2 0) " 장이 출력되었습니다."
	  (if (= $Mode "PDF_Mode") "" "\n\n\t출력된 객체를 표현하려면 Regen명령으로 객체 재생성이 필요합니다.")
	)
      )
    )(vlr-beep-reaction) ;;출력완료 신호음
  )
)
(if (= $Mode "PDF_Mode") ($PDF_NUM_MINUS))
(vla-endundomark AcDoc)
(gc)
(princ)
)(gc)


;PDF출력 명령어 - 도각없이 선택영역을 PDF로 출력
;(defun c:SA4PDF nil (#PDF_Main "A4" 0.98 0))	;A4/1:0.98/세로방향 PDF 출력
;(defun c:SA3PDF nil (#PDF_Main "A3" 0.98 0))	;A3/1:0.98/세로방향 PDF 출력
;(defun c:A4PDF nil (#PDF_Main "A4" 1 1))	;A4/1:1/가로방향 PDF 출력
;(defun c:A3PDF nil (#PDF_Main "A3" 1 1))	;A3/1:1/가로방향 PDF 출력
(defun c:PDF4 nil (#PDF_Main "A4" "Fit" nil))	;A4규격 자동 가로세로/용지맞춤 PDF출력
;(defun c:PDF3 nil (#PDF_Main "A3" "Fit" nil))	;A3규격 자동 가로세로/용지맞춤 PDF출력


(defun C:PLOTEXPRESS () (prompt (strcat "PLOTEXPRESS\n출력할 도면 선택...")) (#PLOT_EXPRESS "Plot_Mode" nil))
(defun C:PLOTALL () (prompt (strcat "PLOTALL\n출력할 모든 도면 선택...")) (#PLOT_EXPRESS "ALLPlot_Mode" nil))
(defun C:PLOTEXPRESSALL () (prompt (strcat "PLOTEXPRESSALL\nPLOT전용 LAYER 전체 출력...")) (#PLOT_EXPRESS "AP_Mode" nil))
(defun C:DREVIEW () (prompt (strcat "DREVIEW\n미리보기 할 도면 선택...")) (#PLOT_EXPRESS "RV_Mode" nil))
(defun C:PDFOUT () (prompt (strcat "PDFOUT\nPDF로 내보내기...")) (#PLOT_EXPRESS "PDF_Mode" nil))
(defun C:CHKPLOT () (prompt (strcat "CHKPLOT\nPLOT객체 확인하기...")) (#PLOT_EXPRESS "CHK_Mode" nil))
(defun C:CHKPLOTALL () (prompt (strcat "CHKPLOTALL\nPLOT이 가능한 모든 객체 확인하기...")) (#PLOT_EXPRESS "ALLCHK_Mode" nil))