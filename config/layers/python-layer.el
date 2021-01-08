(utils-install-packages '(
                          company-jedi
                          ))

(defun setup-python-mode ()
  (interactive)
  (push 'company-jedi company-backends)
  (setenv "PYTHONIOENCODING" "utf-8"))

(add-hook 'python-mode-hook #'setup-python-mode)

(provide 'python-layer)
