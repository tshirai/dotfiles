;; see http://d.hatena.ne.jp/nishikawasasaki/20120219/1329639731
;; el-get インストール後のロードパスの用意
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; もし el-get がなければインストールを行う
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (end-of-buffer)
       (eval-print-last-sexp)))))
(require 'el-get)

(setq el-get-sources
      '((:name ruby-mode 
               :type elpa
               :load "ruby-mode.el")
        (:name inf-ruby  :type elpa)
        (:name ruby-compilation :type elpa)
        (:name css-mode :type elpa)
        (:name textmate
               :type git
               :url "git://github.com/defunkt/textmate.el"
               :load "textmate.el")
        (:name rvm
               :type git
               :load "rvm.el"
               :compile ("rvm.el")
               :after (lambda() (rvm-use-default)))
        (:name rhtml
               :type git
               :features rhtml-mode)
        (:name yaml-mode 
               :type git
               :url "http://github.com/yoshiki/yaml-mode.git"
               :features yaml-mode)
        (:name zlc
               :type git
               :url "https://github.com/mooz/emacs-zlc.git"
               :load "zlc.el")
        (:name mcomplete
               :type http
               :url "http://homepage1.nifty.com/bmonkey/emacs/elisp/mcomplete.el"
               :description "complete mini buffer."
               :load "mcomplete.el")
        (:name mcomplete-history
               :type http
               :url "http://www.bookshelf.jp/elc/mcomplete-history.el"
               :description ""
               :load "mcomplete-history.el")
        ))

(el-get 'sync)

; (el-get-install ansi-color)
(el-get-install 'apache-mode)
(el-get-install 'auto-complete)
(el-get-install 'auto-indent-mode)
(el-get-install 'color-theme)
(el-get-install 'css-mode)
(el-get-install 'csv-mode)
(el-get-install 'git-commit-mode)
(el-get-install 'haml-mode)
(el-get-install 'hlinum)
(el-get-install 'jaspace)
;; you need makeinfo (texinfo package).
(el-get-install 'magit)
(el-get-install 'mcomplete)
(el-get-install 'nagios-mode)
(el-get-install 'nginx-mode)
(el-get-install 'python-mode)
(el-get-install 'ruby-mode)
; (el-get-install 'rvm)
; (el-get-install 'rhtml)
(el-get-install 'rhtml-mode)
(el-get-install 'rspec-mode)
(el-get-install 'tail)
(el-get-install 'yaml-mode)
(el-get-install 'yasnippet)
;;  doesn't work
; (el-get-install 'zlc)
