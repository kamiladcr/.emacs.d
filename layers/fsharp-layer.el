(utils-install-packages '(
                          fsharp-mode
                          lsp-mode
                          company-lsp
                          ))

;; (add-to-list 'load-path "~/.emacs.d/packages/emacs-fsharp-mode/")
;; (autoload 'fsharp-mode "fsharp-mode"     "Major mode for editing F# code." t)
;; (add-to-list 'auto-mode-alist '("\\.fs[iylx]?$" . fsharp-mode))

(defun setup-fsharp-mode ()
  (interactive)
  (push 'company-lsp company-backends)
  (setq inferior-fsharp-program "dotnet fsi")
  (lsp)
  (lsp-lens-mode)
  )

(add-hook 'fsharp-mode-hook 'setup-fsharp-mode)

(provide 'fsharp-layer)
