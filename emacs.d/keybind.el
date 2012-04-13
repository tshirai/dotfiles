;; key bind
(global-set-key [delete] 'delete-char)
(global-set-key [backspace] 'delete-backward-char)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-h" 'backward-kill-word)

(global-set-key "\C-@" 'set-mark-command)
(global-set-key "\C-xr" 'rename-buffer)

(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-c\C-u" 'uncomment-region)
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\M-c" 'compile)
(global-set-key "\M-ss" 'shell-script-mode)
(global-set-key "\C-e" 'end-of-line)


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
