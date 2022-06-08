(defun setup-nix-mode ()
  (interactive)
  (utils-install-packages '(
                            nix-mode
                            company-nixos-options
                            )))

(setq nix-nixfmt-bin "nixpkgs-fmt")

(add-hook 'nix-mode-hook #'setup-nix-mode)

(provide 'nix-layer)
