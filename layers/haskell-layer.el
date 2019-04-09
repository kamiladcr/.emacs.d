(utils-install-packages '(
												  haskell-mode
                          intero
													))

(defun setup-haskell-mode ()
	(interactive)
  (intero-mode))

(add-hook 'haskell-mode-hook #'setup-haskell-mode)
  
(provide 'haskell-layer)
