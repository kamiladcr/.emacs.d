(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(auto-revert-check-vc-info t)
 '(auto-revert-interval 2)
 '(auto-save-file-name-transforms '((".*" "/tmp/" t)))
 '(backup-directory-alist '((".*" . "/tmp/")))
 '(backward-delete-char-untabify-method 'hungry)
 '(blink-cursor-mode nil)
 '(company-dabbrev-downcase nil)
 '(company-idle-delay 0.8)
 '(company-insertion-triggers '(32 95 40 41 119 46))
 '(company-require-match nil)
 '(company-selection-wrap-around t)
 '(company-tooltip-maximum-width 100)
 '(custom-safe-themes
   '("24b6ade0e3cabdfee9fa487961b089d059e048d77fe13137ea4788c1b62bd99d" "551320837bd87074e3de38733e0a8553618c13f7208eda8ec9633d59a70bc284" "603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961" "6fc9e40b4375d9d8d0d9521505849ab4d04220ed470db0b78b700230da0a86c1" "2007ae44334eda7781d3d17a6235cd2d7f236e1b8b090e33c8e7feb74c92b634" "370109bfd8c7784bbf62e3f8c4f332aed0b915116e2d718bc7e2b8e0ebe35e10" default))
 '(dabbrev-case-replace nil)
 '(dashboard-startup-banner 'logo)
 '(default-input-method nil)
 '(delete-selection-mode t)
 '(dired-listing-switches "-alh")
 '(gc-cons-threshold 20000000)
 '(highlight-indent-guides-method 'bitmap)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-major-mode 'text-mode)
 '(initial-scratch-message "")
 '(json-reformat:indent-width 2)
 '(magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1)
 '(markdown-command "pandoc -f gfm")
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(which-key vterm projectile counsel company auto-package-update buffer-move catppuccin-theme cmake-mode company-quickhelp counsel-projectile dashboard direnv dockerfile-mode dracula-theme dumb-jump emojify ess exec-path-from-shell flycheck flymake-ruff flyspell-correct-ivy format-all gpastel hcl-mode howdoyou htmlize impatient-mode jinja2-mode jinx jupyter magit markdown-preview-mode multiple-cursors nix-mode protobuf-mode python-mode rainbow-delimiters rainbow-mode restclient rotate undo-tree vterm-toggle web-mode winum yaml-mode yasnippet))
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(tab-bar-mode nil)
 '(tab-width 2)
 '(tool-bar-mode nil)
 '(undo-tree-history-directory-alist '(("." . "~/.emacs.d/.undo-tree")))
 '(warning-suppress-log-types '((lsp-mode) (lsp-mode) (comp)))
 '(warning-suppress-types '((lsp-mode) (comp)))
 '(web-mode-code-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-markup-indent-offset 2)
 '(web-mode-sql-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ivy-current-match ((t nil)))
 '(ivy-highlight-face ((t nil)))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#2aa198"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#b58900"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#268bd2"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "plum1"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#859900"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#268bd2"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#cb4b16"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#d33682"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#839496"))))
 '(yascroll:thumb-fringe ((t (:background "peru" :foreground "peru"))))
 '(yascroll:thumb-text-area ((t (:background "peru")))))
