;; without cask

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
