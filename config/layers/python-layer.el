(utils-install-packages '(
                          lsp-pyright
                          highlight-indent-guides
                          lsp-mode
                          ))

(defun setup-python-mode ()
  (interactive)
  (require 'lsp-pyright)
  (highlight-indent-guides-mode)
  (lsp)
  (setenv "PYTHONIOENCODING" "utf-8"))

(add-hook 'python-mode-hook #'setup-python-mode)

(provide 'python-layer)
