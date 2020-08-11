(defalias 'yes-or-no-p 'y-or-n-p)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;; Font size
(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Shift-arrow for window switch
(windmove-default-keybindings)

;; Bind whitespace cleanup to a key
(global-set-key (kbd "C-c w") 'whitespace-cleanup)

;; Align code blocks
(global-set-key (kbd "C-c a") 'align-regexp)

;; Kill buffer and window by default
(global-set-key (kbd "C-x k") 'kill-current-buffer)

;; Force company
(global-set-key (kbd "M-/") 'company-complete)

;; Ace-jump-mode
(global-set-key (kbd "M-j") 'avy-goto-word-1)
(global-set-key (kbd "M-k") 'avy-goto-char-in-line)

;; ivy keys
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Delete instead of kill
(global-set-key (kbd "M-DEL") 'backward-delete-word)

;; Flyspell via ivy
(global-set-key (kbd "M-$") 'flyspell-correct-wrapper)

;; Kill emacs process on exit
(global-set-key (kbd "C-x C-c") 'save-buffers-kill-emacs)

;; Toggle treemacs
(global-set-key (kbd "C-<tab>") 'treemacs)

;; Copy paste for others
(global-set-key (kbd "C-z") 'undo-tree-undo)

;; Tabs
(global-set-key (kbd "C-<prior>")  'centaur-tabs-backward)
(global-set-key (kbd "C-<next>") 'centaur-tabs-forward)
(global-set-key (kbd "C-c t s") 'centaur-tabs-counsel-switch-group)

;; flycheck
(global-set-key (kbd "M-p")  'flycheck-previous-error)
(global-set-key (kbd "M-n")  'flycheck-next-error)

;; lsp-mode
(global-set-key (kbd "C-c l h") 'lsp-ui-doc-show)
(global-set-key (kbd "C-c l i") 'lsp-ui-imenu)

(provide 'bindings)
