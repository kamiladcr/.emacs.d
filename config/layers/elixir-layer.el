(defun setup-elixir-mode ()
  (interactive)
  (utils-install-packages '(
                            elixir-mode
                            lsp-mode
                            ))
  (lsp)
  )

(add-hook 'elixir-mode-hook 'setup-elixir-mode)

(provide 'elixir-layer)
