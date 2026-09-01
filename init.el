(require 'package)

;; Initialize nix packages
(package-initialize)

;; Configure MELPA repositories.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Custom location for standard settings from M-x customize
(setq custom-file (concat user-emacs-directory "config/custom.el"))
(load custom-file)

;; Add config folder that contains other settings to load.
(add-to-list 'load-path (concat user-emacs-directory "config"))
(add-to-list 'load-path (concat user-emacs-directory "config/layers"))

;; Add config folder that contains other settings to load.
(add-to-list 'load-path (concat user-emacs-directory "config"))

(defun settings-initialise ()
  (interactive)
  (require 'utils)
  (require 'core))

(add-hook 'after-init-hook 'settings-initialise)

(put 'erase-buffer 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(defun alacritty ()
  (interactive)
  (start-process-shell-command "alacritty" nil "alacritty"))

(use-package emacs
  :bind
  ("C--" . text-scale-decrease)
  ("C-=" . text-scale-increase))

(use-package ewm
  :config
  (setq tab-bar-show nil)

  (setq ewm-input-config
        '((touchpad :natural-scroll t :tap t)))

  :bind (:map ewm-mode-map
              ("s-t" . tab-bar-new-tab)
              ("s-<return>" . alacritty)))

(defun my/org-paste-clipboard-image ()
  "Save clipboard image via wl-paste and insert an org link."
  (interactive)
  (let* ((dir (concat (file-name-directory (buffer-file-name)) "images/"))
         (name (format "screenshot_%s.png" (format-time-string "%Y%m%d_%H%M%S")))
         (path (concat dir name)))
    (make-directory dir t)
    (unless (= 0 (call-process "wl-paste" nil `(:file ,path) nil "--type" "image/png"))
      (delete-file path)
      (user-error "No image in clipboard"))
    (insert (format "[[file:images/%s]]" name))))

(with-eval-after-load 'org
  (setq org-image-actual-width 400)
  (define-key org-mode-map (kbd "C-M-y") #'my/org-paste-clipboard-image))
