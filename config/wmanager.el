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
  (shell-command "xrandr --output eDP1 --auto --output HDMI2 --off")
  (message "Disable external monitor"))
(defun monitor-external-enable ()
  (interactive)
  (shell-command "xrandr --output eDP1 --auto --output HDMI2 --auto --above eDP1")
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

;; Monitor functions
(setq monitor-current (alist-get 'name (frame-monitor-attributes)))
(setq monitor-list (mapcar
                    (lambda (arg) (alist-get 'name arg))
                    (display-monitor-attributes-list)))
(setq monitor-primary "eDP1")
(setq monitor-external "HDMI2")

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

;; Disable line-mode, why would I need it?
;; (setq exwm-manage-configurations '((t char-mode t)))

;; Set 10 workspaces
(setq exwm-workspace-number 2)

;; Make buffers from all workspaces available in buffer-menu
(setq exwm-workspace-show-all-buffers t)
(setq exwm-layout-show-all-buffers t)

;; Buffer names equal to xwindow class name
(defun exwm-rename-buffer ()
  (interactive)
  (exwm-workspace-rename-buffer exwm-class-name))
(add-hook 'exwm-update-class-hook 'exwm-rename-buffer)

;; Show tiny fringes
(fringe-mode 3)

;; Show system tray
(exwm-systemtray-enable)

;; Keyboard layout per window
(exwm-xim-enable)

;;-----------------------------------------------------------
;; EXWM Bindings
;;-----------------------------------------------------------

;; Emacs emulation for xwindows
(setq exwm-input-simulation-keys
      '((,(kbd "C-b") . [left])
        (,(kbd "C-b") . [right])
        (,(kbd "C-p") . [up])
        (,(kbd "C-n") . [down])
        (,(kbd "C-a") . [home])
        (,(kbd "C-e") . [end])
        (,(kbd "C-d") . [delete])))

;; Global EXWM keybindings
(setq exwm-input-global-keys
        ;; Utilities
      `((,(kbd "s-r")                     . exwm-reset)
        (,(kbd "s-w")                     . exwm-workspace-switch)
        (,(kbd "s-f")                     . exwm-layout-toggle-fullscreen)
        (,(kbd "s-q")                     . kill-this-buffer)
        (,(kbd "s-Q")                     . kill-buffer-and-window)
        (,(kbd "s-d")                     . counsel-linux-app)
        (,(kbd "s-l")                     . screen-lock)
        (,(kbd "s-<tab>")                 . treemacs)
        (,(kbd "<print>")                 . screenshot)
        (,(kbd "s-<return>")              . terminal-new)
        (,(kbd "s-i")                     . exwm-input-toggle-keyboard)
        (,(kbd "s-\\")                    . exwm-input-prefix-keys)

        ;; External monitor
        (,(kbd "s-m <up>")                . monitor-external-enable)
        (,(kbd "s-m <down>")              . monitor-external-disable)
        (,(kbd "s-m S-<up>")              . workspace-move-to-external)
        (,(kbd "s-m S-<down>")            . workspace-move-to-primary)

        ;; Navigate among buffers
        (,(kbd "s-<up>")                  . windmove-up)
        (,(kbd "s-<down>")                . windmove-down)
        (,(kbd "s-<left>")                . windmove-left)
        (,(kbd "s-<right>")               . windmove-right)

        ;; Resize buffers
        (,(kbd "S-<left>")                . shrink-window-horizontally)
        (,(kbd "S-<right>")               . enlarge-window-horizontally)
        (,(kbd "S-<down>")                . shrink-window)
        (,(kbd "S-<up>")                  . enlarge-window)

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

        ;; Switch to workspace by s-N
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
  '(0 "HDMI2" 1 "eDP1"))
(exwm-randr-enable)

(provide 'wmanager)
