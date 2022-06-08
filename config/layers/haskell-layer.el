(defun setup-haskell-mode ()
  (interactive)
  (utils-install-packages '(
                            haskell-mode
                            lsp-haskell
                            ))
  (haskell-indentation-mode)
  (lsp)
  (lsp-ui-mode)
  )

(setq lsp-haskell-process-path-hie "ghcide")
(setq lsp-haskell-process-args-hie "")

(add-hook 'haskell-mode-hook 'setup-haskell-mode)

(provide 'haskell-layer)
