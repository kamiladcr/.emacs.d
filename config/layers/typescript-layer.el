(defun setup-typescript-mode ()
  (interactive)
  (utils-install-packages '(
                            tide
                            indium
                            ))
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)


(add-hook 'typescript-mode-hook #'setup-typescript-mode)

(provide 'typescript-layer)
