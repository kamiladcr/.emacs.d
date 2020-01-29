(utils-install-packages '(
                          lsp-mode
                          company-lsp
                          ))

(defun setup-python-mode ()
  (interactive)
  (setenv "PYTHONIOENCODING" "utf-8")
  (push 'company-lsp company-backends)
  (lsp))

(add-hook 'python-mode-hook #'setup-python-mode)

(provide 'python-layer)
