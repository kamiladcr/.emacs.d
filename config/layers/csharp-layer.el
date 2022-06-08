(defun setup-csharp-mode ()
  (interactive)
  (utils-install-packages '(
                            csharp-mode
                            lsp-mode
                            ))
  (lsp))

(add-hook 'csharp-mode-hook 'setup-csharp-mode)

(setq lsp-csharp-server-path (executable-find "omnisharp"))

(provide 'csharp-layer)
