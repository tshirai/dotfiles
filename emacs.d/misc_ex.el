;; without cask

;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;; anything
;;  (require 'anything-startup)
;; (global-set-key (kbd "C-x b") 'anything-for-files)
;; (global-set-key (kbd "M-y") 'anything-show-kill-ring)
;; (global-set-key (kbd "C-x M-x") 'anything-M-x)
;; (setq anything-samewindow nil)
;; (push '("*anything*" :height 40) popwin:special-display-config)

;; helm
(require 'helm-config)
; (global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)

(define-key helm-map            (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-read-file-map  (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

;; (setq helm-display-function
;;       (lambda (buf)
;;         (split-window-horizontally)
;;         (other-window 1)
;;         (switch-to-buffer buf)))

; (require 'helm-descbinds)
; (helm-descbinds-mode)
; (require 'helm-ls-git)
; (require 'helm-ag)

;; recentf
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-max-saved-items 100)
(require 'recentf-ext)

;; (global-set-key (kbd "C-x M-x") 'anything-M-x)
