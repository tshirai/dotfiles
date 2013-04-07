;; setup el-get
;; first boot emacs => install el-get in ~/.emacs.d/el-get, then, misc.el will fail.
;; second boot      => el-get-install defined in ~/dotfiles/emacs.d/el-get.el, the, misc.el will fail
;; third boot       => will success.

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
 (run-emacs
  ;; el-get
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/el-get.el"))
  ;; development environment
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/dev.el"))
  ;; misc
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/misc.el"))
  ;; color
  (load_file (substitute-in-file-name "~/dotfiles/emacs.d/color.el"))
  )
 )

;; iswitchb
(load_file (substitute-in-file-name "~/dotfiles/emacs.d/iswitchb_conf.el"))




