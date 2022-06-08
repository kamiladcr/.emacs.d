(defun setup-terraform-mode ()
  (interactive)
  (utils-install-packages '(
                            terraform-mode
                            company-terraform
                            ))
  (company-terraform-init))

(add-hook 'terraform-mode-hook 'setup-terraform-mode)

(provide 'terraform-layer)
