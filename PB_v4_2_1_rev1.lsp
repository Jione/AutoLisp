;;;
;;; CTB, PRINTER, PAPER ����
;;;
;;; �� �κ��� ���� ctb_file, prt_name, paper_size �� ctb�����̸�,�����ͼ������̺������̸�,���������̸����� 
;;; ��ü���� AutoCAD���� �ε��Ͽ��� �Ѵ�.
;;; 
;;;

;Plot Device ����
(setq prt_name "SINDOH N600 Series PCL")			;; ������ �̸� ����
;(setq prt_name "\\\\YYB-01\\RICOH Aficio MP 1812L")		;; �߱��� ������
(setq ctb_file "monochrome.ctb")				;; �� ����
;(setq paper_size_A1 "A1")					;; A1 ���� ����
;(setq paper_size_A2 "A2")					;; A2 ���� ����
(setq paper_size_A3 "A3")					;; A3 ���� ����
(setq paper_size_A4 "A4")					;; A4 ���� ����

;PDF Device ����: ACAD2012
(setq pdf_prt_name "DWG To PDF.pc3")				;; ������ �̸� ����
(setq pdf_ctb_file "monochrome.ctb")				;; �� ����
;(setq pdf_paper_size_A1 "ISO_expand_A1_(594.00_x_841.00_MM)")	;; A1 ���� ����
;(setq pdf_paper_size_A2 "ISO_expand_A2_(420.00_x_594.00_MM)")	;; A2 ���� ����
(setq pdf_paper_size_A3 "ISO_expand_A3_(297.00_x_420.00_MM)")	;; A3 ���� ����
(setq pdf_paper_size_A4 "ISO_expand_A4_(210.00_x_297.00_MM)")	;; A4 ���� ����

;���ļ��� ����(���ϴ�:"BL", �»��:"TL", ����:"TR", ���ϴ�:"BR") -�빮�ڷ� �ۼ�-
(setq #Sort_Align "BL")

;��¿� Layer�� ����(PLOTBOX)
(setq #PlotClayer "0")			;;�÷Կ� �ڽ� �⺻ ���̾� ���� (Default: "0" , ���� �� ���� �� "0,CL,HL" ����)
(setq #PlotColor '(2 3 4 5))		;;�÷Կ� �ڽ� ���� ���� (Default: nil, �� ����ÿ��� '(1 2 3 4) ����)


;;;
;;; PLOT ������ Ȯ��
;;;
;;; ��� ����ϴ� ȯ������ PLOT������ ��ġ�� ������ ��,
;;; PLOTNAME ������� ���� ���� Ȯ���� �� �ִ�.
;;;

(defun c:PLOTNAME ()
(princ "\n�÷��� �̸�: ") (prin1 (vla-get-ConfigName LayObj))
(princ "\n���� �̸�: ") (prin1 (vla-get-CanonicalMediaName LayObj))
(princ "\n�� �̸�: ") (prin1 (vla-get-StyleSheet LayObj))
(princ "\n")(princ)
)

;;;
;;;
;;; ��� ��ɾ� ����
;;; C:OOO �� ���ϴ� ������� �ٲ۴�.
;;;
;;; -�⺻ ��ɾ�-
;;; PX: �ڽ��� �� ����ܰ��� �����Ͽ� ����Ѵ�.
;;; PA: ��� �� �ڽ��� �� ����ܰ��� �����Ͽ� ����Ѵ�.
;;; PXX: ���� ��ü�� ����Ѵ�.
;;; RV: ���� ��°� �����ϰ� �̸����⸦ �Ѵ�.
;;; PB: PLOT ���� �簢�ڽ��� �����Ѵ�.
;;; PDF: �ڽ��� �� ����ܰ��� PDF���Ϸ� ����Ѵ�.
;;; CT: ��� ������ �ڽ��� �� ����ܰ��� �˻��Ѵ�.
;;; CA: ��� ������ ��� �� �ڽ��� �� ����ܰ��� �˻��Ѵ�.
;;;
;;;

(defun C:PI () (prompt (strcat "PLOTINSERT\n����� ��� ������ ����...")) (#PLOT_EXPRESS "PI_Mode" paper_size_A4))
(defun C:PX () (prompt (strcat "PLOTEXPRESS\n����� ���� ����...")) (#PLOT_EXPRESS "Plot_Mode" paper_size_A4))
(defun C:PA () (prompt (strcat "PLOTALL\n����� ��� ���� ����...")) (#PLOT_EXPRESS "ALLPlot_Mode" paper_size_A4))
(defun C:PXX () (prompt (strcat "PLOTEXPRESSALL\nPLOT���� LAYER ��ü ���...")) (#PLOT_EXPRESS "AP_Mode" paper_size_A4))
(defun C:RV () (prompt (strcat "DREVIEW\n�̸����� �� ���� ����...")) (#PLOT_EXPRESS "RV_Mode" nil))
(defun C:PB () (prompt (strcat "PLOTBOX\nPLOT���� BOX ����...")) (c:PLOTBOX))
(defun C:PDF () (prompt (strcat "PDFOUT\nPDF�� ��������...")) (#PLOT_EXPRESS "PDF_Mode" pdf_paper_size_A4))
(defun C:CT () (prompt (strcat "CHKPLOT\nPLOT�� ������ ��ü Ȯ���ϱ�...")) (#PLOT_EXPRESS "CHK_Mode" nil))
(defun C:CA () (prompt (strcat "CHKPLOTALL\nPLOT�� ������ ��� ��ü Ȯ���ϱ�...")) (#PLOT_EXPRESS "ALLCHK_Mode" nil))

;;;
;;;A3 ���� ��ɾ�
;;;

(defun C:PX3 () (prompt (strcat "PLOTEXPRESS\n����� ���� ����...")) (#PLOT_EXPRESS "Plot_Mode" paper_size_A3))
(defun C:PA3 () (prompt (strcat "PLOTALL\n����� ��� ���� ����...")) (#PLOT_EXPRESS "ALLPlot_Mode" paper_size_A3))
;(defun C:PXX3 () (prompt (strcat "PLOTEXPRESSALL\nPLOT���� LAYER ��ü ���...")) (#PLOT_EXPRESS "AP_Mode" paper_size_A3))
;(defun C:PDF3 () (prompt (strcat "PDFOUT\nPDF�� ��������...")) (#PLOT_EXPRESS "PDF_Mode" pdf_paper_size_A3))


;;;
;;;
;;; ���� Open �� �ڵ����� �÷��� Ȯ��
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
    (prompt "\nLISP: �÷� �������� �ùٸ��� ����. PLOTNAME ������� ���� �������� Ȯ���Ͻʽÿ�.")
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
;;; ���� Open �� �ڵ����� UCS �ʱ�ȭ
;;;
;;;

(if (= (getvar "worlducs") 0) (and (setvar "cmdecho" 0) (vl-cmdf "UCS" "") (setvar "cmdecho" 1) (prompt (strcat "\n **UCS Initialized** "))))

;;;
;;;
;;; ī�޶�� �ʱ�ȭ
;;;
;;;

(while (> (vla-get-count (vla-get-views AcDoc)) 0) (vla-delete (vla-item (vla-get-views AcDoc) 0)))
(or (equal (getvar 'target) '(0 0 0)) (and (setvar "cmdecho" 0) (vl-cmdf "dview" "" "point" '(0 0 0) '(0 0 1) "" "zoom" "extent") (setvar "cmdecho" 1) (prompt (strcat "\n **Camera Initialized** "))))

;;;
;;;
;;; ġ�� ���� ����
;;;
;;;

(or (= (getvar 'DIMASSOC) 1) (setvar 'DIMASSOC 1))

;;;
;;;
;;; �Ҽ��� ����ȯ�� �ʱ�ȭ
;;;
;;;

(or (> (getvar 'luprec) 3) (setvar 'luprec 4))

;;;
;;;
;;;    �÷Թڽ� �����
;;;
;;; CLA�� �ش��ϴ� layer�� 4�� �������� �ۼ��Ѵ�.
;;; �ش� layer�� ���� ��� �ڵ����� �ۼ��Ѵ�.
;;; 4�� �������� ������ �ܰ��� ����� ���Ŀ� �ϰ���¿� Ȱ�밡���ϴ�.
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
(and (setq pt (getpoint "ù ��° ������ ����: "))
     (cadr (setq pt (list pt (getcorner pt "�ٸ� ������ ����: "))))
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
;;;    �ڽ� ����
;;;
;;; �ڽ��� ������ ������ �������� x�� �������� �������Ѵ�.
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
	    40.0;�����ϴ� ���� ���̰� ����
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
;;;   PDF �ѹ���
;;;
;;; PDF������ �ѹ��� �����ϰų� �����Ѵ�.
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
;;;   PDF PLOT������ �����Լ�
;;;
;;; �������� PDF����� �����ϱ� �� PLOTTER �������� �����Ѵ�.
;;;
;;;

(defun #PDF_Plot_Active (Paper / pdf_prt_name pdf_ctb_file pdf_paper_size_A1 pdf_paper_size_A2 pdf_paper_size_A3 pdf_paper_size_A4)
(setq pdf_prt_name "DWG To PDF.pc3")				;; ������ �̸� ����
(setq pdf_ctb_file "monochrome.ctb")				;; �� ����
(setq pdf_paper_size_A1 "ISO_expand_A1_(594.00_x_841.00_MM)")	;; A1 ���� ����
(setq pdf_paper_size_A2 "ISO_expand_A2_(420.00_x_594.00_MM)")	;; A2 ���� ����
(setq pdf_paper_size_A3 "ISO_expand_A3_(297.00_x_420.00_MM)")	;; A3 ���� ����
(setq pdf_paper_size_A4 "ISO_expand_A4_(210.00_x_297.00_MM)")	;; A4 ���� ����

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
;;;   PDF���
;;;
;;; PDF����� �����Ѵ�.
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
;;;   PDF ��������
;;;
;;; �������� PDF����� ������ ������ �����Ѵ�.
;;;
;;;

(defun #PDF_Main (Pa Sc LS / *error* OSM P1 P2 Buffer)
(prompt "PDFPLOT\nPDF�� ����� ������ ����...")
(defun *error* (x) (setvar 'osmode OSM))
(setq OSM (getvar 'osmode))
(setvar 'osmode 191)

(or (setq P2 (getcorner (setq P1 (getpoint "\nù��° ���� ����: ")) "\n�ݴ� ���� ����: ")) (quit))
(if #PDF_Filename ($PDF_NUM_ADD) (setq #PDF_Filename (strcat (getvar "mydocumentsprefix") "\\" (substr (getvar "dwgname") 1 (- (strlen (getvar "dwgname")) 4)) "_001.pdf")))
(if (setq Buffer (getfiled "PDF ���� �ۼ�" #PDF_Filename "pdf" 1))
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
  (prompt (strcat "\n���: " #PDF_Filename " �� ���� ��..."))
  (or (setq P2 (getcorner (setq P1 (getpoint "\nù��° ���� ����: ")) "\n�ݴ� ���� ����: ")) (quit))
  ($PDF_NUM_ADD)
)(princ)
)


;;;
;;;
;;;   �ڽ� ���
;;;
;;; ������ 4�� �������� ������ ����Ѵ�.
;;; ���߼��õ� �����ϴ�.
;;;
;;;

(defun #PLOT_EXPRESS ($Mode $Size / *error* AcDoc AcLay AcPlot paper_size sa ss n MinPt MaxPt LP SF_List CLA COL)
(defun *error* (x) (setvar 'cmdecho 1) (and AcDoc (vla-endundomark AcDoc)) (gc) (princ))
(if (= (getvar "worlducs") 0) (and (setvar "cmdecho" 0) (vl-cmdf "UCS" "") (setvar "cmdecho" 1)))
(setq CLA #PlotClayer);;��ü �ڵ���� �� Plot���� Layer ������
(setq COL #PlotColor);;��ü �ڵ���� �� Plot���� ���� ������
(if (or (= $Mode "Plot_Mode") (= $Mode "CHK_Mode"))
  (setq SF_List
    (list
      (cons -4 "<OR")
	(cons -4 "<AND") (cons 0 "LWPOLYLINE") (cons 40 0) (cons 41 0) (cons 90 4) (cons -4 "AND>") ;���� �������� ���ð���
	(cons -4 "<AND") (cons 0 "LWPOLYLINE") (cons 40 0) (cons 41 0) (cons 90 5) (cons -4 "AND>") ;���� �������� ���ð���
      (cons -4 "OR>")
    )
  )
  (if (= $Mode "PI_Mode")
    (setq SF_List (list (cons 0 "INSERT")));������� ����
    (setq SF_List
      (list
	(cons -4 "<OR")
	  (cons 0 "INSERT") ;BLOCK,BOX���� ����
	  (cons -4 "<AND") (cons 0 "LWPOLYLINE") (cons 40 0) (cons 41 0) (cons 90 4) (cons -4 "AND>") ;���� �������� ���ð���
	  (cons -4 "<AND") (cons 0 "LWPOLYLINE") (cons 40 0) (cons 41 0) (cons 90 5) (cons -4 "AND>") ;���� �������� ���ð���
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
      (if (setq Buffer (getfiled "PDF ���� �ۼ�" #PDF_Filename "pdf" 1))
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
      (if (/= (getkword (strcat "\n�÷� �ڽ��� �ۼ��� ������ ��ü ����Ͻðڽ��ϱ�? (��� ���̾�: \"" CLA "\"/ ����: \""
				  (if (and COL (listp COL))
				    (setq Buffer (substr (setq Buffer (apply 'strcat (mapcar '(lambda (x) (strcat (rtos x) ",")) COL))) 1 (1- (strlen Buffer))))
				    (strcat "������")
				  )
				"\") [��(Y)/�ƴϿ�(N)] <Y>: "
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
	  (prompt (strcat "\n���̾� \"" CLA "\"/ ����: \"" (if (and COL (listp COL)) (strcat Buffer) (strcat "������"))"\" �� �ۼ��� �÷� �ڽ��� ����..."))
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
      (prompt (strcat "\n" (rtos n 2 0) "�� ����� �����մϴ�."))
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
	  (progn (vla-PlotToFile AcPlot #PDF_Filename) ($PDF_NUM_ADD) (PTE:highlight (ssget "P") 2)) ;;��°�ü ���� �ɼ� ����
	  (progn (vla-PlotToDevice AcPlot) (PTE:highlight (ssget "P") 2)) ;;��°�ü ���� �ɼ�
	)
      )
    )
    (sssetfirst nil ss) (ssget)
    (setvar "cmdecho" 1)
    (if (/= $Mode "RV_Mode")
      (prompt 
	(strcat "\n" (getvar "dwgprefix")(getvar "dwgname")
	  (if (= $Mode "PDF_Mode") "\n" "\n\n��µ� ��ü�� ǥ���Ϸ��� Regen������� �����...\n")
	  (rtos n 2 0) " ���� ��µǾ����ϴ�."
	)
      )
      (prompt (strcat "\n" (rtos n 2 0) "���� �̸����� �Ϸ��Ͽ����ϴ�."))
    )
    (if (and (/= $Mode "RV_Mode") (> n 1))
      (alert 
	(strcat "\n\t" (getvar "dwgname") "\n\t" (rtos n 2 0) " ���� ��µǾ����ϴ�."
	  (if (= $Mode "PDF_Mode") "" "\n\n\t��µ� ��ü�� ǥ���Ϸ��� Regen������� ��ü ������� �ʿ��մϴ�.")
	)
      )
    )(vlr-beep-reaction) ;;��¿Ϸ� ��ȣ��
  )
)
(if (= $Mode "PDF_Mode") ($PDF_NUM_MINUS))
(vla-endundomark AcDoc)
(gc)
(princ)
)(gc)


;PDF��� ��ɾ� - �������� ���ÿ����� PDF�� ���
;(defun c:SA4PDF nil (#PDF_Main "A4" 0.98 0))	;A4/1:0.98/���ι��� PDF ���
;(defun c:SA3PDF nil (#PDF_Main "A3" 0.98 0))	;A3/1:0.98/���ι��� PDF ���
;(defun c:A4PDF nil (#PDF_Main "A4" 1 1))	;A4/1:1/���ι��� PDF ���
;(defun c:A3PDF nil (#PDF_Main "A3" 1 1))	;A3/1:1/���ι��� PDF ���
(defun c:PDF4 nil (#PDF_Main "A4" "Fit" nil))	;A4�԰� �ڵ� ���μ���/�������� PDF���
;(defun c:PDF3 nil (#PDF_Main "A3" "Fit" nil))	;A3�԰� �ڵ� ���μ���/�������� PDF���


(defun C:PLOTEXPRESS () (prompt (strcat "PLOTEXPRESS\n����� ���� ����...")) (#PLOT_EXPRESS "Plot_Mode" nil))
(defun C:PLOTALL () (prompt (strcat "PLOTALL\n����� ��� ���� ����...")) (#PLOT_EXPRESS "ALLPlot_Mode" nil))
(defun C:PLOTEXPRESSALL () (prompt (strcat "PLOTEXPRESSALL\nPLOT���� LAYER ��ü ���...")) (#PLOT_EXPRESS "AP_Mode" nil))
(defun C:DREVIEW () (prompt (strcat "DREVIEW\n�̸����� �� ���� ����...")) (#PLOT_EXPRESS "RV_Mode" nil))
(defun C:PDFOUT () (prompt (strcat "PDFOUT\nPDF�� ��������...")) (#PLOT_EXPRESS "PDF_Mode" nil))
(defun C:CHKPLOT () (prompt (strcat "CHKPLOT\nPLOT��ü Ȯ���ϱ�...")) (#PLOT_EXPRESS "CHK_Mode" nil))
(defun C:CHKPLOTALL () (prompt (strcat "CHKPLOTALL\nPLOT�� ������ ��� ��ü Ȯ���ϱ�...")) (#PLOT_EXPRESS "ALLCHK_Mode" nil))