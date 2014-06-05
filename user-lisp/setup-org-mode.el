(custom-set-faces
 '(org-done ((t (:foreground "PaleGreen"
                             :weight normal
                             :strike-through t))))
 '(org-headline-done
   ((((class color) (min-colors 16) (background dark))
     (:foreground "LightSalmon" :strike-through t)))))

;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)

;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)
(setq org-replace-disputed-keys t)

(setq org-hide-leading-stars t)
(setq org-odd-levels-only t)

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; TODO progress logging stuff
(setq org-log-done 'time)

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
 '((python . t)))

(provide 'setup-org-mode)
