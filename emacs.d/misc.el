;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;shell-mode
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

; disable echoback
(add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))

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

;; ;; kill-summary
;; (autoload 'kill-summary "kill-summary" nil t)
;; (global-set-key "\M-y" 'kill-summary)
(global-set-key "\M-y" 'browse-kill-ring)
(setq kill-ring-max 100)


;; mcomplete
; (require 'mcomplete) (turn-on-mcomplete-mode)

;; ミニバッファの履歴を保存する
(savehist-mode 1)

;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

; word-count
(autoload 'word-count-mode "word-count"
          "Minor mode to count words." t nil)
;(global-set-key "\M-+" 'word-count-mode)

;; show line number
(require 'linum)
(setq linum-format "%5d|") ; 5 桁分の領域を確保して行番号のあとにスペースを入れる
; (global-linum-mode nil)      ; デフォルトで linum-mode を有効にする

;; delete ~
(setq make-backup-files nil)

;; hide menu bar
(menu-bar-mode -1)

;; http://d.hatena.ne.jp/mooz/20101003/p1
;; zsh-like minibuffer
;; (require 'zlc)
;; (zlc-mode t)
;; ; (setq zlc-select-completion-immediately t)
;; (let ((map minibuffer-local-map))
;;   ;;; like menu select
;;   (define-key map (kbd "<down>")  'zlc-select-next-vertical)
;;   (define-key map (kbd "<up>")    'zlc-select-previous-vertical)
;;   (define-key map (kbd "<right>") 'zlc-select-next)
;;   (define-key map (kbd "<left>")  'zlc-select-previous)

;;   ;;; reset selection
;;   (define-key map (kbd "C-c") 'zlc-reset)
;;   )

(require 'ido)
(ido-mode 'file)
; (ido-everywhere t)
(custom-set-variables '(ido-max-directory-size 'const))
(custom-set-variables '(ido-enter-matching-directory 'first))
(custom-set-variables '(ido-ignore-files (cons '"\\`\\." ido-ignore-files)))
(define-key ido-file-dir-completion-map (kbd "SPC") 'ido-exit-minibuffer)

;; anything
(require 'anything-startup)
(global-set-key (kbd "C-x b") 'anything-for-files)
(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(global-set-key (kbd "C-x M-x") 'anything-M-x)
;; recentf
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-max-saved-items 100)
(require 'recentf-ext)
