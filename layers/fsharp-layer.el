(utils-install-packages '(
                          fsharp-mode
                          lsp-mode
                          ))

(defun setup-fsharp-mode ()
  (interactive)
  (setq inferior-fsharp-program "dotnet fsi")
  (lsp)
  (lsp-lens-mode)
  )

(add-hook 'fsharp-mode-hook 'setup-fsharp-mode)

(add-to-list 'auto-mode-alist '("\\.fsproj\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.csproj\\'" . nxml-mode))

;; (setq lsp-fsharp-server-download-url "https://github.com/fsharp/FsAutoComplete/releases/download/0.41.0/fsautocomplete.netcore.zip")
;; (setq lsp-fsharp-server-install-dir "/home/ezemtsov/Resoptima/FsAutoComplete/src/FsAutoComplete/bin/Debug/netcoreapp2.1")

(setq lsp-fsharp-server-runtime 'net-core)

(provide 'fsharp-layer)
