;; Add 'modes' folder that contains other settings to load.
(add-to-list 'load-path (concat user-emacs-directory "layers"))

(mapc 'require '(
								 text-layer
								 python-layer
								 javascript-layer
                 elm-layer
                 haskell-layer
                 typescript-layer
								 ))

(add-hook 'prog-mode-hook
					(lambda ()
						(company-mode)
						(company-quickhelp-mode)
          ;;(flyspell-mode)
						(linum-mode)
						(add-to-list 'company-backends 'company-files)
						(add-to-list 'company-backends '(company-capf :with company-dabbrev))
						(show-paren-mode)
						(rainbow-mode)
						(rainbow-delimiters-mode)))

(provide 'layers)
