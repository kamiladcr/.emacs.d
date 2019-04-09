(utils-install-packages '(
													anaconda-mode
													company-anaconda
													pipenv
													))

(defun setup-python-mode ()
	(interactive)
	(anaconda-mode)
	(anaconda-eldoc-mode)
	(pipenv-mode)
	(add-to-list 'company-backends 'company-anaconda)
	(setenv "PYTHONIOENCODING" "utf-8"))

(add-hook 'python-mode-hook #'setup-python-mode)

(provide 'python-layer)
