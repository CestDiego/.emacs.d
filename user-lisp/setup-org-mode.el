(setq org-directory "~/Documents/Org-Notes")

;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)

(setq org-startup-indented t)
;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)
(setq org-replace-disputed-keys t)

(setq org-hide-leading-stars t)
(setq org-odd-levels-only t)

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; TODO progress logging stuff
(setq org-log-done 'time)

;; Org-Bullets enabled by default!!
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Perspective is more important
(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map [(control tab)] nil)))

(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
          (lambda ()
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))

(setq org-src-preserve-indentation t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (gnuplot . t)
   (C . t)
   (mongo . t)
   (sh . t)))

;; REVEAL MODE YEAHH!!
(require 'ox-reveal)
;; (setq  org-reveal-root "http://cdn.jsdelivr.net/reveal.js/2.5.0/")
(setq org-reveal-root (expand-file-name "site-misc/reveal.js" user-emacs-directory))


;; Org-Notify
;; (require 'org-notify)
;; (org-notify-start)

;; (org-notify-add 'appt
;;                 '(:time "-1s" :period "20s" :duration 10
;;                         :actions (-message -ding))
;;                 '(:time "15m" :period "2m" :duration 100
;;                         :actions -notify)
;;                 '(:time "2h"  :period "5m" :actions -message)
;;                 '(:time "3d"  :actions -email))


;; Org MIME to Send HTML MAILS!
(require 'org-mime)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "gtd.org" "Tasks")
         "* TODO %?\n %i\n")
        ("i" "For jotting quick ideas" entry (file+headline "gtd.org" "Ideas")
         "* %?\n %i\n%t\n%A")
        ("b" "Bookmark links" entry (file+headline "links.org" "Bookmarks")
         "* %?%^g")
        ("m" "Movies to see" entry (file "movies.org")
         "* ToDownload %? \n  :PROPERTIES:\n  :DATE: %t\n  :URL: %c\n  :END:")
        ("l" "Temp Links from the interwebs" item (file+headline "links.org" "Temporary Links")
         "%?\nEntered on %U\n \%i\n %a")
        ("w" "Weight Log" table-line (file+headline "weight.org" "Diario de Peso") " | %? | %t |")))

(require 'org-repo-todo)
(global-set-key (kbd "C-c ;") 'ort/capture-todo)
(global-set-key (kbd "C-c '") 'ort/goto-todos)

(add-hook 'prog-mode-hook (lambda ()
                            (font-lock-add-keywords nil
                                                    '(("\\<\\(FIXME\\|TODO\\|BUG\\):"
                                                       1 font-lock-warning-face prepend)))))

;; TODO: holi

(setq org-mime-library 'mml)
;; The following key bindings are suggested, which bind the C-c M-o
;; key sequence to the appropriate org-mime function in both email and
;; Org-mode buffers.
(add-hook 'message-mode-hook
          (lambda ()
            (local-set-key "\C-c\M-o" 'org-mime-htmlize)))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\C-c\M-o" 'org-mime-org-buffer-htmlize)))

(custom-set-faces
 '(org-done ((t (:foreground "PaleGreen"
                             :weight normal
                             :strike-through t))))
 '(org-headline-done
   ((((class color) (min-colors 16) (background dark))
     (:foreground "LightSalmon" :strike-through t)))))

(provide 'setup-org-mode)
