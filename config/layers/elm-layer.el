(defun setup-elm-mode ()
	(interactive)
  (utils-install-packages '(
                            elm-mode
                            ))  
  (elm-mode)
  ;(add-to-list 'company-backends 'company-elm)
  )

(add-hook 'elm-mode-hook #'setup-elm-mode)
  
(provide 'elm-layer)
