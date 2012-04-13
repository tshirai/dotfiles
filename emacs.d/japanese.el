;;to use Japanese
;(load "binzBWHiMxjsX.bin")
;(require 'un-define)
;(require 'jisx0213)
(set-language-environment "Japanese")
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8)

(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

