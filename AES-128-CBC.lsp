(defun #AES-128-CBC
  (mod dat key iv / 
    $S-Box #xor #Hex2Dec #Dec2Hex #SubByte #bit_Separator #KeySchedule #StringCheck
    #MatriXor #MixColumns #EncriptCBCBlock #EncriptCBC #DecriptCBCBlock #DecriptCBC
    $key $iv $dat $scKey $pad output pad
  )
;;Sub-Byte Convert Box
(setq $S-Box
  (list
    099 124 119 123 242 107 111 197 048 001 103 043 254 215 171 118
    202 130 201 125 250 089 071 240 173 212 162 175 156 164 114 192
    183 253 147 038 054 063 247 204 052 165 229 241 113 216 049 021
    004 199 035 195 024 150 005 154 007 018 128 226 235 039 178 117
    009 131 044 026 027 110 090 160 082 059 214 179 041 227 047 132
    083 209 000 237 032 252 177 091 106 203 190 057 074 076 088 207
    208 239 170 251 067 077 051 133 069 249 002 127 080 060 159 168
    081 163 064 143 146 157 056 245 188 182 218 033 016 255 243 210
    205 012 019 236 095 151 068 023 196 167 126 061 100 093 025 115
    096 129 079 220 034 042 144 136 070 238 184 020 222 094 011 219
    224 050 058 010 073 006 036 092 194 211 172 098 145 149 228 121
    231 200 055 109 141 213 078 169 108 086 244 234 101 122 174 008
    186 120 037 046 028 166 180 198 232 221 116 031 075 189 139 138
    112 062 181 102 072 003 246 014 097 053 087 185 134 193 029 158
    225 248 152 017 105 217 142 148 155 030 135 233 206 085 040 223
    140 161 137 013 191 230 066 104 065 153 045 015 176 084 187 022
  )
)
;;XOR
(defun #xor (a b) (boole 6 a b))
;;Hex String to Decimal List
(defun #Hex2Dec (hex / lst dec buf tar conv)
(setq lst (vl-string->list hex))
(while (setq dec (car lst))
  (cond ((> 58 dec 47) (setq tar -48)) ((> 71 dec 64) (setq tar -55)) ((> 103 dec 96) (setq tar -87)))
  (cond
    ((= dec 32) nil)
    (buf (setq conv (append conv (list (+ buf dec tar))) buf nil))
    (T (setq buf (* (+ dec tar) 16)))
  )
  (setq lst (cdr lst))
)conv
)
;;Decimal List to Hex String
(defun #Dec2Hex (dec)
(mapcar
  (function
    (lambda (num)
      (apply 'strcat
	(mapcar
	  (function (lambda (a) (if (> (strlen a) 1) (chr (+ (ascii (substr a 2)) 49)) a)))
	  (list (rtos (fix (/ num 16.0)) 2 0) (rtos (rem num 16.0) 2 0))
	)
      )
    )
  )dec
)
)
;;SubByte Calculate
(defun #SubByte (encp bytes)
(mapcar
  (function
    (lambda (bit / x)
      (if encp (nth bit $S-Box) (vl-position bit $S-Box))
    )
  )bytes
)
)
;;List Separate
(defun #bit_Separator (bit lst / spr lsa lsb n)
(setq spr (1- (fix (/ bit 8))) n 0)
(repeat (length lst)
  (if (= (length lsa) spr)
    (setq lsb (append lsb (list (append lsa (list (nth n lst))))) lsa nil)
    (setq lsa (append lsa (list (nth n lst))))
  )
  (setq n (1+ n))
)
(if lsa (append lsb (list lsa)) lsb)
)
;;Key Scheduling for AES128
(defun #KeySchedule (key / RCon KeyGen RKey)
(setq RCon (list 1 2 4 8 16 32 64 128 27 54))
(setq KeyGen (list (#bit_Separator 32 key)))
(repeat 10
  (setq RKey (last (last KeyGen))
	RKey (append (cdr RKey) (list (car RKey)))
	RKey (mapcar '#xor (#SubByte t RKey) (list (car RCon) 0 0 0))
	RCon (cdr RCon)
  )
  (setq KeyGen
    (append KeyGen
      (list
        (mapcar
	  (function (lambda (v) (setq RKey (mapcar '#xor v RKey))))
	  (last KeyGen)
	)
      )
    )
  )
)KeyGen
)
;;RandomNumberGenerator
(defun #RNG nil
  (fix (rem (atof (vl-list->string (reverse (vl-string->list (rtos (getvar "cputicks") 2 0))))) 256))
)
;;String or Hex Checker
(defun #StringCheck (byte pad str / hexp str_lst)
(setq hexp
  (apply 'and
    (mapcar
      (function (lambda (x) (or (= x 32) (> 58 x 47) (> 71 x 64) (> 103 x 96))))
      (vl-string->list str)
    )
  )
)
(setq str_lst (if hexp (#Hex2Dec str) (vl-string->list str)))
(cond
  ((not byte) t)
  ((= pad "ISO-10126")
    (repeat (1- (- byte (rem (length str_lst) byte)))
      (setq str_lst (append str_lst (list (#RNG))))
    )
    (setq str_lst (append str_lst (list (- byte (rem (length str_lst) byte)))))
  )
  ((= pad "Zero")
    (repeat (- byte (rem (length str_lst) byte))
      (setq str_lst (append str_lst (list 0)))
    )
  )
  ((= pad "PKCS#5")
    (repeat (- byte (rem (length str_lst) byte))
      (setq str_lst (append str_lst (list (- byte (rem (length str_lst) byte)))))
    )
  )
  ((= pad "None")
    (or (zerop (rem (length str_lst) byte))
      (repeat (- byte (rem (length str_lst) byte)) (setq str_lst (append str_lst (list 0))))
    )
  )
)str_lst
)
;;Matrix Calculator(xor)
(defun #MatriXor (b mt)
  (mapcar
    (function
      (lambda (m)
        (apply 'boole
	  (append
	    (list 6)
	    (mapcar
	      (function
		(lambda (x y / a)
		  (cond
		    ((= x 3) (boole 6 (if (zerop (logand y 128)) (* y 2) (boole 6 (* y 2) 283)) y))
		    ((= x 2) (if (zerop (logand y 128)) (* y 2) (boole 6 (* y 2) 283)))
		    ((= x 1) y)
		    ((= x 9)
		      (setq a y)
		      (repeat 3 (setq a (if (zerop (logand a 128)) (* a 2) (boole 6 (* a 2) 283))))
		      (boole 6 a y)
		    )
		    ((= x 11)
		      (setq a y)
		      (repeat 2 (setq a (if (zerop (logand a 128)) (* a 2) (boole 6 (* a 2) 283))))
		      (setq a (boole 6 a y))
		      (setq a (if (zerop (logand a 128)) (* a 2) (boole 6 (* a 2) 283)))
		      (boole 6 a y)
		    )
		    ((= x 13)
		      (setq a (boole 6 (if (zerop (logand y 128)) (* y 2) (boole 6 (* y 2) 283)) y))
		      (repeat 2 (setq a (if (zerop (logand a 128)) (* a 2) (boole 6 (* a 2) 283))))
		      (boole 6 a y)
		    )
		    ((= x 14)
		      (setq a (boole 6 (if (zerop (logand y 128)) (* y 2) (boole 6 (* y 2) 283)) y))
		      (setq a (boole 6 (if (zerop (logand a 128)) (* a 2) (boole 6 (* a 2) 283)) y))
		      (if (zerop (logand a 128)) (* a 2) (boole 6 (* a 2) 283))
		    )
		  )
		)
	      ) m b
	    )
	  )
	)
      )
    )mt
  )
)
;;MixColumns Calculator
(defun #MixColumns (cdat)
(mapcar
  (function (lambda (cd) (#MatriXor cd (list (list 2 3 1 1) (list 1 2 3 1) (list 1 1 2 3) (list 3 1 1 2)))))
  cdat
)
)
;;Inverse MixColumns Calculator
(defun #invMixColumns (cdat)
(mapcar
  (function (lambda (cd) (#MatriXor cd (list (list 14 11 13 9) (list 9 14 11 13) (list 13 9 14 11) (list 11 13 9 14)))))
  cdat
)
)
;;Encript CBC-Type Block
(defun #EncriptCBCBlock ($dat $iv $scKey / cdat RKey)
(setq cdat
  (mapcar
    (function
      (lambda (d i k)
        (mapcar
	  (function
	    (lambda (dat iv key)
	      (boole 6 dat iv key)
	    )
	  )d i k
	)
      )
    )
    (#bit_Separator 32 $dat) (#bit_Separator 32 $iv) (car $scKey)
  )
)
(setq RKey (cdr $scKey))
(repeat (1- (length RKey))
  (setq cdat (mapcar (function (lambda (cd) (#SubByte t cd))) cdat))
  (setq cdat
    (list
      (list (nth 0 (nth 0 cdat)) (nth 1 (nth 1 cdat)) (nth 2 (nth 2 cdat)) (nth 3 (nth 3 cdat)))
      (list (nth 0 (nth 1 cdat)) (nth 1 (nth 2 cdat)) (nth 2 (nth 3 cdat)) (nth 3 (nth 0 cdat)))
      (list (nth 0 (nth 2 cdat)) (nth 1 (nth 3 cdat)) (nth 2 (nth 0 cdat)) (nth 3 (nth 1 cdat)))
      (list (nth 0 (nth 3 cdat)) (nth 1 (nth 0 cdat)) (nth 2 (nth 1 cdat)) (nth 3 (nth 2 cdat)))
    )
  )
  (setq cdat (#MixColumns cdat))
  (setq cdat (mapcar (function (lambda (d k) (mapcar '#xor d k))) cdat (car RKey)))
  (setq RKey (cdr RKey))
)
(setq cdat (mapcar (function (lambda (cd) (#SubByte t cd))) cdat))
(setq cdat
  (list
    (list (nth 0 (nth 0 cdat)) (nth 1 (nth 1 cdat)) (nth 2 (nth 2 cdat)) (nth 3 (nth 3 cdat)))
    (list (nth 0 (nth 1 cdat)) (nth 1 (nth 2 cdat)) (nth 2 (nth 3 cdat)) (nth 3 (nth 0 cdat)))
    (list (nth 0 (nth 2 cdat)) (nth 1 (nth 3 cdat)) (nth 2 (nth 0 cdat)) (nth 3 (nth 1 cdat)))
    (list (nth 0 (nth 3 cdat)) (nth 1 (nth 0 cdat)) (nth 2 (nth 1 cdat)) (nth 3 (nth 2 cdat)))
  )
)
(setq cdat (mapcar (function (lambda (d k) (mapcar '#xor d k))) cdat (car RKey)))
)
;;Encript AES-128-CBC
(defun #EncriptCBC ($dat $iv $scKey / iv)
(setq iv $iv)
(mapcar
  (function
    (lambda (dat)
      (setq iv (#EncriptCBCBlock dat iv $scKey))
    )
  )
  (#bit_Separator 128 $dat)
)
)
;;Decript CBC-Type Block
(defun #DecriptCBCBlock ($dat $iv $scKey / cdat RKey)
(setq cdat (mapcar (function (lambda (d k) (mapcar '#xor d k))) (#bit_Separator 32 $dat) (car $scKey)))
(setq RKey (cdr $scKey))
(repeat (1- (length RKey))
  (setq cdat
    (list
      (list (nth 0 (nth 0 cdat)) (nth 1 (nth 3 cdat)) (nth 2 (nth 2 cdat)) (nth 3 (nth 1 cdat)))
      (list (nth 0 (nth 1 cdat)) (nth 1 (nth 0 cdat)) (nth 2 (nth 3 cdat)) (nth 3 (nth 2 cdat)))
      (list (nth 0 (nth 2 cdat)) (nth 1 (nth 1 cdat)) (nth 2 (nth 0 cdat)) (nth 3 (nth 3 cdat)))
      (list (nth 0 (nth 3 cdat)) (nth 1 (nth 2 cdat)) (nth 2 (nth 1 cdat)) (nth 3 (nth 0 cdat)))
    )
  )
  (setq cdat (mapcar (function (lambda (cd) (#SubByte nil cd))) cdat))
  (setq cdat (mapcar (function (lambda (d k) (mapcar '#xor d k))) cdat (car RKey)))
  (setq cdat (#invMixColumns cdat))
  (setq RKey (cdr RKey))
)
(setq cdat
  (list
    (list (nth 0 (nth 0 cdat)) (nth 1 (nth 3 cdat)) (nth 2 (nth 2 cdat)) (nth 3 (nth 1 cdat)))
    (list (nth 0 (nth 1 cdat)) (nth 1 (nth 0 cdat)) (nth 2 (nth 3 cdat)) (nth 3 (nth 2 cdat)))
    (list (nth 0 (nth 2 cdat)) (nth 1 (nth 1 cdat)) (nth 2 (nth 0 cdat)) (nth 3 (nth 3 cdat)))
    (list (nth 0 (nth 3 cdat)) (nth 1 (nth 2 cdat)) (nth 2 (nth 1 cdat)) (nth 3 (nth 0 cdat)))
  )
)
(setq cdat (mapcar (function (lambda (cd) (#SubByte nil cd))) cdat))
(setq cdat
  (mapcar
    (function
      (lambda (d i k)
        (mapcar
	  (function
	    (lambda (dat iv key)
	      (boole 6 dat iv key)
	    )
	  )d i k
	)
      )
    )
    cdat (#bit_Separator 32 $iv) (car RKey)
  )
)
)
;;Decript AES-128-CBC
(defun #DecriptCBC ($dat $iv $scKey / iv)
(setq iv $iv)
(mapcar
  (function
    (lambda (dat / encdat)
      (setq encdat (#DecriptCBCBlock dat iv $scKey))
      (setq iv dat)
      encdat
    )
  )
  (#bit_Separator 128 $dat)
)
)
(setq $pad "ISO-10126")
(setq $key (#StringCheck 16 "None" key))
(setq $iv (#StringCheck 16 "None" iv))
(setq $dat (if mod (#StringCheck 16 "None" dat) (#StringCheck 16 $pad dat)))
(setq $scKey (#KeySchedule $key))
(cond
  (mod (setq output (#DecriptCBC $dat $iv (reverse $scKey))))
  (T (setq output (#EncriptCBC $dat $iv $scKey)))
)
(if mod
  (progn
    (setq pad (reverse (apply 'append (last output))))
    (if (> 16 (car pad)) (repeat (car pad) (setq pad (cdr pad))))
    (setq output (reverse (cdr (reverse output))))
    (if pad (setq output (append output (list (#bit_Separator 32 (reverse pad))))))
  )
)
(prompt
  (strcat
    "\nHexString: "
    (apply 'strcat
      (mapcar
        (function (lambda (x) (strcat (strcase x) " ")))
        (#Dec2Hex (apply 'append (apply 'append output)))
      )
    )
    ;"\nString: "
    ;(vl-list->string (apply 'append (apply 'append output)))
    "\n"
  )
)
output
)