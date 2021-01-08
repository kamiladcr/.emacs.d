(utils-install-packages '(
                          js2-mode
                          js2-refactor
                          tide
													))

(defun setup-javascript-mode ()
  (interactive)
  (tide-setup)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js2-mode-hook #'setup-javascript-mode)

(provide 'javascript-layer)
