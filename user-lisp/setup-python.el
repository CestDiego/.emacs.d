(add-hook 'after-init-hook #'global-flycheck-mode)

(requirepyenv 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location '("~/.virtualenvs/"))
(provide 'setup-python)
