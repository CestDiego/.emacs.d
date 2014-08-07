(require 'evil)
(require 'evil-leader)
(require 'evil-surround)

(global-evil-surround-mode 1)

(require 'evil-visualstar)

(global-evil-leader-mode)
(evil-mode 1)


;; Evil Numbers are evil
(define-key evil-normal-state-map (kbd "C-+") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C--") 'evil-numbers/dec-at-pt)

;; Add Evil mode
(global-set-key (kbd "C-M-;") 'ace-jump-word-mode)
;; (define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-word-mode)
;; (define-key evil-operator-state-map (kbd "SPC") #'evil-ace-jump-word-mode)


(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "v" 'visual-line-mode)
(if (featurep 'helm)
    (evil-leader/set-key
      "e" 'helm-find-files
      "b" 'helm-buffer-list)
    (evil-leader/set-key
     "e" 'find-file
     "b" 'switch-to-buffer))
(if (featurep 'expand-region)
    (progn
      (setq expand-region-contract-fast-key "z")
      (evil-leader/set-key "xx" 'er/expand-region)))
(evil-leader/set-key
  "k" 'kill-buffer)


;; these modes are clear from evil
(add-hook 'term-mode-hook 'evil-emacs-state)
(add-hook 'prodigy-mode-hook 'evil-emacs-state)
(add-hook 'cider-repl-mode-hook 'evil-emacs-state)

(provide 'setup-evil)
