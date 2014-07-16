(require 'yasnippet)
(yas-global-mode 1)
(add-hook 'term-mode-hook (lambda()
                            (setq yas-dont-activate t)))
(setq yas-snippet-dirs '("~/.emacs.d/snippets"
                           "~/Downloads/interesting-snippets"))
(provide 'setup-yasnippet)
