(require 'yasnippet)
(add-hook 'term-mode-hook (lambda()
                            (setq yas-dont-activate t)))
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "C-M-<tab>") 'yas-expand)
;; Now with company mode this is great
(define-key yas-minor-mode-map (kbd "TAB") 'yas-expand)

(add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'html-mode)))
(yas-global-mode 1)
(provide 'setup-yasnippet)
