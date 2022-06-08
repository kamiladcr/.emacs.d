(defun setup-go-mode ()
  (interactive)
  (utils-install-packages '(
                            go-mode
                            lsp-mode
                            ))
  (lsp))

(add-hook 'go-mode-hook 'setup-go-mode)

(provide 'go-layer)
