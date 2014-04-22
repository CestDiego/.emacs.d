;; taken from http://paralambda.org/2012/07/02/using-gnu-emacs-as-a-terminal-emulator/

(require 'multi-term)
(setq multi-term-dedicated-select-after-open-p t)

(when (require 'term nil t) ; only if term can be loaded..
  (setq term-bind-key-alist
        (list (cons "C-c C-c" 'term-interrupt-subjob)
              (cons "C-p" 'previous-line)
              (cons "C-n" 'next-line)
              (cons "M-f" 'term-send-forward-word)
              (cons "M-b" 'term-send-backward-word)
              (cons "C-c C-j" 'term-line-mode)
              (cons "C-c C-k" 'term-char-mode)
              (cons "M-DEL" 'term-send-backward-kill-word)
              (cons "M-d" 'term-send-forward-kill-word)
              (cons "<C-left>" 'term-send-backward-word)
              (cons "<C-right>" 'term-send-forward-word)
              (cons "C-r" 'term-send-reverse-search-history)
              (cons "M-p" 'term-send-raw-meta)
              (cons "M-y" 'term-send-raw-meta)
              (cons "C-y" 'term-send-raw))))

(defun term-send-function-key ()
  (interactive)
  (let* ((char last-input-event)
         (output (cdr (assoc char term-function-key-alist))))
    (term-send-raw-string output)))

(defconst term-function-key-alist '((f1 . "\e[OP")
                                    (f2 . "\e[OQ")
                                    (f3 . "\e[OR")
                                    (f4 . "\e[OS")))

(dolist (spec term-function-key-alist)
  (define-key term-raw-map
    (read-kbd-macro (format "<%s>" (car spec)))
    'term-send-function-key))

(provide 'setup-multiterm)
