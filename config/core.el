(defvar core-packages '(
                        all-the-icons
                        auto-package-update
                        buffer-move
                        company
                        company-lsp
                        company-quickhelp
                        counsel
                        counsel-projectile
                        doom-modeline
                        doom-themes
                        exec-path-from-shell
                        exwm
                        flycheck
                        flyspell-correct-ivy
                        kaolin-themes
                        lsp-mode
                        lsp-treemacs
                        lsp-ui
                        magit
                        markdown-preview-mode
                        multiple-cursors
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

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-molokai t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;; Make mode line a bit smaller
(setq doom-modeline-height 36)
(set-face-attribute 'mode-line nil :height 100)
(set-face-attribute 'mode-line-inactive nil :height 100)

;; My favorite font
(set-frame-font "Fira Code 12" nil t)

;; Enable fancy modeline
(fset 'battery-update #'ignore) ;; This is fix for battery issue
(doom-modeline-mode)

;; Jump to window
(winum-mode)

;; Little help to remember the shortcuts
(which-key-mode)
(which-key-setup-side-window-bottom)

;; Turn on ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

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

;; Keep your temporary files away from project
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

;; Treemacs to have smaller font
(defun text-scale-twice ()
  (interactive)
  (progn (text-scale-adjust 0) (text-scale-decrease 2)))

(add-hook 'treemacs-mode-hook 'text-scale-twice)

(provide 'core)
