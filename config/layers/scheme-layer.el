(utils-install-packages '(
                          ))

(require 'scheme)

(defun setup-scheme-mode ()
  (interactive)
  (setq scheme-program-name "csi")
  ) 

(add-hook 'scheme-mode-hook #'setup-scheme-mode)

(provide 'scheme-layer)
