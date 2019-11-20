(defvar core-packages '(
                        auto-package-update
                        buffer-move
                        company
                        company-lsp
                        company-quickhelp
                        counsel
                        counsel-projectile
                        doom-modeline
                        exec-path-from-shell
                        exwm
                        flycheck
                        flyspell-correct-ivy
                        kaolin-themes
                        lsp-treemacs
                        lsp-ui
                        magit
                        projectile
                        rainbow-delimiters
                        rainbow-mode
                        restclient
                        treemacs
                        treemacs-magit
                        treemacs-projectile
                        undo-tree
                        which-key
                        winum
                        ))
(utils-install-packages core-packages)

;; Shell should remember path
(exec-path-from-shell-initialize)

;; Transparent titlebar for Mac
(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))

;; My favorite theme
(load-theme 'kaolin-valley-dark t)

;; My favorite font
(set-frame-font "Fira Code 12" nil t)

;; Enable fancy modeline
(doom-modeline-mode)

;; Jump to window
(winum-mode)

;; Little help to remember the shortcuts
;;(which-key-mode)
;;(which-key-setup-minibuffer)

;; Turn on ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-initial-inputs-alist nil) ;; Fuzzy match

(global-undo-tree-mode) ;; Global undo tree mode

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

;; Enable global spellcheck
(global-flycheck-mode)

;; Enable projectile
(projectile-mode)

;; Enable counsel-projectile front-end
(counsel-projectile-mode)

;; Auto-update packages
(auto-package-update-maybe)

;; Enable recentf-mode
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)

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
