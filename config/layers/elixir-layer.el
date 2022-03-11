(utils-install-packages '(
                          elixir-mode
                          lsp-mode
                          ))

(defun setup-elixir-mode ()
  (interactive)
  (lsp)
  )

(add-hook 'elixir-mode-hook 'setup-elixir-mode)

(provide 'elixir-layer)
