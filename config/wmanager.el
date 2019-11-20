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

(defun terminal ()
  (interactive)
  (start-process-shell-command "alacritty" nil "alacritty")
  (message "Run terminal"))

(defun disable-external ()
  (interactive)
  (shell-command "xrandr --output eDP1 --auto --output HDMI2 --off")
  (message "Disable external monitor"))
(defun enable-external ()
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

;; Randr config
(setq exwm-randr-workspace-monitor-plist
  '(0 "HDMI2" 1 "eDP1"))
(exwm-randr-enable)

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

;; Kill emacs process on exit
(global-set-key (kbd "C-x C-c") 'save-buffers-kill-emacs)

;;-----------------------------------------------------------
;; EXWM Bindings
;;-----------------------------------------------------------

;; Reset
(exwm-input-set-key (kbd "s-r") #'exwm-reset)

;; Switch workspace
(exwm-input-set-key (kbd "s-w") #'exwm-workspace-switch)

;; Toggle fullscreen
(exwm-input-set-key (kbd "s-f") #'exwm-layout-toggle-fullscreen)

;; Emacs emulation for xwindows
(setq exwm-input-simulation-keys
      '(([?\C-b] . [left])
        ([?\C-f] . [right])
        ([?\C-p] . [up])
        ([?\C-n] . [down])
        ([?\C-a] . [home])
        ([?\C-e] . [end])
        ([?\C-d] . [delete])))

;; Switch to workspace by s-N
(dotimes (i 10)
  (exwm-input-set-key (kbd (format "s-%d" i))
                      `(lambda ()
                         (interactive)
                         (exwm-workspace-switch-create ,i))))

;; Switch window by s-o N
(dotimes (i 9)
  (exwm-input-set-key (kbd (format "s-o %d" i))
                      `(lambda ()
                         (interactive)
                         (winum-select-window-by-number ,i))))

;; Various utility keys
(exwm-input-set-key (kbd "s-Q")        #'kill-buffer-and-window)
(exwm-input-set-key (kbd "s-d")        #'counsel-linux-app)
(exwm-input-set-key (kbd "s-l")        #'screen-lock)
(exwm-input-set-key (kbd "s-SPC")      #'treemacs)
(exwm-input-set-key (kbd "s-<return>") #'terminal)

;; Select buffers
(exwm-input-set-key (kbd "<s-up>")    #'windmove-up)
(exwm-input-set-key (kbd "<s-down>")  #'windmove-down)
(exwm-input-set-key (kbd "<s-left>")  #'windmove-left)
(exwm-input-set-key (kbd "<s-right>") #'windmove-right)

;; Move buffers
(exwm-input-set-key (kbd "<s-S-up>")    #'buf-move-up)
(exwm-input-set-key (kbd "<s-S-down>")  #'buf-move-down)
(exwm-input-set-key (kbd "<s-S-left>")  #'buf-move-left)
(exwm-input-set-key (kbd "<s-S-right>") #'buf-move-right)

;; External monitor
(exwm-input-set-key (kbd "s-m")        #'enable-external)
(exwm-input-set-key (kbd "s-M")        #'disable-external)
(exwm-input-set-key (kbd "<s-C-up>")   #'workspace-move-to-external)
(exwm-input-set-key (kbd "<s-C-down>") #'workspace-move-to-primary)

;; Switch line/char modes
(exwm-input-set-key (kbd "s-i") #'exwm-input-toggle-keyboard)

;; Enable C-\ in Xwindows
(exwm-input-set-key (kbd "s-\\") #'exwm-input-prefix-keys)

;; Media control
(exwm-input-set-key (kbd "<XF86AudioMute>")         #'volume-mute)
(exwm-input-set-key (kbd "<XF86AudioRaiseVolume>")  #'volume-up)
(exwm-input-set-key (kbd "<XF86AudioLowerVolume>")  #'volume-down)
(exwm-input-set-key (kbd "<XF86MonBrightnessDown>") #'brightness-down)
(exwm-input-set-key (kbd "<XF86MonBrightnessUp>")   #'brightness-up)

;; Screenshot tool
(exwm-input-set-key (kbd "<print>") #'screenshot)

;; Show tiny fringes
(fringe-mode 3)

;; Show system tray
(exwm-systemtray-enable)

;; Keyboard layout per window
(exwm-xim-enable)

;; Enable EXWM
(exwm-enable)

(provide 'wmanager)
