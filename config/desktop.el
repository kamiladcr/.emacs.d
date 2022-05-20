;; Jump to window
(winum-mode)

;; EXWM
(require 'exwm)
(require 'exwm-config)
(require 'exwm-randr)
(require 'exwm-systemtray)
(require 'exwm-xim)
(require 'exwm-layout)

;; (defun screenshot ()
;;   (interactive)
;;   (shell-command "flameshot gui"))

;; (defun suspend ()
;;   (interactive)
;;   (shell-command "systemctl suspend"))

(defun exwm-layout--hide (id)
  "Hide window ID."
  (with-current-buffer (exwm--id->buffer id)
    (unless (or (exwm-layout--iconic-state-p)
                (and exwm--floating-frame
                     (eq 4294967295. exwm--desktop)))
      (exwm--log "Hide #x%x" id)
      (when exwm--floating-frame
        (let* ((container (frame-parameter exwm--floating-frame
                                           'exwm-container))
               (geometry (xcb:+request-unchecked+reply exwm--connection
                             (make-instance 'xcb:GetGeometry
                                            :drawable container))))
          (setq exwm--floating-frame-position
                (vector (slot-value geometry 'x) (slot-value geometry 'y)))
          (exwm--set-geometry container exwm-layout--floating-hidden-position
                              exwm-layout--floating-hidden-position
                              1
                              1)))
      (xcb:+request exwm--connection
          (make-instance 'xcb:ChangeWindowAttributes
                         :window id :value-mask xcb:CW:EventMask
                         :event-mask xcb:EventMask:NoEvent))
      (xcb:+request exwm--connection
          (make-instance 'xcb:UnmapWindow :window id))
      (xcb:+request exwm--connection
          (make-instance 'xcb:ChangeWindowAttributes
                         :window id :value-mask xcb:CW:EventMask
                         :event-mask (exwm--get-client-event-mask)))
      (exwm-layout--set-state id xcb:icccm:WM_STATE:IconicState)
      ;; Cumment that fix Chrome being unfocused
      ;; (cl-pushnew xcb:Atom:_NET_WM_STATE_HIDDEN exwm--ewmh-state)
      (exwm-layout--set-ewmh-state id)
      (exwm-layout--auto-iconify)
      (xcb:flush exwm--connection))))

(defun screen-lock ()
  (interactive)
  (shell-command "i3lock -t -i /etc/nixos/resources/desktop.png"))

(defun monitor-external-disable ()
  (interactive)
  (shell-command "xrandr --output eDP-1 --primary --auto --output DP-1-1-8 --off")
  (message "Disable external monitor"))

(defun monitor-external-enable ()
  (interactive)
  (shell-command "xrandr --output eDP-1 --off --output DP-1-1-8 --auto --primary")
  (message "Enable external monitor"))

;; (defun pulseaudio-ctl (cmd)
;;   (shell-command (concat "pulseaudio-ctl " cmd))
;;   (message "Volume command: %s" cmd))

(defun volume-mute ()
  (interactive) (shell-command "pactl set-sink-mute \"alsa_output.pci-0000_00_1f.3.analog-stereo\" toggle")
  (message "Speakers mute toggled"))

(defun volume-up ()
  (interactive) (shell-command "pactl set-sink-volume \"alsa_output.pci-0000_00_1f.3.analog-stereo\" +5%")
  (message "Speakers volume up"))

(defun volume-down ()
  (interactive) (shell-command "pactl set-sink-volume \"alsa_output.pci-0000_00_1f.3.analog-stereo\" -5%")
  (message "Speakers volume down"))

;; (defun brightness-up ()
;;   (interactive)
;;   (shell-command "exec light -A 10")
;;   (message "Brightness increased"))

;; (defun brightness-down ()
;;   (interactive)
;;   (shell-command "exec light -U 10")
;;   (message "Brightness decreased"))

;; ;; Monitor functions
;; (setq monitor-current (alist-get 'name (frame-monitor-attributes)))
;; (setq monitor-list (mapcar
;;                     (lambda (arg) (alist-get 'name arg))
;;                     (display-monitor-attributes-list)))
;; (setq monitor-primary "eDP-1")
;; (setq monitor-external "DP-1-1-8")

;; (defun workspace-move (display)
;;   (plist-put exwm-randr-workspace-output-plist
;;              exwm-workspace-current-index
;;              display)
;;   (exwm-randr--refresh))

;; (defun workspace-move-to-primary ()
;;   (interactive)
;;   (workspace-move monitor-primary))

;; (defun workspace-move-to-external ()
;;   (interactive)
;;   (workspace-move monitor-external))

;; ;;-----------------------------------------------------------
;; ;; EXWM Configuration
;; ;;-----------------------------------------------------------

;; Set 10 workspaces
(setq exwm-workspace-number 10)
;; 's-N': Switch to certain workspace, but switch back to the previous
;; one when tapping twice (emulates i3's `back_and_forth' feature)
(defvar *exwm-workspace-from-to* '(-1 . -1))
(defun exwm-workspace-switch-back-and-forth (target-idx)
  ;; If the current workspace is the one we last jumped to, and we are
  ;; asked to jump to it again, set the target back to the previous
  ;; one.
  (when (and (eq exwm-workspace-current-index (cdr *exwm-workspace-from-to*))
             (eq target-idx exwm-workspace-current-index))
    (setq target-idx (car *exwm-workspace-from-to*)))

  (setq *exwm-workspace-from-to*
        (cons exwm-workspace-current-index target-idx))

  (exwm-workspace-switch-create target-idx))

;; Provide a binding for jumping to a buffer on a workspace.
(defun exwm-jump-to-buffer ()
  "Jump to a workspace on which the target buffer is displayed."
  (interactive)
  (let ((exwm-layout-show-all-buffers nil)
        (initial exwm-workspace-current-index))
    (call-interactively #'exwm-workspace-switch-to-buffer)
    ;; After jumping, update the back-and-forth list like on a direct
    ;; index jump.
    (when (not (eq initial exwm-workspace-current-index))
      (setq *exwm-workspace-from-to*
            (cons initial exwm-workspace-current-index)))))

;; Buffer names equal to xwindow class name
(defun exwm-rename-buffer ()
  (interactive)
  (exwm-workspace-rename-buffer exwm-class-name))
(add-hook 'exwm-update-class-hook 'exwm-rename-buffer)

;; ;; Show tiny fringes
;; (fringe-mode 5)

;; Show system tray
(exwm-systemtray-enable)

;; ;; Keyboard layout per window
;; (exwm-xim-enable)

(add-hook 'exwm-floating-setup-hook #'exwm-layout-show-mode-line)
;; (add-hook 'exwm-floating-exit-hook 'exwm-layout-show-mode-line)

;; (add-hook 'exwm-init-hook 'monitor-external-enable)

(display-battery-mode)
(setq display-time-format "%a %H:%M")
(display-time-mode 1)

(defcustom exwm-workspace-mode-line-format
  `("["
    (:propertize (:eval (format "WS-%d" exwm-workspace-current-index))
                 face bold
                 mouse-face mode-line-highlight)
    "]")
  "EXWM workspace in the mode line."
  :type 'sexp)

(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(add-to-list 'mode-line-misc-info exwm-workspace-mode-line-format t)
;; ;;-----------------------------------------------------------
;; ;; EXWM Bindings
;; ;;-----------------------------------------------------------

;; (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

;; ;; Emacs emulation for xwindows
;; (setq exwm-input-simulation-keys
;;       '((,(kbd "C-b") . [left])
;;         (,(kbd "C-f") . [right])
;;         (,(kbd "C-p") . [up])
;;         (,(kbd "C-n") . [down])
;;         (,(kbd "C-a") . [home])
;;         (,(kbd "C-e") . [end])
;;         (,(kbd "C-d") . [delete])
;;         (,(kbd "C-y") . ?\C-v)
;;         (,(kbd "M-w") . ?\C-c)))

;; Global EXWM keybindings
(setq exwm-input-global-keys
        ;; Utilities
      `((,(kbd "s-r")                     . exwm-reset)
        (,(kbd "s-w")                     . exwm-workspace-switch)
        (,(kbd "s-f")                     . toggle-maximize-buffer)
        (,(kbd "s-d")                     . counsel-linux-app)
        (,(kbd "s-L")                     . screen-lock)
        (,(kbd "<print>")                 . screenshot)
        (,(kbd "s-<return>")              . vterm-toggle)
        (,(kbd "s-i")                     . exwm-input-toggle-keyboard)
        (,(kbd "s-j")                     . exwm-jump-to-buffer)
        
        ;; External monitor
        (,(kbd "s-m <up>")                . monitor-external-enable)
        (,(kbd "s-m <down>")              . monitor-external-disable)
        (,(kbd "s-m S-<up>")              . workspace-move-to-external)
        (,(kbd "s-m S-<down>")            . workspace-move-to-primary)

        ;; Switch focus
        (,(kbd "s-<left>")                . windmove-left)
        (,(kbd "s-<right>")               . windmove-right)
        (,(kbd "s-<down>")                . windmove-down)
        (,(kbd "s-<up>")                  . windmove-up)

        ;; Move buffers
        (,(kbd "s-S <up>")                . buf-move-up)
        (,(kbd "s-S <down>")              . buf-move-down)
        (,(kbd "s-S <left>")              . buf-move-left)
        (,(kbd "s-S <right>")             . buf-move-right)

        ;; Resize buffers
        (,(kbd "C-M-<left>")              . shrink-window-horizontally)
        (,(kbd "C-M-<right>")             . enlarge-window-horizontally)
        (,(kbd "C-M-<up>")                . shrink-window)
        (,(kbd "C-M-<down>")              . enlarge-window)

        ;; Media control
        (,(kbd "<XF86AudioMute>")         . volume-mute)
        (,(kbd "<XF86AudioRaiseVolume>")  . volume-up)
        (,(kbd "<XF86AudioLowerVolume>")  . volume-down)
        (,(kbd "<XF86MonBrightnessDown>") . brightness-down)
        (,(kbd "<XF86MonBrightnessUp>")   . brightness-up)
        
        ;; ;; Switch window by s-o N
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "M-%d" i)) .
                      (lambda ()
                        (interactive)
                        (winum-select-window-by-number ,i))))
                  (number-sequence 0 9))

        ;; Switch to workspace by s-N (lambda (i)
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-back-and-forth ,i))))
                  (number-sequence 1 9))))

;; Enable EXWM
(exwm-enable)

;; Randr config
(setq exwm-randr-workspace-monitor-plist
  '(0 "eDP-1" 1 "DP-1-1-8"))
(exwm-randr-enable)

;; First workspace is the default one
(exwm-workspace-switch-create 1)

(exwm-randr-refresh)

(provide 'desktop)
