(utils-install-packages '(
                          fsharp-mode
                          highlight-indent-guides
                          ;; eglot-fsharp
                          lsp-mode
                          ))

(require 'lsp-fsharp)

(defun setup-fsharp-mode ()
  (interactive)
  ;; (setq lsp-enable-snippet t)
  (highlight-indent-guides-mode)
  (lsp)
  (lsp-lens-mode)
  )

(add-hook 'fsharp-mode-hook 'setup-fsharp-mode)

(add-to-list 'auto-mode-alist '("\\.fsproj\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.csproj\\'" . nxml-mode))

(provide 'fsharp-layer)
