;; see https://github.com/cask/cask/issues/463
(setq warning-suppress-log-types '((package reinitialization)))

(defun push-path(x)
  (setq load-path (cons x load-path)))
(defun load_file(x)
  (load x))

;; environment
(load_file (substitute-in-file-name "~/dotfiles/emacs.d/environment.el"))

;; keybind
(load_file (substitute-in-file-name "~/dotfiles/emacs.d/keybind.el"))

;; japanese
(cond
 (run-meadow
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/japanese_meadow.el"))
  )
 (run-cygwin
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/japanese_cygwin.el"))
  )
 (run-emacs
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/japanese.el"))
  )
 )

;; editor / dev
(cond
 (run-meadow
  )
 (run-cygwin
  ;; misc
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/misc.el"))
  )
 (run-emacs
  ;; ;; el-get
  ;; (load_file (substitute-in-file-name "~/dotfiles/emacs.d/el-get.el"))

  ;; cask
  (require 'cask "~/.cask/cask.el")
  (cask-initialize)

  ;; misc
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/misc.el"))
  ;; misc ex
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/misc_ex.el"))
  ;; development environment
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/dev.el"))
  ;; color
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/color.el"))
  )
 )

;; iswitchb
; (load_file (substitute-in-file-name "~/dotfiles/emacs.d/iswitchb_conf.el"))
