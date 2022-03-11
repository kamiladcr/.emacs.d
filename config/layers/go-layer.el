(utils-install-packages '(
                          go-mode
                          lsp-mode
                          ))

(defun setup-go-mode ()
  (interactive)
  (lsp)
  )

(add-hook 'go-mode-hook 'setup-go-mode)

(provide 'go-layer)
