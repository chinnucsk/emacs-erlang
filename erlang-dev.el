;; baseline config file for erlang development in emacs ------------------------
;; the contents of this file meant to be included or referenced from your
;; regular emacs configuration.

;; short host name, like `hostname -s`, remote shell likes this better
(defun short-host-name ()
  (string-match "[^\.]+" system-name)
  (substring system-name (match-beginning 0) (match-end 0)))

;; set default nodename for distel (= also for erlang-shell-remote)
(setq erl-nodename-cache (intern (concat "dev" "@" (short-host-name))))

;; makes compiling set paths each time, needed for compiling in remote shell
(setq erlang-compile-use-outdir nil)

;; awesome remote shell function
(defun remote-erlang-shell ()
  (interactive)
  (let* ((inferior-erlang-machine-options
          (list "-sname" "emacs"
                "-remsh" (format "%s" erl-nodename-cache))))
    (erlang-shell-display)))

;; setup flymake for erlang-mode (requires fly-compile-erlang in ~/.emacs.d)
(require 'flymake)
(defun flymake-erlang-init ()
   (let*((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file (file-relative-name temp-file
                       (file-name-directory buffer-file-name))))
   (list "~/.emacs.d/fly-compile-erlang"
     (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.erl\\'" flymake-erlang-init))
(add-hook 'erlang-mode-hook 'flymake-mode)

;; add paths to wrangler and distel, require wrangler which also requires distel
(add-to-list 'load-path "<PATH_TO_WRANGLER>/elisp")
(add-to-list 'load-path "<PATH_TO_DISTEL>/elisp")
(require 'wrangler)

;; setup extra keybindings
(defun load-extra-erlang-mode-bindings ()
  (define-key erlang-mode-map (kbd "C-c C-d M") 'erlang-man-function)
  (define-prefix-command 'ctrl-c-ctrl-z-keymap)
  (define-key erlang-mode-map (kbd "C-c C-z") 'ctrl-c-ctrl-z-keymap)
  (define-key ctrl-c-ctrl-z-keymap (kbd "z") 'erlang-shell-display)
  (define-key ctrl-c-ctrl-z-keymap (kbd "r") 'erlang-shell-remote))
(add-hook 'erlang-mode-hook 'load-extra-erlang-mode-bindings)
