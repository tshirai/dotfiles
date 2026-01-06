;; =============================================================================
;; Emacs Configuration (Emacs 30.2+, Linux/Unix only)
;; Migrated from Cask to use-package
;; =============================================================================

;; =============================================================================
;; SECTION 1: Early Initialization
;; =============================================================================

;; Increase GC threshold during startup for better performance
(setq gc-cons-threshold (* 100 1024 1024)) ; 100 MB

;; Package system setup
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; use-package is built-in to Emacs 30+, but ensure it's available
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t) ; Auto-install packages

;; =============================================================================
;; SECTION 2: Core Settings
;; =============================================================================

;; UTF-8 encoding
(set-language-environment "Japanese")
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8)

;; Shell mode with password prompt support
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; Shell mode with ANSI color support
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Disable echoback in comint mode
(add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))

;; Scroll settings
(setq scroll-step 2)

;; Line settings
(setq require-final-newline nil)
(line-number-mode t)

;; Auto chmod +x for scripts
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; Bell settings
(setq ring-bell-function 'ignore)

;; Just-in-time font lock
(setq font-lock-support-mode 'jit-lock-mode)

;; Frame title format
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;; Kill ring settings
(setq kill-ring-max 100)

;; Minibuffer history
(savehist-mode 1)
(setq history-length 3000)

;; Line numbering
(require 'linum)
(setq linum-format "%5d|")

;; No backup files (~)
(setq make-backup-files nil)

;; Hide menu bar
(menu-bar-mode -1)

;; ido mode for file completion
(require 'ido)
(ido-mode 'file)
(custom-set-variables '(ido-max-directory-size 'const))
(custom-set-variables '(ido-enter-matching-directory 'first))
(custom-set-variables '(ido-ignore-files (cons '"\\`\\." ido-ignore-files)))
(define-key ido-file-dir-completion-map (kbd "SPC") 'ido-exit-minibuffer)

;; Abbrev mode
(setq abbrev-file-name "~/.abbrev_defs")
(define-key esc-map  " " 'expand-abbrev)
(quietly-read-abbrev-file)
(setq save-abbrevs 'silently)

;; Trailing whitespace visualization
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

;; Enable font-lock mode globally
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; which-function-mode in modeline
(which-function-mode 1)

;; Tab settings
(setq tab-width 2)
(setq-default indent-tabs-mode nil)

;; Unify 8859 on decoding (removed in Emacs 30+)
;; (unify-8859-on-decoding-mode)

;; =============================================================================
;; SECTION 3: Global Keybindings
;; =============================================================================

;; Basic editing keys
(global-set-key [delete] 'delete-char)
(global-set-key [backspace] 'delete-backward-char)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-h" 'backward-kill-word)

;; Buffer and mark commands
(global-set-key "\C-@" 'set-mark-command)
(global-set-key "\C-xr" 'rename-buffer)

;; Navigation and editing
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-c\C-u" 'uncomment-region)
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\M-c" 'compile)
(global-set-key "\M-ss" 'shell-script-mode)
(global-set-key "\C-e" 'end-of-line)

;; isearch improvements
(defun isearch-real-delete-char ()
  (interactive)
  (setq isearch-string
        (if (= (length isearch-string) 1)
            isearch-string
          (substring isearch-string 0 (- (length isearch-string) 1)))
        isearch-message isearch-string
        isearch-yank-flag t)
  (isearch-search-and-update))

(define-key isearch-mode-map "\C-h" 'isearch-real-delete-char)
(define-key isearch-mode-map [backspace] 'isearch-real-delete-char)

;; =============================================================================
;; SECTION 4: Core Tools
;; =============================================================================

;; Helm - Incremental completion and selection framework
(use-package helm
  :ensure t
  :demand t
  :init
  (setq helm-ff-auto-update-initial-value nil)
  :config
  (helm-mode 1)
  :bind (("M-x"     . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x C-r" . helm-recentf)
         ("M-y"     . helm-show-kill-ring)
         ("C-c i"   . helm-imenu)
         ("C-x b"   . helm-buffers-list)
         :map helm-map
         ("C-h" . delete-backward-char)
         :map helm-find-files-map
         ("C-h"  . delete-backward-char)
         ("TAB"  . helm-execute-persistent-action)
         :map helm-read-file-map
         ("TAB" . helm-execute-persistent-action)))

;; Popwin - Popup window manager
(use-package popwin
  :ensure t
  :demand t
  :config
  (setq display-buffer-function 'popwin:display-buffer)
  (push '("*quickrun*") popwin:special-display-config))

;; Recentf - Recent files
(use-package recentf
  :config
  (setq recentf-save-file "~/.emacs.d/.recentf")
  (setq recentf-max-saved-items 100))

(use-package recentf-ext
  :ensure t
  :after recentf)

;; Browse-kill-ring
(use-package browse-kill-ring
  :ensure t
  :bind ("M-y" . browse-kill-ring))

;; Git-gutter - Show git diff in fringe
(use-package git-gutter
  :ensure t
  :demand t
  :config
  (global-git-gutter-mode 1))

;; Powerline - Enhanced modeline
(use-package powerline
  :ensure t
  :demand t
  :config
  (powerline-default-theme))

;; Elscreen - Screen manager
(use-package elscreen
  :ensure t
  :defer t)

;; pbcopy - macOS clipboard support
(use-package pbcopy
  :ensure t
  :if (eq system-type 'darwin)
  :config
  (turn-on-pbcopy))

;; Popup - Visual popup interface
(use-package popup
  :ensure t)

;; Quickrun - Execute scripts quickly
(use-package quickrun
  :ensure t
  :defer t
  :config
  (push '("*quickrun*") popwin:special-display-config))

;; ag - The Silver Searcher
(use-package ag
  :ensure t
  :defer t)

;; =============================================================================
;; SECTION 5: Editing Tools
;; =============================================================================

;; Flycheck - On-the-fly syntax checking
(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode)
  :config
  (setq flycheck-flake8rc ".flake8"))

;; Auto-complete - Automatic completion
(use-package auto-complete
  :ensure t
  :hook (prog-mode . auto-complete-mode))

;; Yasnippet - Template system
(use-package yasnippet
  :ensure t
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

;; Whitespace - Visualize whitespace characters
(use-package whitespace
  :config
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
          '((space-mark   ?\xA0  [?\xA4]  [?_])
            (space-mark   ?\x8A0 [?\x8A4] [?_])
            (space-mark   ?\x920 [?\x924] [?_])
            (space-mark   ?\xE20 [?\xE24] [?_])
            (space-mark   ?\xF20 [?\xF24] [?_])
            (space-mark   ?　    [?■]    [?_])
            (newline-mark ?\n    [?\xAB ?\n])))
    (setq whitespace-global-modes '(not dired-mode tar-mode))
    (global-whitespace-mode 1)))

;; Rainbow-delimiters - Highlight matching parentheses
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; zlc - zsh-like completion (optional, currently disabled)
(use-package zlc
  :ensure t
  :defer t)

;; git-commit-mode face customization
(when (require 'git-commit nil t)
  (set-face-foreground 'git-commit-summary-face nil)
  (set-face-underline  'git-commit-summary-face t)
  (set-face-foreground 'git-commit-nonempty-second-line-face nil)
  (set-face-bold-p     'git-commit-nonempty-second-line-face nil))

;; =============================================================================
;; SECTION 6: Language-Agnostic Programming
;; =============================================================================

;; C/C++ mode configuration
(setq auto-mode-alist
      (append '(("\\.C$" . c++-mode)
                ("\\.cc$" . c++-mode)
                ("\\.cpp$" . c++-mode)
                ("\\.hpp$" . c++-mode)
                ("\\.c$" . c++-mode)
                ("\\.h$" . c++-mode)
                ("\\.cs$" . c++-mode))
              auto-mode-alist))

(add-hook 'c-mode-common-hook
          '(lambda()
             (font-lock-mode 1)))

;; Java mode configuration
(add-hook 'java-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq c-basic-offset 2 indent-tabs-mode nil)
             (font-lock-mode 1)))

;; GNU GLOBAL (gtags)
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\M-l" 'gtags-find-file)
         (local-set-key "\C-t" 'gtags-pop-stack)))

(add-hook 'c++-mode-common-hook
          '(lambda()
             (gtags-mode 1)
             (gtags-make-complete-list)))

;; =============================================================================
;; SECTION 7: Web Development
;; =============================================================================

;; JavaScript - js2-mode
(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :init
  (autoload 'javascript-mode "javascript" nil t)
  (setq js-indent-level 2)
  (setq js2-basic-offset 2))

;; JSON
(use-package json-mode
  :ensure t
  :mode "\\.json\\'"
  :hook (json-mode . flycheck-mode))

(use-package json-reformat
  :ensure t
  :after json-mode)

;; TypeScript
(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'")

;; YAML
(use-package yaml-mode
  :ensure t
  :mode "\\.yml\\'")

;; CSS
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))
(setq cssm-indent-level 2)
(setq cssm-indent-function #'cssm-c-style-indenter)

;; Less CSS
(use-package less-css-mode
  :ensure t
  :mode "\\.less\\'")

;; HTML/XML - nxml-mode
(add-hook 'nxml-mode-hook
          (lambda ()
            (setq nxml-slash-auto-complete-flag t)
            (setq nxml-child-indent 2)
            (setq tab-width 2)
            (setq nxml-section-element-name-regexp
                  "article\\|\\(sub\\)*section\\|chapter\\|div\\|appendix\\|part\\|preface\\|reference\\|simplesect\\|bibliography\\|bibliodiv\\|glossary\\|glossdiv\\|sect[1-5]\\|articleinfo")))

;; nxml face customization
(custom-set-faces
 '(nxml-comment-delimiter-face
   ((t (:foreground "#66e6e6"))))
 '(nxml-comment-content-face
   ((t (:foreground "Blue"))))
 '(nxml-delimited-data-face
   ((t (:foreground "LightSalmon"))))
 '(nxml-delimiter-face
   ((t (:foreground "LightSalmon"))))
 '(nxml-element-local-name-face
   ((t (:foreground "PaleGreen"))))
 '(nxml-element-colon-face
   ((t (:foreground "LightSteelBlue"))))
 '(nxml-name-face
   ((t (:foreground "LightGoldenrod"))))
 '(nxml-ref-face
   ((t (:foreground "LightSkyBlue"))))
 '(nxml-tag-slash-face
   ((t (:foreground "LightSkyBlue")))))

;; psgml - SGML/HTML mode
(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)

(setq auto-mode-alist
      (append (list (cons "\\.html\\'" 'xml-mode)
                    (cons "\\.shtml\\'" 'xml-mode))
              auto-mode-alist))

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
    (setq sgml-indent-step t
          sgml-indent-data t
          sgml-indent-level 4))))

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
\"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">\n")))

;; Apache configuration files
(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\.htaccess\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\.conf\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\.conf\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\.conf\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\(available\|enabled\)/" . apache-mode))

;; =============================================================================
;; SECTION 8: Python Development
;; =============================================================================

(use-package python-mode
  :ensure t
  :mode "\\.py\\'"
  :hook (python-mode . (lambda () (font-lock-mode 1)))
  :init
  (setq pipenv-with-flycheck nil)
  (autoload 'python-mode "python-mode" "Major mode for editing Python programs" t))

(use-package flymake-python-pyflakes
  :ensure t
  :after python-mode)

;; =============================================================================
;; SECTION 9: Ruby Development
;; =============================================================================

(use-package ruby-mode
  :mode (("\\.rb\\'" . ruby-mode)
         ("\\.rake\\'" . ruby-mode)
         ("Rakefile\\'" . ruby-mode)
         ("Gemfile\\'" . ruby-mode))
  :interpreter "ruby"
  :init
  (setq ruby-insert-encoding-magic-comment nil)
  (autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t))

;; inf-ruby - Interactive Ruby REPL
(use-package inf-ruby
  :ensure t
  :after ruby-mode
  :hook ((ruby-mode . inf-ruby-minor-mode)
         (compilation-filter . inf-ruby-auto-enter))
  :init
  (autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t))

;; Flycheck + Rubocop integration
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq flycheck-checker 'ruby-rubocop)
             (flycheck-mode 1)))

;; Rubocop
(use-package rubocop
  :ensure t
  :after ruby-mode)

;; Robe - Code navigation and documentation
(use-package robe
  :ensure t
  :after ruby-mode
  :hook (ruby-mode . robe-mode))

;; Ruby-electric - Automatic closing of blocks
(use-package ruby-electric
  :ensure t
  :after ruby-mode)

;; Ruby-end - Automatic insertion of end
(use-package ruby-end
  :ensure t
  :after ruby-mode)

;; RSpec mode
(use-package rspec-mode
  :ensure t
  :after ruby-mode)

;; For Rails - Hippie expand configuration
(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

(setq hippie-expand-try-functions-list
      '(try-complete-abbrev
        try-complete-file-name
        try-expand-dabbrev))

;; Rails-specific settings
(setq rails-use-mongrel t)

;; =============================================================================
;; SECTION 10: Go Development
;; =============================================================================

(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :init
  ;; Add Go executable paths
  (add-to-list 'exec-path (expand-file-name "~/.goenv/shims"))
  (add-to-list 'exec-path (expand-file-name "~/.goenv/bin"))
  (add-to-list 'exec-path (expand-file-name "~/go/bin"))
  :hook ((go-mode . company-mode)
         (go-mode . flycheck-mode)
         (go-mode . (lambda ()
                      (local-set-key (kbd "M-.") 'godef-jump)
                      (set (make-local-variable 'company-backends) '(company-go))
                      (company-mode)
                      (setq indent-tabs-mode nil)
                      (setq c-basic-offset 2)
                      (setq tab-width 2)))))

(use-package company-go
  :ensure t
  :after go-mode)

(use-package go-eldoc
  :ensure t
  :after go-mode)

;; Company mode for completion
(use-package company
  :ensure t
  :defer t)

;; =============================================================================
;; SECTION 11: Other Languages
;; =============================================================================

;; Terraform
(use-package terraform-mode
  :ensure t
  :mode "\\.tf\\'")

;; AsciiDoc
(use-package adoc-mode
  :ensure t
  :mode "\\.adoc\\'"
  :hook (adoc-mode . buffer-face-mode)
  :init
  (autoload 'adoc-mode "adoc-mode" nil t))

;; Markdown
(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

;; Groovy
(use-package groovy-mode
  :ensure t
  :mode "\\.groovy\\'")

;; Puppet
(use-package puppet-mode
  :ensure t
  :mode "\\.pp\\'")

;; Nginx
(use-package nginx-mode
  :ensure t
  :mode "nginx\\.conf\\'")

;; Haml
(use-package haml-mode
  :ensure t
  :mode "\\.haml\\'")

;; Sass
(use-package sass-mode
  :ensure t
  :mode "\\.sass\\'")

;; Slim
(use-package slim-mode
  :ensure t
  :mode "\\.slim\\'")

;; CoffeeScript
(use-package coffee-mode
  :ensure t
  :mode "\\.coffee\\'")

;; RubyMotion
(use-package motion-mode
  :ensure t
  :mode "\\.rb\\'")

;; RHTML
(use-package rhtml-mode
  :ensure t
  :mode "\\.html\\.erb\\'")

;; =============================================================================
;; SECTION 12: Appearance
;; =============================================================================

;; Color theme
(use-package color-theme-modern
  :ensure t
  :config
  (load-theme 'clarity t))

;; hlinum - Highlight current line number
(use-package hlinum
  :ensure t)

;; Markup faces
(use-package markup-faces
  :ensure t)

;; =============================================================================
;; SECTION 13: Final Initialization
;; =============================================================================

;; Reset GC threshold after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1024 1024)))) ; 2 MB

;; Custom file location
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; =============================================================================
;; End of configuration
;; =============================================================================
