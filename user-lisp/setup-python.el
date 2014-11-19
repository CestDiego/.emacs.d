(setq python-check-command "flake8")
(add-hook 'after-init-hook #'global-flycheck-mode)

(elpy-enable)
(require 'jedi)
(setq jedi:setup-keys t)
(define-key jedi-mode-map (kbd "C-c <C-tab>") 'jedi:complete)
(define-key jedi-mode-map (kbd "<C-tab>") nil)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)

(add-hook 'python-hook (electric-indent-mode 0))

(provide 'setup-python)
