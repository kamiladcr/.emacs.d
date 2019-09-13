(defalias 'yes-or-no-p 'y-or-n-p)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;; That makes me happy with cyrillic layout
(setq default-input-method 'russian-computer)

;; Font size
(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Shift-arrow for window switch
(windmove-default-keybindings)

;; Fast open init file
(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-frame user-init-file))
(global-set-key (kbd "C-c i") 'find-user-init-file)

;; Bind whitespace cleanup to a key
(global-set-key (kbd "C-c w") 'whitespace-cleanup)
;; Align code blocks
(global-set-key (kbd "C-c a") 'align-regexp)

;; Kill buffer and window by default
(global-set-key (kbd "C-x k") 'kill-buffer-and-window)

;; Force company
(global-set-key (kbd "M-/") 'company-complete)

;; Neotree show/hide
(global-set-key (kbd "C-M-SPC") 'treemacs)
(glasses-mode)
;; Ace-jump-mode
(global-set-key (kbd "M-j") 'avy-goto-word-or-subword-1)
(global-set-key (kbd "M-o") 'ace-window)

;; Ivy keys
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(global-set-key (kbd "C-c C-s") 'projectile-persp-switch-project)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

(provide 'bindings)
