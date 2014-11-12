(require 'helm-config)
(require 'helm-projectile)

(setq 
 helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
 helm-quick-update t ; do not display invisible candidates
 helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.
 helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window
 helm-candidate-number-limit 500 ; limit the number of displayed canidates
 helm-ff-file-name-history-use-recentf t
 helm-buffers-fuzzy-matching t 
 helm-case-fold-search 'smart 
 helm-ff-transformer-show-only-basename nil)

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

(add-hook 'javascript-mode-hook (lambda () (setq-local helm-dash-docsets '("JavaScript"
                                                                      "BackboneJS"
                                                                      "UnderscoreJS"
                                                                      ))))
;; (add-hook 'python-mode-hook (lambda () (setq-local helm-dash-docsets '("Python_2"))))

(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)


(setq helm-github-stars-username "cestdiego")

(require 'helm-flycheck) ;; Not necessary if using ELPA package
(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))


(helm-projectile-on)
(provide 'setup-helm)
