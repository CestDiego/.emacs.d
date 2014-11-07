;; (require 'auto-complete-config)
;; (ac-config-default)
;; (ac-flyspell-workaround)
;; (ac-set-trigger-key "TAB")

;; ;; Autocomplete for Ispell

;; ;; Completion words longer than 4 characters
;;    (custom-set-variables
;;      '(ac-ispell-requires 4)
;;      '(ac-ispell-fuzzy-limit 4))

;;    (eval-after-load "auto-complete"
;;      '(progn
;;          (ac-ispell-setup)))

;; (add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
;; (add-hook 'mail-mode-hook 'ac-ispell-ac-setupa)
;; (add-hook 'org-mode 'ac-ispell-ac-setup)
;; (provide 'setup-ac-mode)
