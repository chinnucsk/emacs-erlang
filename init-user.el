;; common things that you just need --------------------------------------------

(setq-default show-trailing-whitespace t)

;; spaces instead of tabs for indentation
(setq-default indent-tabs-mode nil)

;; enable auto-fill in all major modes
(setq-default auto-fill-function 'do-auto-fill)

;; default fill-column is 80
(setq-default fill-column 80)

(provide 'init-user)
