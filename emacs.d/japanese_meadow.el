; IME Setting
; Language Environment: Japanese
(set-language-environment "Japanese")
; Windows IME
(mw32-ime-initialize)
(setq default-input-method "MW32-IME")
;IME ON/OFF mode-line
(setq mw32-ime-show-mode-line t)

;IME mode-line indicator
;; OFF : [--]
;; ON  : [‚ ]
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list '("[--]" "[‚ ]" "[--]"))
