(require 'package)

;; Initialize nix packages
(package-initialize)

;; Configure MELPA repositories.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Custom location for standard settings from M-x customize
(setq custom-file (concat user-emacs-directory "config/custom.el"))
(load custom-file)

;; Add config folder that contains other settings to load.
(add-to-list 'load-path (concat user-emacs-directory "config"))
(add-to-list 'load-path (concat user-emacs-directory "config/layers"))

;; Import configuration packages
(defun initialize-settings ()
  (interactive)
  (mapc 'require '(utils
                   ;; desktop
                   core
                   bindings
                   layers
                   )))

(add-hook 'after-init-hook 'initialize-settings)

(put 'upcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'downcase-region 'disabled nil)
