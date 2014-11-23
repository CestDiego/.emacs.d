(require 'company)

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)
(setq company-show-numbers t)
(setq company-tooltip-limit 20)
(setq company-dabbrev-downcase nil)
(setq company-dabbrev-ignore-case t)

;; (add-hook 'js-mode-hook
;;           (lambda ()
;;             (set (make-local-variable 'company-backends)
;;                  '((company-dabbrev-code company-yasnippet)))))
(global-set-key (kbd "C-c y") 'company-yasnippet)

(add-to-list 'company-backends 'company-tern)

(push 'company-readline company-backends)
(add-hook 'rlc-no-readline-hook (lambda () (company-mode -1)))

;; global activation of the unicode symbol completion
(add-to-list 'company-backend 'company-math-symbols-unicode)

(add-hook 'rlc-no-readline-hook (lambda () (company-mode -1)))

;; If you don't like circles after object's own properties consider less
;; annoying marker for that purpose.

;; (setq company-tern-property-marker "")

;; You can trim too long function signatures to the frame width.

;; (setq company-tern-meta-as-single-line t)

;; If you doesn't like inline argument annotations appear with
;; corresponding identifiers, then you can to set up the company align
;; option.

(setq company-tooltip-align-annotations t)
(setq company-global-modes
      '(not eshell-mode comint-mode org-mode))

(add-hook 'after-init-hook 'global-company-mode)

;; (defun check-expansion ()
;;   (save-excursion
;;     (if (looking-at "\\_>") t
;;       (backward-char 1)
;;       (if (looking-at "\\.") t
;;         (backward-char 1)
;;         (if (looking-at "->") t nil)))))

;; (defun do-yas-expand ()
;;   (let ((yas/fallback-behavior 'return-nil))
;;     (yas/expand)))

;; (defun tab-indent-or-complete ()
;;   (interactive)
;;   (if (minibufferp)
;;       (minibuffer-complete)
;;     (if (or (not yas/minor-mode)
;;            (null (do-yas-expand)))
;;         (if (check-expansion)
;;             (company-complete-common)
;;           (indent-for-tab-command)))))


;; (define-key prog-mode-map [tab] 'tab-indent-or-complete)


(provide 'setup-company)
