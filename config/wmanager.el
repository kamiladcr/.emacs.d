;; EXWM
(require 'exwm)
(require 'exwm-config)
(require 'exwm-randr)
(require 'exwm-systemtray)
(require 'exwm-xim)

(defun screenshot ()
  (interactive)
  (shell-command "flameshot gui"))

(defun suspend ()
  (interactive)
  (shell-command "systemctl suspend"))

(defun screen-lock ()
  (interactive)
  (shell-command "i3lock -t -i /etc/nixos/resources/desktop.png"))

(defun terminal-new ()
  (interactive)
  (vterm))

(defun terminal-toggle ()
  (interactive)
  (vterm-toggle))

(defun monitor-external-disable ()
  (interactive)
  (shell-command "xrandr --output eDP1 --primary --auto --output DP1-1-8 --off")
  (message "Disable external monitor"))

(defun monitor-external-enable ()
  (interactive)
  (shell-command "xrandr --output eDP1 --off --output DP1-1-8 --auto --primary")
  (message "Enable external monitor"))

(defun pulseaudio-ctl (cmd)
  (shell-command (concat "pulseaudio-ctl " cmd))
  (message "Volume command: %s" cmd))

(defun volume-mute ()
  (interactive) (pulseaudio-ctl "mute")
  (message "Speakers mute toggled"))

(defun volume-up ()
  (interactive) (pulseaudio-ctl "up")
  (message "Speakers volume up"))

(defun volume-down ()
  (interactive) (pulseaudio-ctl "down")
  (message "Speakers volume down"))

(defun brightness-up ()
  (interactive)
  (shell-command "exec light -A 10")
  (message "Brightness increased"))

(defun brightness-down ()
  (interactive)
  (shell-command "exec light -U 10")
  (message "Brightness decreased"))

(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_)
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(defun exwm-counsel-yank-pop ()
  "Same as `counsel-yank-pop' and paste into exwm buffer."
  (interactive)
  (let ((inhibit-read-only t)
        ;; Make sure we send selected yank-pop candidate to
        ;; clipboard:
        (yank-pop-change-selection t))
    (call-interactively #'counsel-yank-pop))
  (when (derived-mode-p 'exwm-mode)
    ;; https://github.com/ch11ng/exwm/issues/413#issuecomment-386858496
    (exwm-input--set-focus (exwm--buffer->id (window-buffer (selected-window))))
    (exwm-input--fake-key ?\C-v)))

;; Monitor functions
(setq monitor-current (alist-get 'name (frame-monitor-attributes)))
(setq monitor-list (mapcar
                    (lambda (arg) (alist-get 'name arg))
                    (display-monitor-attributes-list)))
(setq monitor-primary "eDP1")
(setq monitor-external "DP1-1-8")

(defun workspace-move (display)
  (plist-put exwm-randr-workspace-output-plist
             exwm-workspace-current-index
             display)
  (exwm-randr--refresh))

(defun workspace-move-to-primary ()
  (interactive)
  (workspace-move monitor-primary))

(defun workspace-move-to-external ()
  (interactive)
  (workspace-move monitor-external))

;;-----------------------------------------------------------
;; EXWM Configuration
;;-----------------------------------------------------------

;; Set 10 workspaces
(setq exwm-workspace-number 9)

;; Make buffers from all workspaces available in buffer-menu
(setq exwm-workspace-show-all-buffers t)
(setq exwm-layout-show-all-buffers t)

;; Buffer names equal to xwindow class name
(defun exwm-rename-buffer ()
  (interactive)
  (exwm-workspace-rename-buffer exwm-class-name))
(add-hook 'exwm-update-class-hook 'exwm-rename-buffer)

;; Show tiny fringes
(fringe-mode 5)

;; Show system tray
(exwm-systemtray-enable)

;; Keyboard layout per window
(exwm-xim-enable)

(add-hook 'exwm-floating-setup-hook 'exwm-layout-hide-mode-line)
(add-hook 'exwm-floating-exit-hook 'exwm-layout-show-mode-line)

(add-hook 'exwm-init-hook 'monitor-external-enable)
(add-hook 'exwm-init-hook 'gpastel-mode)

(display-battery-mode)
(setq display-time-format "%a %H:%M")
(display-time-mode 1)

(defvar exwm-mode-line-workspace-map
  (let ((map (make-sparse-keymap)))
    (define-key map [mode-line mouse-1] 'exwm-workspace-switch)
    map)
  "Local keymap for EXWM mode line string.  See `exwm-mode-line-format'.")

(defcustom exwm-mode-line-format
  `("["
    (:propertize (:eval (format "WS-%d" exwm-workspace-current-index))
 local-map ,exwm-mode-line-workspace-map
 face bold
 mouse-face mode-line-highlight
 help-echo "mouse-1: Switch to / add / delete to EXWM workspaces.
mouse-2: EXWM Workspace menu.
")
    "]")
  "EXWM workspace in the mode line."
  :type 'sexp)


;; FIXME: Don't push the value.  Instead push a symbol.  If done, (1)
;; this will avoid duplicate entries for EXWM workspace (2) The mode
;; line string will change in sync with the value of
;; `exwm-mode-line-format'.
(add-to-list 'mode-line-misc-info exwm-mode-line-format t)

;;-----------------------------------------------------------
;; EXWM Bindings
;;-----------------------------------------------------------

(exwm-input-set-key (kbd "M-y") #'exwm-counsel-yank-pop)

;; Emacs emulation for xwindows
(setq exwm-input-simulation-keys
      '((,(kbd "C-b") . [left])
        (,(kbd "C-b") . [right])
        (,(kbd "C-p") . [up])
        (,(kbd "C-n") . [down])
        (,(kbd "C-a") . [home])
        (,(kbd "C-e") . [end])
        (,(kbd "C-d") . [delete])
        (,(kbd "M-w") . (kbd "C-c"))
        (,(kbd "C-y") . (kbd "C-v"))))

;; Global EXWM keybindings
(setq exwm-input-global-keys
        ;; Utilities
      `((,(kbd "s-r")                     . exwm-reset)
        (,(kbd "s-w")                     . exwm-workspace-switch)
        (,(kbd "s-f")                     . toggle-maximize-buffer)
        (,(kbd "s-q")                     . kill-this-buffer)
        (,(kbd "s-Q")                     . kill-buffer-and-window)
        (,(kbd "s-d")                     . counsel-linux-app)
        (,(kbd "s-l")                     . screen-lock)
        (,(kbd "<print>")                 . screenshot)
        (,(kbd "s-<return>")              . terminal-new)
        (,(kbd "s-i")                     . exwm-input-toggle-keyboard)

        ;; External monitor
        (,(kbd "s-m <up>")                . monitor-external-enable)
        (,(kbd "s-m <down>")              . monitor-external-disable)
        (,(kbd "s-m S-<up>")              . workspace-move-to-external)
        (,(kbd "s-m S-<down>")            . workspace-move-to-primary)

        ;; Resize buffers
        (,(kbd "s-<left>")                . windmove-left)
        (,(kbd "s-<right>")               . windmove-right)
        (,(kbd "s-<down>")                . windmove-down)
        (,(kbd "s-<up>")                  . windmove-up)

        ;; Resize buffers
        (,(kbd "s-S-<left>")              . shrink-window-horizontally)
        (,(kbd "s-S-<right>")             . enlarge-window-horizontally)
        (,(kbd "s-S-<down>")              . shrink-window)
        (,(kbd "s-S-<up>")                . enlarge-window)

        ;; Move buffers
        (,(kbd "s-b <up>")                . buf-move-up)
        (,(kbd "s-b <down>")              . buf-move-down)
        (,(kbd "s-b <left>")              . buf-move-left)
        (,(kbd "s-b <right>")             . buf-move-right)

        ;; Media control
        (,(kbd "<XF86AudioMute>")         . volume-mute)
        (,(kbd "<XF86AudioRaiseVolume>")  . volume-up)
        (,(kbd "<XF86AudioLowerVolume>")  . volume-down)
        (,(kbd "<XF86MonBrightnessDown>") . brightness-down)
        (,(kbd "<XF86MonBrightnessUp>")   . brightness-up)

        ;; Switch window by s-o N
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-o %d" i)) .
                      (lambda ()
                        (interactive)
                        (winum-select-window-by-number ,i))))
                  (number-sequence 0 9))

        ;; Switch to workspace by s-N (lambda (i)
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))))

;; Enable EXWM
(exwm-enable)

;; Randr config
(setq exwm-randr-workspace-monitor-plist
  '(0 "eDP1" 1 "DP1-1-8"))
(exwm-randr-enable)

(provide 'wmanager)
