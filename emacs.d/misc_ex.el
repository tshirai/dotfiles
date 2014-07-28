;; without cask

;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;; anything
(require 'anything-startup)
(global-set-key (kbd "C-x b") 'anything-for-files)
(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(global-set-key (kbd "C-x M-x") 'anything-M-x)
(setq anything-samewindow nil)
(push '("*anything*" :height 40) popwin:special-display-config)

;; recentf
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-max-saved-items 100)
(require 'recentf-ext)

