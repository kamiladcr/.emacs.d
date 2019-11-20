;; Add 'modes' folder that contains other settings to load.
(add-to-list 'load-path (concat user-emacs-directory "layers"))

(mapc 'require '(
								 text-layer
								 python-layer
								 javascript-layer
                 typescript-layer
                 elm-layer
                 haskell-layer
                 fsharp-layer
                 nix-layer
								 ))

(add-hook 'prog-mode-hook
					(lambda ()
						(company-mode)
						(company-quickhelp-mode)
            (flyspell-prog-mode)
						(linum-mode)
						(add-to-list 'company-backends 'company-files)
						(add-to-list 'company-backends '(company-capf :with company-dabbrev))
						(show-paren-mode)
						(rainbow-mode)
						(rainbow-delimiters-mode)))

(add-hook 'text-mode-hook
          (lambda ()
            (flyspell-mode)))

(provide 'layers)
