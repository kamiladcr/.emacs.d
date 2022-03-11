(defvar core-packages '(
                        all-the-icons
                        auto-package-update
                        buffer-move
                        centered-cursor-mode
                        cl-lib
                        company
                        company-quickhelp
                        counsel
                        counsel-projectile
                        direnv
                        dockerfile-mode
                        doom-modeline
                        doom-themes
                        emojify
                        exec-path-from-shell
                        exwm
                        flycheck
                        flyspell-correct-ivy
                        format-all
                        gpastel
                        lsp-mode
                        lsp-treemacs
                        lsp-ui
                        magit
                        markdown-preview-mode
                        multiple-cursors
                        poke-line
                        projectile
                        protobuf-mode
                        rainbow-delimiters
                        rainbow-mode
                        restclient
                        solaire-mode
                        transient
                        treemacs
                        treemacs-magit
                        treemacs-projectile
                        undo-tree
                        use-package
                        vterm
                        which-key
                        winum
                        yaml-mode
                        yasnippet
                        ))
(utils-install-packages core-packages)

;; Use direnv
(direnv-mode)

;; Use gpastel for kill ring
(gpastel-mode)

;; Shell should remember path
(exec-path-from-shell-initialize)

;; Transparent titlebar for Mac
(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))

;; Doom theme
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-molokai t)

;; or for treemacs users
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;; Make mode line a bit smaller
(doom-modeline-mode)
(setq doom-modeline-height 30)

;; My favorite font
(set-frame-font "JetBrains Mono 12" nil t)

;; Jump to window
(winum-mode)

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

;; Keep your temporary files away from project
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

;; Treemacs to have smaller font
(defun text-scale-twice ()
  (interactive)
  (progn (text-scale-adjust 0) (text-scale-decrease 2)))

;; ;; I like when treemacs is more compact then other parts
(add-hook 'treemacs-mode-hook 'text-scale-twice)

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
(setq lsp-restart 'auto-restart)

;; Remove stupid default regex symbols
(setq ivy-initial-inputs-alist nil)

(setq sql-postgres-login-params
      '((server :default "localhost")
        (port :default 5432)
        (user :default "irma")
        (database :default "irma.ensemble")))

(poke-line-global-mode)
(poke-line-set-random-pokemon)
(setq vterm-shell "fish")

(yas-global-mode 1)
(setq yas-wrap-around-region t)

(use-package transient)
(use-package tshell
  :after transient
  :load-path "tshell")

;; Enable SSL on rcirc
(setq rcirc-server-alist
      '(("irc.freenode.net" :port 6697 :encryption tls
         :channels ("#rcirc" "#emacs" "#emacswiki"))))

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

;; Enable full screen mode
(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (cl-remove-if #'treemacs-is-treemacs-window? (window-list))))
      (jump-to-register '_)
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(provide 'core)
