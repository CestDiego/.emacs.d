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

(define-key global-map (kbd "C-s-<") 'evil-window-decrease-width)
(define-key global-map (kbd "C-s->") 'evil-window-increase-width)

(define-key global-map (kbd "C-s-+") 'evil-window-decrease-height)
(define-key global-map (kbd "C-s--") 'evil-window-increase-height)


;; Add Evil mode
(global-set-key (kbd "C-M-;") 'ace-jump-word-mode)
;; (define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-word-mode)
;; (define-key evil-operator-state-map (kbd "SPC") #'evil-ace-jump-word-mode)

;; All EVIL needs a LEADER
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "v" 'visual-line-mode
  "s" 'sudo-edit
  "0" 'delete-window
  "g" 'magit-status
  "j"  '(lambda nil (interactive) (split-window-vertically) (other-window 1))
  "l"  '(lambda nil (interactive) (split-window-horizontally) (other-window 1))
  "o" 'other-window
  "<SPC>" 'dired-jump)


(evil-leader/set-key
  "p" 'helm-projectile
  "f" 'helm-projectile-find-file
  "r" 'helm-recentf
  "b" 'helm-buffers-list
  "k" 'kill-buffer)

(if (featurep 'expand-region)
    (progn
      (setq expand-region-contract-key "z")
      (evil-leader/set-key "x" 'er/expand-region)))

;; these modes are clear from evil
(add-hook 'term-mode-hook 'evil-emacs-state)
(add-hook 'prodigy-mode-hook 'evil-emacs-state)
(add-hook 'cider-repl-mode-hook 'evil-emacs-state)

(add-hook 'rcirc-mode-hook 'evil-insert-state)
(add-hook 'git-commit-mode-hook 'evil-insert-state)

(provide 'setup-evil)
