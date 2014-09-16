(add-hook 'yaml-mode-hook 'ansible-doc-mode)
(add-hook 'yaml-mode-hook '(lambda () (ansible 1)))
(provide 'setup-yaml)
