(utils-install-packages '(
													js2-mode
													js2-refactor
													company-tern
													))

(defun setup-javascript-mode ()
  (interactive)
  (tern-mode)
  (company-mode)
	(add-to-list 'company-backends 'company-tern))

(add-hook 'js2-mode-hook #'setup-javascript-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(provide 'javascript-layer)
