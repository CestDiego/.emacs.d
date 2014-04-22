(require 'evil)
(evil-mode 1)

(require 'evil-visualstar)

;; fix term keybindings
(add-hook 'term-mode-hook 'evil-emacs-state)
(add-hook 'prodigy-mode-hook 'evil-emacs-state)

(provide 'setup-evil)
