;; config file for erlang development in emacs ------------------------
;; * erlang-mode with remote shell support
;; * flymake
;; * distel
;; * wrangler
;; should not need editing

(setq erlang-root-dir init-erlang-root)
(setq exec-path (cons (concat erlang-root-dir "/lib/bin") exec-path))

;; add erlang mode, wrangler and distel paths to load path
(add-to-list 'load-path init-erlang-mode-path)
(add-to-list 'load-path init-erlang-wrangler-path)
(add-to-list 'load-path init-erlang-distel-path)

(require 'erlang-start)

;; short host name, like `hostname -s`, remote shell likes this better
(defun short-host-name ()
  (string-match "[^\.]+" system-name)
  (substring system-name (match-beginning 0) (match-end 0)))

;; set default nodename for distel (= also for erlang-shell-remote)
(setq erl-nodename-cache (intern (concat "dev" "@" (short-host-name))))

;; makes compiling set paths each time, needed for compiling in remote shell
(setq erlang-compile-use-outdir nil)

;; awesome remote shell function
(defun erlang-shell-remote ()
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
   (list init-erlang-flymake-compile-script (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.erl\\'" flymake-erlang-init))
(add-hook 'erlang-mode-hook 'flymake-mode)

;; require wrangler which also requires distel, and start wrangler
(require 'wrangler)
(erlang-wrangler-on)

(provide 'init-erlang)

