(defun setup-python-mode ()
  (interactive)
  (utils-install-packages '(
                            highlight-indent-guides
                            lsp-mode
                            lsp-pyright
                            ))
  (require 'lsp-pyright)
  (setq indent-tabs-mode t)
  (setq tab-width 4)
  (setq lsp-signature-auto-activate t)
  (setq python-indent-offset 4)
  (lsp)
  (setenv "PYTHONIOENCODING" "utf-8"))

(add-hook 'python-mode-hook #'setup-python-mode)

(provide 'python-layer)
