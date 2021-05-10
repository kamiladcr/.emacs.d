(utils-install-packages '(
                          lsp-python-ms
                          highlight-indent-guides
                          lsp-mode
                          ))

(defun setup-python-mode ()
  (interactive)
  (setq lsp-python-ms-executable (executable-find "python-language-server"))
  (highlight-indent-guides-mode)
  (lsp)
  (setenv "PYTHONIOENCODING" "utf-8"))

(add-hook 'python-mode-hook #'setup-python-mode)

(provide 'python-layer)
