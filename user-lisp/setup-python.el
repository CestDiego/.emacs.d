(elpy-enable)
(setq python-check-command "flake8")
(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'jedi)
(setq jedi:setup-keys t)
(define-key jedi-mode-map (kbd "C-c <C-tab>") 'jedi:complete)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location '("~/.virtualenvs/"))
(provide 'setup-python)
