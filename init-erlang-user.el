;; user configuration examples for erlang development in emacs -----------------

;; setup paths as needed (required by init-erlang.el)
(setq init-erlang-root "/usr/lib/erlang")
(setq init-erlang-mode-path
  (car (file-expand-wildcards "/usr/lib/erlang/lib/tools-*/emacs")))
(setq init-erlang-wrangler-path
  (expand-file-name "~/.emacs.d/erlang/wrangler"))
(setq init-erlang-distel-path
  (expand-file-name "~/.emacs.d/erlang/distel"))
(setq init-erlang-flymake-compile-script
  (expand-file-name "~/.emacs.d/erlang/flymake-compile-erlang"))

(setq erlang-indent-level 4)

;; running make on rebar project repo (apps,deps)
(defun erlang-compile-command ()
  (setq compile-command "make -k -C ../../.."))
(add-hook 'erlang-mode-hook 'erlang-compile-command)

;; extra keybindings
(defun load-extra-erlang-mode-bindings ()
  (define-key erlang-mode-map (kbd "C-c C-d M") 'erlang-man-function)
  (define-prefix-command 'ctrl-c-ctrl-z-keymap)
  (define-key erlang-mode-map (kbd "C-c C-z") 'ctrl-c-ctrl-z-keymap)
  (define-key ctrl-c-ctrl-z-keymap (kbd "z") 'erlang-shell-display)
  (define-key ctrl-c-ctrl-z-keymap (kbd "r") 'erlang-shell-remote)
  (define-key ctrl-c-ctrl-z-keymap (kbd "k") 'recompile))
(add-hook 'erlang-mode-hook 'load-extra-erlang-mode-bindings)

(provide 'init-erlang-user)
