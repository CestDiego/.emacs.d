(require 'cider)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; Indent and highlight more commands
(put-clojure-indent 'match 'defun)

(setq nrepl-hide-special-buffers t)
(setq cider-repl-tab-command 'indent-for-tab-command)

(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-popup-stacktraces nil)
(setq cider-repl-popup-stacktraces t)
(setq cider-auto-select-error-buffer t)
(setq cider-repl-history-file "~/.emacs.d/cider-history")
(setq cider-repl-wrap-history t)

(provide 'setup-cider)
