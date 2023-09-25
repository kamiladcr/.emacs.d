(defalias 'yes-or-no-p 'y-or-n-p)

(setq mac-option-modifier 'meta
      mac-command-modifier 'super
      mac-right-option-modifier 'none)

(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-z") 'undo)

;; Font size
(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; shift-arrow for window switch
(windmove-default-keybindings)

;; Bind whitespace cleanup to a key
(global-set-key (kbd "C-c w") 'whitespace-cleanup)

;; Align code blocks
(global-set-key (kbd "C-c a") 'align-regexp)

;; Kill buffer and window by default
(global-set-key (kbd "C-x k") 'kill-current-buffer)

;; Force company
(global-set-key (kbd "M-C-/") 'company-dabbrev)
(global-set-key (kbd "M-/") 'company-complete)

;; Ace-jump-mode
(global-set-key (kbd "M-j") 'avy-goto-word-1)
(global-set-key (kbd "M-k") 'avy-goto-char-in-line)

;; ivy keys
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-w") 'ivy-kill-ring-save)

;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Delete instead of kill
(global-set-key (kbd "C-<backspace>") 'backward-delete-word)

;; Flyspell via ivy
(global-set-key (kbd "M-$") 'flyspell-correct-wrapper)

;; Kill emacs process on exit
(global-set-key (kbd "C-x C-c") 'save-buffers-kill-emacs)

;; Copy paste for others
(global-set-key (kbd "C-z") 'undo-tree-undo)

;; flycheck
(global-set-key (kbd "M-p")  'flycheck-previous-error)
(global-set-key (kbd "M-n")  'flycheck-next-error)

(global-set-key (kbd "C-x 2") 'split-window-below-and-focus)
(global-set-key (kbd "C-x 3") 'split-window-right-and-focus)
(global-set-key (kbd "M-RET") 'make-frame-command)
(global-set-key (kbd "C-x f") 'toggle-maximize-buffer)

(with-eval-after-load 'magit-mode
  (define-key magit-mode-map (kbd "M-1") nil)
  (define-key magit-mode-map (kbd "M-2") nil)
  (define-key magit-mode-map (kbd "M-3") nil)
  (define-key magit-mode-map (kbd "M-4") nil))

(global-set-key (kbd "M-1") 'winum-select-window-1)
(global-set-key (kbd "M-2") 'winum-select-window-2)
(global-set-key (kbd "M-3") 'winum-select-window-3)
(global-set-key (kbd "M-4") 'winum-select-window-4)
(global-set-key (kbd "M-5") 'winum-select-window-5)
(global-set-key (kbd "M-6") 'winum-select-window-6)
(global-set-key (kbd "M-7") 'winum-select-window-7)
(global-set-key (kbd "M-8") 'winum-select-window-8)

;; Resize buffers
(global-set-key (kbd "C-M-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "C-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-<up>")    'shrink-window)
(global-set-key (kbd "C-M-<down>")  'enlarge-window)

(global-set-key (kbd "C-x C-d") 'dired)

(with-eval-after-load 'yas-minor-mode
  (yas-minor-mode-map (kbd "C-c y") #'yas-expand))

(provide 'bindings)
