;; change command to meta, and ignore option to use weird Norwegian keyboard
(setq mac-option-modifier nil)
(setq mac-command-modifier 'meta)
(setq ns-function-modifier nil)

;; Move to trash when deleting stuff
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash/emacs")

(provide 'mac)
