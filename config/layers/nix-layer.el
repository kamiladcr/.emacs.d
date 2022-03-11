(utils-install-packages '(
                          nix-mode
                          lsp-mode
                          company-nixos-options
                          ))

(defun setup-nix-mode ()
  (interactive)
  (lsp)
  )

(add-hook 'nix-mode-hook #'setup-nix-mode)

(provide 'nix-layer)
