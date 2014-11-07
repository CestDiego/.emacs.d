(require 'company)

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)
(setq company-show-numbers t)
(setq company-tooltip-limit 20)
(setq company-dabbrev-downcase nil)
(setq company-dabbrev-ignore-case t)

(add-hook 'js-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 '((company-dabbrev-code company-yasnippet)))))


(add-to-list 'company-backends 'company-tern)

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

(provide 'setup-company)
