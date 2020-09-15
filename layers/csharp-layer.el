(utils-install-packages '(
                          csharp-mode
                          lsp-mode
                          ))

(defun setup-csharp-mode ()
  (interactive)
  ;; (lsp)
  )

(add-hook 'csharp-mode-hook 'setup-csharp-mode)

;; (setq lsp-csharp-server-path "/nix/store/arpm2rim5l36m7phlcsrj9hhnbxrxhfq-omnisharp-roslyn-1.35.2/bin/omnisharp")

(provide 'csharp-layer)
