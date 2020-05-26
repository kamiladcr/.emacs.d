;; Add 'modes' folder that contains other settings to load.
(add-to-list 'load-path (concat user-emacs-directory "layers"))

(mapc 'require '(
                 firacode-layer
                 text-layer
                 python-layer
                 javascript-layer
                 typescript-layer
                 elm-layer
                 haskell-layer
                 fsharp-layer
                 csharp-layer
                 nix-layer
                 ))

(fira-code-mode)

(add-hook 'before-save-hook
          (lambda ()
            (whitespace-cleanup)))

(add-hook 'prog-mode-hook
          (lambda ()
            (company-quickhelp-mode)
            (linum-mode)
            (push 'company-files company-backends)
            (show-paren-mode)
            (rainbow-mode)
            (rainbow-delimiters-mode)))

(add-hook 'text-mode-hook
          (lambda ()
            (flyspell-mode)))

(provide 'layers)
