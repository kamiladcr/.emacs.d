(defvar core-packages '( ace-window
                         auto-package-update
                         avy company
                         company-quickhelp
                         counsel
                         doom-themes
                         exec-path-from-shell
                         flycheck
                         frames-only-mode
                         magit
                         nix-mode
                         projectile
                         perspective
                         persp-projectile
                         rainbow-delimiters
                         rainbow-mode
                         restclient
                         treemacs
                         treemacs-projectile
                         undo-tree))
(utils-install-packages core-packages)

(exec-path-from-shell-initialize)

;; Doom theme
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-opera t)
;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Turn on ivy
(ivy-mode 1)

(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; Fuzzy match
(setq ivy-initial-inputs-alist nil)

;; Always show window nubmers
(ace-window-display-mode)

;; Global undo tree mode
(global-undo-tree-mode)

;; Always auto-close parantheses and other pairs
(electric-pair-mode)

;; UTF-8 by default
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Keep temporary files in tmp
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq backup-directory-alist
			`((".*" . ,temporary-file-directory)))

;; Eable global spellcheck
(global-flycheck-mode)

;; Enable perspective mode
(persp-mode +1)

;; Enable projectile
(projectile-mode)

;; Auto-update packages
(auto-package-update-maybe)

(provide 'core)
