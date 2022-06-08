(defun setup-clisp-mode ()
  (interactive)
  (utils-install-packages '(
                            sly
                            ))
  (setq inferior-lisp-program "/run/current-system/sw/bin/sbcl"))

(add-hook 'lisp-mode-hook 'setup-clisp-mode)

(provide 'clisp-layer)
