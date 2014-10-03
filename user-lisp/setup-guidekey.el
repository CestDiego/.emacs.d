(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x p" "C-c p" "C-h" "C-x r" "C-x v"))
(setq guide-key/idle-delay 0.1)
(setq guide-key/recursive-key-sequence-flag t)
(guide-key-mode 1)

(provide 'setup-guidekey)
