;; diff-hl
(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

(provide 'setup-diff-hl)
