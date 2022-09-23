(defun setup-haskell-mode ()
  (interactive)
  (utils-install-packages '(
                            haskell-mode
                            ;; lsp-haskell
                            ))
  (haskell-indentation-mode)
  ;; (lsp)
  )

(add-hook 'haskell-mode-hook 'setup-haskell-mode)

(provide 'haskell-layer)
