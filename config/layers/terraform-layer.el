(utils-install-packages '(
                          terraform-mode
                          company-terraform
                          ))

(defun setup-terraform-mode ()
  (interactive)
  (company-terraform-init)
  )

(add-hook 'terraform-mode-hook 'setup-terraform-mode)

(provide 'terraform-layer)
