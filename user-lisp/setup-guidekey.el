(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x p" "C-x x" "C-c p" "C-h" "C-x r" "C-c RET" "C-x v" "SPC"))
(add-hook 'web-mode-hook (lambda ()
                           (push guide-key/guide-key-sequence ("C-c C-e"))))
(setq guide-key/idle-delay 0.25)
(setq guide-key/recursive-key-sequence-flag t)
(guide-key-mode 1)

(provide 'setup-guidekey)
