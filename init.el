(require 'package)

;; Configure MELPA repositories.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Custom location for standard settings from M-x customize
(setq custom-file (concat user-emacs-directory "config/custom.el"))
(load custom-file)

;; Add config folder that contains other settings to load.
(add-to-list 'load-path (concat user-emacs-directory "config"))
(add-to-list 'load-path (concat user-emacs-directory "config/layers"))

;; Import configuration packages
(defun load-other-settings ()
  (mapc 'require '(utils
                   core
                   bindings
                   ;; wmanager
                   layers)))

(add-hook 'after-init-hook 'load-other-settings)

(put 'upcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'downcase-region 'disabled nil)
