(defun setup-rustic-mode ()
  (interactive)
  (utils-install-packages '(
                            rustic
                            lsp-mode
                            ))
  (lsp)
  )

(add-hook 'rustic-mode-hook 'setup-rustic-mode)

(provide 'rust-layer)
