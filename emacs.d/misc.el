;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;shell-mode
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;scroll
(setq scroll-step 2)

;;line
(setq require-final-newline nil)

;;script chmod +x
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script\-p)

;;(display-time)
(setq visible-bell nil)
(line-number-mode t)

;;just in time
(setq font-lock-support-mode 'jit-lock-mode)

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;; kill-summary
(autoload 'kill-summary "kill-summary" nil t)
(global-set-key "\M-y" 'kill-summary)


;; mcomplete
(require 'mcomplete) (turn-on-mcomplete-mode)

;; session.el
(when (require 'session nil t)
  (add-hook 'after-init-hook 'session-initialize))
(when (require 'session nil t)
  (setq session-initialize '(de-saveplace session keys menus)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 100 t)
                                  (file-name-history 100)))
  (add-hook 'after-init-hook 'session-initialize))

;;minibuf-isearch
;(require 'minibuf-isearch)

; word-count
(autoload 'word-count-mode "word-count"
          "Minor mode to count words." t nil)
;(global-set-key "\M-+" 'word-count-mode)

;; (require 'wb-line-number)
;; ; 起動時にONにする
;; ; (wb-line-number-toggle)
;; (setq truncate-partial-width-windows nil) ; use continuous line

(require 'linum)
(setq linum-format "%5d|") ; 5 桁分の領域を確保して行番号のあとにスペースを入れる
; (global-linum-mode nil)      ; デフォルトで linum-mode を有効にする

;;;; OK ;;;;;

;; delete ~
(setq make-backup-files nil)

;; hide menu bar
(menu-bar-mode -1)

