(utils-install-packages '(
                          fsharp-mode
                          lsp-mode
                          company-lsp
                          ))

(defun setup-fsharp-mode ()
  (interactive)
  (push 'company-lsp company-backends)
  (setq inferior-fsharp-program "dotnet fsi")
  (lsp)
  (lsp-lens-mode)
  )

(add-hook 'fsharp-mode-hook 'setup-fsharp-mode)

;; (setq lsp-fsharp-server-download-url "https://github.com/fsharp/FsAutoComplete/releases/download/0.41.0/fsautocomplete.netcore.zip")
(setq lsp-fsharp-server-runtime 'net-core)

(provide 'fsharp-layer)
