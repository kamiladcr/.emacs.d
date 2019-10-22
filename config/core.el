(defvar core-packages '( ace-window
                         auto-package-update
                         company
                         company-quickhelp
                         counsel
                         counsel-projectile
                         ein
                         kaolin-themes
                         mood-line
                         exec-path-from-shell
                         flycheck
                         frames-only-mode
                         magit
                         projectile
                         perspective
                         persp-projectile
                         rainbow-delimiters
                         rainbow-mode
                         restclient
                         treemacs
                         treemacs-projectile
                         treemacs-magit
                         undo-tree))
(utils-install-packages core-packages)

(exec-path-from-shell-initialize)

;;(frames-only-mode 1)

;; Transparent titlebar for Mac
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

;; My favorite theme
(load-theme 'kaolin-valley-dark t)

;; My favorite font
(set-frame-font "Fira Code 12" nil t)

;; Enable fancy modeline
(mood-line-mode)

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

;; Enable counsel-projectile front-end
(counsel-projectile-mode)

;; Auto-update packages
(auto-package-update-maybe)

;; Delete show delete instead of copying into kill ring
(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

(provide 'core)
