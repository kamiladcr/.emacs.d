(require 'package)

;; Configure Marmalade and MELPA repositories.
;; Packages available on Marmalade will have precedence.
(defvar package-repos
	'(
		("marmalade" . "https://marmalade-repo.org/packages/")
		("melpa" . "http://melpa.milkbox.net/packages/")
		))
(mapc (lambda (item) (add-to-list 'package-archives item)) package-repos)
(package-initialize)

;; Custom location for standard settings from M-x customize
(setq custom-file (concat user-emacs-directory "config/custom.el"))
(load custom-file)

;; Add config folder that contains other settings to load.
(add-to-list 'load-path (concat user-emacs-directory "config"))

;; Import configuration packages
(defun load-other-settings ()
	(mapc 'require
				'(
  				utils
					core
					layers
					bindings
					)))
(add-hook 'after-init-hook 'load-other-settings)


(require 'server)
(unless (server-running-p) (server-start))
(put 'erase-buffer 'disabled nil)
