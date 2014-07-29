;; development environment

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; quickrun
(require 'quickrun)
(push '("*quickrun*") popwin:special-display-config)

;; インデントをスペースで
(setq-default indent-tabs-mode nil)

; 空白文字の表示
;; http://piyolian.blogspot.jp/2011/12/emacs-whitespace-like-jaspace.html
(when (and (>= emacs-major-version 23)
           (require 'whitespace nil t))
  (setq whitespace-style
        '(face
          tabs spaces newline trailing space-before-tab space-after-tab
          space-mark tab-mark))
  (let ((dark (eq 'dark (frame-parameter nil 'background-mode))))
    (set-face-attribute 'whitespace-space nil
                        :foreground (if dark "pink4" "azure3")
                        :background 'unspecified)
    (set-face-attribute 'whitespace-tab nil
                        :foreground (if dark "gray20" "gray80")
                        :background 'unspecified
                        :strike-through t)
    (set-face-attribute 'whitespace-newline nil
                        :foreground (if dark "darkcyan" "darkseagreen")))
  (setq whitespace-space-regexp "\\(　+\\)")
  (setq whitespace-display-mappings
        '((space-mark   ?\xA0  [?\xA4]  [?_]) ; hard space - currency
          (space-mark   ?\x8A0 [?\x8A4] [?_]) ; hard space - currency
          (space-mark   ?\x920 [?\x924] [?_]) ; hard space - currency
          (space-mark   ?\xE20 [?\xE24] [?_]) ; hard space - currency
          (space-mark   ?\xF20 [?\xF24] [?_]) ; hard space - currency
          (space-mark   ?　    [?□]    [?＿]) ; full-width space - square
          (newline-mark ?\n    [?\xAB ?\n])   ; eol - right quote mark
          ))
  (setq whitespace-global-modes '(not dired-mode tar-mode))
  (global-whitespace-mode 1))

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; git-commit-mode
(when (require 'git-commit nil t)
  (set-face-foreground 'git-commit-summary-face nil)
  (set-face-underline  'git-commit-summary-face t)
  (set-face-foreground 'git-commit-nonempty-second-line-face nil)
  (set-face-bold-p     'git-commit-nonempty-second-line-face nil))

;modeline describe function name
(which-function-mode 1)

(setq tab-width 2)
(setq auto-mode-alist
      (append '(("\\.C$" . c++-mode)
                ("\\.cc$" . c++-mode)
                ("\\.cpp$" . c++-mode)
                ("\\.hpp$" . c++-mode)
                ("\\.c$" . c++-mode)
                ("\\.h$" . c++-mode)
                ("\\.cs$" . c++-mode)
;;              ("\\.java$" . java-mode)
                ) auto-mode-alist))

(add-hook ' c-mode-common-hook
            '(lambda()
               (font-lock-mode 1)))
(add-hook 'java-mode-hook
          '(lambda ()
             (setq tab-width 2)
             ;(set-tab-columns 2 (selected-buffer))
             (setq c-basic-offset 2 indent-tabs-mode nil)
             (font-lock-mode 1)
             ))

;;JavaScript
; (add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
; (autoload 'javascript-mode "javascript" nil t)
; (setq js-indent-level 2)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(autoload 'js2-mode "js2-mode" nil t)
; (setq-default c-basic-offset 2)
(setq js2-basic-offset 2)

;;CSS
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
     (cons '("\\.css\\'" . css-mode) auto-mode-alist))

(setq cssm-indent-level 2)
(setq cssm-indent-function #'cssm-c-style-indenter)


;;python
(add-hook 'python-mode-hook
          '(lambda ()
             (font-lock-mode 1)))
(autoload 'python-mode "python-mode"
  "Major mode for editing Python programs" t)
(setq auto-mode-alist
      (cons (cons "\\.py$" 'python-mode) auto-mode-alist))

;;ruby
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq auto-mode-alist
      (append '(("\\.rake$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)))

;; for Rails
(defun try-complete-abbrev (old)
 (if (expand-abbrev) t nil))

(setq hippie-expand-try-functions-list
     '(try-complete-abbrev
       try-complete-file-name
       try-expand-dabbrev))

;(add-hook 'ruby-mode-hook #'(lambda () (ruby-electric-mode nil)))
;(require 'rails)

;; for using Mongrel instead of WEBrik
(setq rails-use-mongrel t)


;; html
;(load "html-helper-mode")
;(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
;(setq auto-mode-alist
;      (append (list (cons "\\.html\\'" 'html-helper-mode))
;              auto-mode-alist))
;(setq html-helper-item-continue-indent 2)


;; colorize last spaces of each line.
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

(unify-8859-on-decoding-mode)

;; (setq magic-mode-alist
;;       (cons '("<\\?xml " . nxml-mode)
;;             magic-mode-alist))

(add-hook 'nxml-mode-hook
          (lambda ()
            (setq nxml-slash-auto-complete-flag t)
            (setq nxml-child-indent 2)
            (setq tab-width 2)
            (setq nxml-section-element-name-regexp "article\\|\\(sub\\)*section\\|chapter\\|div\\|appendix\\|part\\|preface\\|reference\\|simplesect\\|bibliography\\|bibliodiv\\|glossary\\|glossdiv\\|sect[1-5]\\|articleinfo")
            ))

;; 色設定
(custom-set-faces
  '(nxml-comment-delimiter-face
    ((t (:foreground "#66e6e6"))))         ; 
  '(nxml-comment-content-face
    ((t (:foreground "Blue"))))         ; コメント
  '(nxml-delimited-data-face
    ((t (:foreground "LightSalmon"))))     ; 属性値やDTD引数値など
  '(nxml-delimiter-face
    ((t (:foreground "LightSalmon"))))     ; <> <? ?> ""
  '(nxml-element-local-name-face
    ((t (:foreground "PaleGreen"))))       ; 要素名
  '(nxml-element-colon-face
    ((t (:foreground "LightSteelBlue"))))  ; :(xsl:paramなど)
  '(nxml-name-face
    ((t (:foreground "LightGoldenrod"))))  ; 属性名など
  '(nxml-ref-face
    ((t (:foreground "LightSkyBlue"))))    ; &lt;など
  '(nxml-tag-slash-face
    ((t (:foreground "LightSkyBlue"))))    ; /(終了タグ)
)





;; psgml
(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)

(setq auto-mode-alist
     (append (list (cons "\\.html\\'" 'xml-mode))
              auto-mode-alist))

(setq auto-mode-alist
     (append (list (cons "\\.shtml\\'" 'xml-mode))
              auto-mode-alist))

;; (setq auto-mode-alist
;;       (append (list (cons "\\.xml\\'" 'xml-mode))
;;               auto-mode-alist))

(setq sgml-catalog-files '("CATALOG" "/ne-hohome/shirai/emacs/soft/psgml/catalog"))
(setq sgml-catalog-files '("ECAT" "/ne-hohome/shirai/emacs/soft/psgml/ecat"))

(add-hook 'xml-mode-hook
  (function (lambda()
    (make-face 'sgml-comment-face)
    (make-face 'sgml-start-tag-face)
    (make-face 'sgml-end-tag-face)
    (make-face 'sgml-doctype-face)

    (set-face-foreground 'sgml-comment-face "blue4")
    (set-face-foreground 'sgml-start-tag-face "steelblue")
    (set-face-foreground 'sgml-end-tag-face "steelblue")
    (set-face-foreground 'sgml-doctype-face "blue4")

    (setq sgml-set-face t)
    (setq sgml-markup-faces
      '((comment   . sgml-comment-face)
        (start-tag . sgml-start-tag-face)
        (end-tag   . sgml-end-tag-face)
        (doctype   . sgml-doctype-face)))
;    (setq sgml-omittag nil         ;; タグの省略 無効 nil
;          sgml-shorttag nil        ;; タグの短縮 無効 nil
;          sgml-indent-step nil
;          sgml-indent-data nil) ;; インデント 無効 nil
    (setq sgml-indent-step t
          sgml-indent-data t ;; インデント 無効 nil
          sgml-indent-level 4)
    )))

;(setq sgml-general-insert-case 'lower)

(setq sgml-custom-dtd
 '(("HTML 4.01 Strict"
    "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"
\"http://www.w3.org/TR/html4/strict.dtd\">")
   ("HTML 4.01 Translational"
    "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Translational//EN\"
\"http://www.w3.org/TR/html4/loose.dtd\">")
   ("HTML 4.01 Frameset"
    "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\"
\"http://www.w3.org/TR/html4/frameset.dtd\">")
   ("XHTML 1.0 Strict"
    "<?xml version=\"1.0\" encoding=\"Shift_JIS\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n")
   ("XHTML 1.0 Translational"
    "<?xml version=\"1.0\" encoding=\"Shift_JIS\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Translational//EN\"
\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n")
   ("XHTML 1.0 Frameset"
    "<?xml version=\"1.0\" encoding=\"Shift_JIS\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Frameset//EN\"
\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd\">\n")
   ("XHTML 1.1"
    "<?xml version=\"1.0\" encoding=\"Shift_JIS\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\"
\"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">\n")
))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNU GLOBAL(gtags)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))



;; httpd.conf用
(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\.htaccess\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\.conf\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\.conf\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\.conf\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\(available\|enabled\)/" . apache-mode))

;; yaml
;;; yaml-mode の設定
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


