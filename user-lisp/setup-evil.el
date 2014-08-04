(require 'evil)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'evil-visualstar)

(evil-mode 1)

;; Evil Numbers are evil
(define-key evil-normal-state-map (kbd "C-+") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C--") 'evil-numbers/dec-at-pt)

;; Add Evil mode
(global-set-key (kbd "C-s-;") 'ace-jump-word-mode)
(define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-word-mode)
(define-key evil-operator-state-map (kbd "SPC") #'evil-ace-jump-word-mode)



;; these modes are clear from evil
(add-hook 'term-mode-hook 'evil-emacs-state)
(add-hook 'prodigy-mode-hook 'evil-emacs-state)
(add-hook 'cider-repl-mode-hook 'evil-emacs-state)

(provide 'setup-evil)
