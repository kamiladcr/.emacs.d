(defun setup-python-mode ()
  (interactive)
  (utils-install-packages '(
                            highlight-indent-guides
                            lsp-mode
                            lsp-pyright
                            ))
  (require 'lsp-pyright)
  (lsp)
  (setenv "PYTHONIOENCODING" "utf-8"))

(add-hook 'python-mode-hook #'setup-python-mode)

(provide 'python-layer)
