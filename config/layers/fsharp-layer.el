(utils-install-packages '(
                          fsharp-mode
                          highlight-indent-guides
                          company
                          ;; eglot
                          ;; eglot-fsharp
                          lsp-mode
                          ))

(defun setup-fsharp-mode ()
  (interactive)
  (highlight-indent-guides-mode)
  (company-mode)
  (lsp)
  ;; (require 'eglot-fsharp)
  ;; (defun eglot-fsharp--path-to-server ()
  ;;   "Return FsAutoComplete path."
  ;;   (file-truename "/home/ezemtsov/.dotnet/tools/fsautocomplete"))
  ;; (eglot-ensure)
  )

(require 'eglot)
;; (add-to-list 'eglot-server-programs '(fsharp-mode . ("/home/ezemtsov/.dotnet/tools/fsautocomplete" "--verbose")))
(add-to-list 'auto-mode-alist '("\\.fsproj\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.csproj\\'" . nxml-mode))

(add-hook 'fsharp-mode-hook #'setup-fsharp-mode)

(provide 'fsharp-layer)
