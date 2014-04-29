(require 'evil)
(evil-mode 1)

(require 'surround)
(global-surround-mode 1)

(require 'evil-visualstar)

;; these modes are clear from evil
(add-hook 'term-mode-hook 'evil-emacs-state)
(add-hook 'prodigy-mode-hook 'evil-emacs-state)

(provide 'setup-evil)
