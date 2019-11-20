(utils-install-packages '(
                          lsp-mode
                          fsharp-mode
                          ))

(defun setup-fsharp-mode ()
  (interactive)
  (setq fsharp-indent-offset 2)
  ;;(lsp)
  ;;(fsharp-ac-intellisense-enabled nil)
  ;;(require 'lsp-fsharp)
  )

(add-hook 'fsharp-mode-hook 'setup-fsharp-mode)

(provide 'fsharp-layer)
