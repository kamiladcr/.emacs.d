(utils-install-packages '(
                          csharp-mode
                          lsp-mode
                          company-lsp
                          ))

(defun setup-csharp-mode ()
  (interactive)
  ;; (push 'company-lsp company-backends)
  ;; (lsp)
  )

(add-hook 'csharp-mode-hook 'setup-csharp-mode)

;(setq omnisharp-server-executable-path "/nix/store/q6qx3a5c4d3q5c7pm0yryalavmzkql13-omnisharp-roslyn-1.32.19/bin/omnisharp")

(provide 'csharp-layer)
