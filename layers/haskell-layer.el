(utils-install-packages '(
                          haskell-mode
                          lsp-haskell
                          ))

(defun setup-haskell-mode ()
  (interactive)
  (haskell-indentation-mode)
  ;; (lsp)
  )

(setq lsp-haskell-process-path-hie "hie-wrapper")
(custom-set-variables '(haskell-stylish-on-save t))

(add-hook 'haskell-mode-hook 'setup-haskell-mode)

(provide 'haskell-layer)
