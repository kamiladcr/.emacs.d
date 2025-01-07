;; This is taken care by nix
(utils-install-packages '(
                        auto-package-update
                        buffer-move
                        cl-lib
                        rotate
                        company
                        company-quickhelp
                        counsel
                        counsel-projectile
                        direnv
                        emojify
                        exec-path-from-shell
                        flyspell-correct-ivy
                        gpastel
                        magit
                        markdown-preview-mode
                        multiple-cursors
                        projectile
                        rainbow-delimiters
                        rainbow-mode
                        restclient
                        transient
                        undo-tree
                        vterm
                        vterm-toggle
                        which-key
                        winum
                        yaml-mode
                        yasnippet
                        howdoyou
                        cmake-mode
                        dashboard
                        ess
                        nix-mode
                        web-mode
                        format-all
                        protobuf-mode
                        dockerfile-mode
                        dumb-jump
                        jinja2-mode
                        ))

(dashboard-setup-startup-hook)
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)))

;; Use gpastel for kill ring
(gpastel-mode)

;; Shell should remember path
(exec-path-from-shell-initialize)

;; Little help to remember the shortcuts
(which-key-mode)

;; Turn on ivy
(ivy-mode 1)
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

;; Enable counsel-projectile front-end
(counsel-projectile-mode)

;; Enable recentf-mode
(recentf-mode)
(setq ivy-use-virtual-buffers t)
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

;; Whitespace-cleanup all files in project
(defun projectile-whitespace-cleanup ()
  "Deletes trailing spaces from all projectile project files."
  (interactive)
  (let ((project-files (projectile-current-project-files)))
    (dolist (pr project-files)
      (when (file-exists-p pr)
        (message "clearing trailing whitespace in %s" pr)
        (with-temp-buffer
          (insert-file-contents pr)
          (whitespace-cleanup)
          (write-file pr))))))

;; Remove stupid default regex symbols
(setq ivy-initial-inputs-alist nil)

(setq vterm-shell "fish")

;; Enable SSL on rcirc
(setq rcirc-server-alist
      '(("irc.freenode.net" :port 6697 :encryption tls
         :channels ("#rcirc" "#emacs" "#Emacs"))))

;; Window management
(defun split-window-below-and-focus ()
  "Split the window vertically and focus the new window."
  (interactive)
  (split-window-below)
  (windmove-down))

(defun split-window-right-and-focus ()
  "Split the window vertically and focus the new window."
  (interactive)
  (split-window-right)
  (windmove-right))

(use-package eglot
  :defer t
  :ensure t)

(use-package projectile
  :ensure
  :config
  (projectile-global-mode)
  :custom
  (projectile-globally-ignored-directories '(".git"))
  (projectile-dirconfig-file ".gitignore")
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :bind
  (:map projectile-command-map
        ("SPC" . projectile-find-file)
        ;; ("s" . projectile-rip)
        ))

(setq dashboard-projects-backend 'projectile)

(use-package web-mode
  :defer t
  :ensure t
  :mode
  (("\\.html\\'" . web-mode)))

;; C-c C-v C-x
(cua-mode nil)

 ;; Switching between the windows
(use-package emacs
  :init
  (windmove-default-keybindings)
  )

(use-package web-mode
  :ensure t
  :mode
  (("\\.html\\'" . web-mode)))

;; (use-package color-theme-sanityinc-tomorrow
;;   :ensure t
;;   :config
;;   (load-theme 'sanityinc-tomorrow-night))

;; (use-package dracula-theme
;;   :ensure t
;;   :config
;;   (load-theme 'dracula))

;; (use-package catppuccin-theme
;;   :ensure t
;;   :config
;;   (load-theme 'catppuccin))

(load-theme 'catppuccin :no-confirm)

(use-package org-mode
  :no-require
  :hook
  (org-mode . (lambda ()
                (add-hook 'after-save-hook 'org-html-export-to-html t t)))
  :config
  ;; don't ask for confirmation before executing code blocks
  (setq org-confirm-babel-evaluate nil)
  ;; enable Python support in org mode
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (jupyter . t))))

;; org mode render images in emacs
(use-package org-babel
  :no-require
  :config
  (setq org-confirm-babel-evaluate nil)
  (add-hook 'org-babel-after-execute-hook
            'org-redisplay-inline-images))

(add-hook 'org-mode-hook 'visual-line-mode)

(use-package htmlize
  :ensure t)

(use-package python-mode
  :defer t
  :ensure t
  :config
  ;; (highlight-indent-guides-mode)
  (setenv "PYTHONENCODING" "utf-8")
  (setq python-indent-offset 4)
  :hook
  (python-mode . eglot-ensure))

;; preview markdown documents
(use-package impatient-mode
  :ensure t
  )

(use-package jinx
  :hook (emacs-startup . global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages)))

(add-hook 'prog-mode-hook
          (lambda ()
            (company-mode)
            (flyspell-prog-mode)
            (display-line-numbers-mode)
            (push 'company-files company-backends)
            (show-paren-mode)
            (rainbow-mode)
            (rainbow-delimiters-mode)))

(add-hook 'before-save-hook
          (lambda ()
            (whitespace-cleanup)
            ))

;; open magit
(global-set-key (kbd "C-x g") 'magit-status)

;; kill emacs process on exit
(global-set-key (kbd "C-x C-c") 'save-buffers-kill-emacs)

(global-set-key (kbd "C-x 2") 'split-window-below-and-focus)
(global-set-key (kbd "C-x 3") 'split-window-right-and-focus)
(global-set-key (kbd "M-RET") 'make-frame-command)
(global-set-key (kbd "C-x f") 'toggle-maximize-buffer)

(global-set-key (kbd "C-x C-d") 'dired)

(global-set-key (kbd "C-c f") 'format-all-buffer)

;; Delete instead of kill
(global-set-key (kbd "C-<backspace>") 'backward-delete-word)

(provide 'core)
