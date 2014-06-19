(require 'evil)
(evil-mode 1)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'evil-visualstar)

;; Evil Numbers are evil
(define-key evil-normal-state-map (kbd "C-+") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C--") 'evil-numbers/dec-at-pt)

;; these modes are clear from evil
(add-hook 'term-mode-hook 'evil-emacs-state)
(add-hook 'prodigy-mode-hook 'evil-emacs-state)
(add-hook 'cider-repl-mode-hook 'evil-emacs-state)

(provide 'setup-evil)
