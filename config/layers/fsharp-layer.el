(utils-install-packages '(
                          fsharp-mode
                          highlight-indent-guides
                          company
                          lsp-mode
                          ))

(defun setup-fsharp-mode ()
  (interactive)
  (setq lsp-fsharp-use-dotnet-tool-for-fsac 'f)
  (highlight-indent-guides-mode)
  (company-mode)
  (lsp))

(add-to-list 'auto-mode-alist '("\\.fsproj\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.csproj\\'" . nxml-mode))

(add-hook 'fsharp-mode-hook #'setup-fsharp-mode)

(provide 'fsharp-layer)
