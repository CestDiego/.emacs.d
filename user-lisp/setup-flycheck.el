(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-hook 'python-mode-hook 'flycheck-mode)

(provide 'setup-flycheck)
