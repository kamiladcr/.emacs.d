(utils-install-packages '(
                          csharp-mode
                          lsp-mode
                          ))

(defun setup-csharp-mode ()
  (interactive)
  (lsp)
  )

(add-hook 'csharp-mode-hook 'setup-csharp-mode)

(setq lsp-csharp-server-path (executable-find "omnisharp"))

(provide 'csharp-layer)
