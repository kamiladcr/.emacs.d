(defun setup-scheme-mode ()
  (interactive)
  (utils-install-packages '())

  (setq scheme-program-name "csi"))

(add-hook 'scheme-mode-hook #'setup-scheme-mode)

(provide 'scheme-layer)
