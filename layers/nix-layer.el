(utils-install-packages '(
                          nix-mode
                          company-nixos-options
													))

(defun setup-nix-mode ()
	(interactive)
  (add-to-list 'company-backends 'company-nixos-options))

(add-hook 'nix-mode-hook #'setup-nix-mode)

(provide 'nix-layer)
