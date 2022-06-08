;; Add 'modes' folder that contains other settings to load.
(add-to-list 'load-path (concat user-emacs-directory "layers"))

(utils-install-packages '(
                          format-all
                          protobuf-mode
                          hcl-mode
                          dockerfile-mode
                          dumb-jump
                          ))

(mapc 'require '(text-layer
                 python-layer
                 javascript-layer
                 typescript-layer
                 elm-layer
                 haskell-layer
                 tidal-layer
                 fsharp-layer
                 csharp-layer
                 nix-layer
                 rust-layer
                 clisp-layer
                 go-layer
                 elixir-layer
                 scheme-layer
                 ))

(add-hook 'before-save-hook
          (lambda ()
            (whitespace-cleanup)
            (format-all-buffer)))

(add-hook 'prog-mode-hook
          (lambda ()
            (company-mode)
            (flyspell-prog-mode)
            (display-line-numbers-mode)
            (push 'company-files company-backends)
            (show-paren-mode)
            (rainbow-mode)
            (rainbow-delimiters-mode)))

(add-hook 'text-mode-hook
          (lambda ()
            (flyspell-mode)))

(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
(add-to-list 'auto-mode-alist '("\\.tf\\'" . hcl-mode))

(provide 'layers)
