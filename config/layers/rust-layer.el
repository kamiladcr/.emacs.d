(utils-install-packages '(
                          rustic
                          lsp-mode
                          ))

(defun setup-rustic-mode ()
  (interactive)
  (lsp)
  )

(add-hook 'rustic-mode-hook 'setup-rustic-mode)

(provide 'rust-layer)
