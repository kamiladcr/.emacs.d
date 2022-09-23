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
                        flycheck
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
                        mood-one-theme
                        mood-line
                        howdoyou
                        cmake-mode
                        ))

;; Use gpastel for kill ring
(gpastel-mode)

;; Shell should remember path
(exec-path-from-shell-initialize)

;; Set theme
(load-theme 'mood-one t)
(mood-line-mode t)

;; My favorite font
(set-frame-font "JetBrains Mono 12" nil t)

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

;; Enable global spellcheck
(global-flycheck-mode)

;; Enable projectile
(projectile-mode)

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

;; Auto restart
(setq lsp-keymap-prefix "C-c l")
(setq lsp-enable-which-key-integration 1)
(setq lsp-restart 'auto-restart)

;; Remove stupid default regex symbols
(setq ivy-initial-inputs-alist nil)

(setq sql-postgres-login-params
      '((server :default "localhost")
        (port :default 5432)
        (user :default "irma")
        (database :default "irma.ensemble")))

(setq vterm-shell "fish")

(yas-global-mode 1)
(setq yas-wrap-around-region t)

;; Enable SSL on rcirc
(setq rcirc-server-alist
      '(("irc.freenode.net" :port 6697 :encryption tls
         :channels ("#rcirc" "#emacs" "#Emacs"))))

;; Enable emoji
(emojify-mode)

;; Window management
(defun split-window-below-and-focus ()
  "Split the window vertically and focus the new window."
  (interactive)
  (split-window-below)
  (run-at-time "0.1 seconds" nil
               (lambda ()
                 (windmove-down)
                 (when (and (boundp 'golden-ratio-mode)
                            (symbol-value golden-ratio-mode))
                   (golden-ratio)))))

(defun split-window-right-and-focus ()
  "Split the window vertically and focus the new window."
  (interactive)
  (split-window-right)
  (run-at-time "0.1 seconds" nil
               (lambda ()
                 (windmove-right)
                 (when (and (boundp 'golden-ratio-mode)
                            (symbol-value golden-ratio-mode))
                   (golden-ratio)))))

(defun nixos-config ()
  (interactive)
  (counsel-find-file-as-root "/etc/nixos/configuration.nix"))

;; This is required for lsp-mode to work correctly with native compilation
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(setq tvl-target-branch "master")
(setq tvl-depot-path "~/Resoptima/irma")

(provide 'core)
