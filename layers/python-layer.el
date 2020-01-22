(utils-install-packages '(
													anaconda-mode
                          lsp-mode
                          company-lsp
													pipenv
													))

(defun setup-python-mode ()
	(interactive)
	(anaconda-mode)
	(anaconda-eldoc-mode)
	(pipenv-mode)
  (company-mode t)
	(push 'company-lsp company-backends)
  (lsp)
	(setenv "PYTHONIOENCODING" "utf-8"))

(add-hook 'python-mode-hook #'setup-python-mode)

(provide 'python-layer)
