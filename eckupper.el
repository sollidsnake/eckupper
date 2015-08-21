;;; eckupper starts here

(provide 'eckupper)

(defvar eckupper:backup-directory
  (concat "/home/" user-login-name "/" ".emacsbk/"))

(defvar eckupper:date-format "%Y%m%d_%H%M%S")

(defun eckupper:get-current-date ()
  (replace-regexp-in-string "\n$" "" (shell-command-to-string (concat "date +\"" eckupper:date-format "\""))))

(defun eckupper:make-backup ()
  "Make backup of current file, saving to the destination specified in eckupper:backup-directory"

  (setq file-name-wo/extension
        (replace-regexp-in-string "/" "%" buffer-file-name))
  (setq file-backup-name
        (concat file-name-wo/extension
                "__" (eckupper:get-current-date) ".bak" ))
  
  (when (file-exists-p buffer-file-name)
    (shell-command
     (concat "cp \"" buffer-file-name "\" \"" eckupper:backup-directory "/" file-backup-name "\""))))

(add-hook 'before-save-hook 'eckupper:make-backup)

;;; eckupper ends here
