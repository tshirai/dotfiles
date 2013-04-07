; IME Setting
; Language Environment: Japanese
(set-language-environment "Japanese")
; Windows IME
(mw32-ime-initialize)
(setq default-input-method "MW32-IME")
;IME ON/OFF mode-line
(setq mw32-ime-show-mode-line t)

;IME mode-line indicator
;; OFF : [--]
;; ON  : [あ]
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))


; http://www.meadowy.org/meadow/wiki/%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E8%A8%AD%E5%AE%9A
; font
(w32-add-font
     "MS Gothic 16"
     '((spec
	((:char-spec ascii :height any)
	 strict
	 (w32-logfont "MS Gothic" 0 -16 400 0 nil nil nil 0 1 3 0))
	((:char-spec ascii :height any :weight bold)
	 strict
	 (w32-logfont "MS Gothic" 0 -16 700 0 nil nil nil 0 1 3 0)
	 ((spacing . -1)))
	((:char-spec ascii :height any :slant italic)
	 strict
	 (w32-logfont "MS Gothic" 0 -16 400 0   t nil nil 0 1 3 0))
	((:char-spec ascii :height any :weight bold :slant italic)
	 strict
	 (w32-logfont "MS Gothic" 0 -16 700 0   t nil nil 0 1 3 0)
	 ((spacing . -1)))
	((:char-spec japanese-jisx0208 :height any)
	 strict
	 (w32-logfont "MS Gothic" 0 -16 400 0 nil nil nil 128 1 3 0))
	((:char-spec japanese-jisx0208 :height any :weight bold)
	 strict
	 (w32-logfont "MS Gothic" 0 -16 700 0 nil nil nil 128 1 3 0)
	 ((spacing . -1)))
	((:char-spec japanese-jisx0208 :height any :slant italic)
	 strict
	 (w32-logfont "MS Gothic" 0 -16 400 0   t nil nil 128 1 3 0))
	((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
	 strict
	 (w32-logfont "MS Gothic" 0 -16 700 0   t nil nil 128 1 3 0)
	 ((spacing . -1))))))
; 起動時およびnew-frame時のフレーム(ウィンドウ)の設定。
(add-to-list 'default-frame-alist '(font . "MS Gothic 16"))
; 現在のフレームの設定(.emacs中では省略可)
(set-frame-font "MS Gothic 16")
; IMEのフォントを設定。こういう書式でないとだめらしい。
(let ((logfont '(w32-logfont "MS Gothic" 0 0 400 0 nil nil nil 128 1 3 0)))
  (modify-frame-parameters (selected-frame) (list (cons 'ime-font logfont)))
  (add-to-list 'default-frame-alist (cons 'ime-font logfont))
  )
