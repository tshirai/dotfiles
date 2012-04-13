;; setup el-get
;; first boot emacs => install el-get in ~/.emacs.d/el-get, then, misc.el will fail.
;; second boot      => el-get-install defined in ~/dotfiles/emacs.d/el-get.el, the, misc.el will fail
;; third boot       => will success.

(defun push-path(x)
  (setq load-path (cons x load-path)))
(defun load_file(x)
  (load x))

;; keybind
(load_file (substitute-in-file-name "~/dotfiles/emacs.d/keybind.el"))

;; japanese
(load_file (substitute-in-file-name "~/dotfiles/emacs.d/japanese.el"))

;; el-get
(load_file (substitute-in-file-name "~/dotfiles/emacs.d/el-get.el"))

;; development environment
(load_file (substitute-in-file-name "~/dotfiles/emacs.d/dev.el"))

;; misc
(load_file (substitute-in-file-name "~/dotfiles/emacs.d/misc.el"))

;; iswitchb
(load_file (substitute-in-file-name "~/dotfiles/emacs.d/iswitchb_conf.el"))

;; color
(load_file (substitute-in-file-name "~/dotfiles/emacs.d/color.el"))



