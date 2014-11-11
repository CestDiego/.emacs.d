
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist '(("django" . "\\.html\\'")))

(when (require 'web-mode nil t)
  (setq web-mode-markup-indent-offset 2)
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.eex\\'" . web-mode))
  (define-key web-mode-map (kbd "C-;") nil)
  )
;; less-css-mode
(when (require 'less-css-mode nil t)
  (add-to-list 'ac-modes 'less-css-mode)
  (add-hook 'less-css-mode-hook 'ac-css-mode-setup))

;; emmet-mode
(when (require 'emmet-mode nil t)
  (add-hook 'html-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode))

;; rainbow-mode
(when (require 'rainbow-mode nil t)
  (add-hook 'css-mode-hook 'rainbow-mode)
  (add-hook 'scss-mode-hook 'rainbow-mode)
  )

;; (require 'grunt)
;; (add-hook 'web-ode-hook (lambda () (local-set-key (kbd "C-M-g") 'grunt-exec)))

(provide 'setup-html)
