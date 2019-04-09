(defun installable-packages (pkg-list)
  "Filter out not-yet installed packages from package list."
  (seq-filter (lambda (p) (not (package-installed-p p))) pkg-list))

(defun utils-install-packages (pkg-list)
  (let ((to-install (installable-packages pkg-list)))
    (if (< 0 (length to-install))
        (progn (package-refresh-contents)
               (mapcar #'package-install to-install))
      (message "No new packages to install."))))

(provide 'utils)
