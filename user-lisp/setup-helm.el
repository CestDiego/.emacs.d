(require 'helm-config)
(require 'helm-projectile)

(setq helm-ff-transformer-show-only-basename nil)

;; sauce: http://stackoverflow.com/questions/19283368/how-can-i-open-quickly-a-file-in-emacs
;; you'll need to require helm-config and helm-projectile somewhere above
(defun helm-overlord (&rest arg)
  ;; just in case someone decides to pass an argument, helm-omni won't fail.
  (interactive)
  (helm-other-buffer
   (append ;; projectile errors out if you're not in a project 
    '(helm-c-source-buffers-list) ;; list of all open buffers
    (if (projectile-project-p) ;; so look before you leap
        '(helm-source-projectile-buffers-list
          helm-source-projectile-recentf-list
          helm-source-projectile-files-list)
      '(helm-c-source-recentf    ;; all recent files
        helm-c-source-files-in-current-dir)) ;; files in current directory
    '(helm-c-source-bookmarks            ;; bookmarks too
      helm-c-source-buffer-not-found))     ;; ask to create a buffer otherwise
   "*all-seeing-eye*"))

(provide 'setup-helm)
