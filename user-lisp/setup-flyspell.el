;; brew install hunspell
;; download dictionaries from http://archive.services.openoffice.org/pub/mirror/OpenOffice.org/contrib/dictionaries/
;; copy them to ~/Library/Spelling/

(setq ispell-program-name "hunspell")
(setq ispell-dictionary "english")

(let ((langs '("english" "castellano")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))

(defun cycle-ispell-languages ()
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

(add-hook 'prog-mode-hook
          (lambda ()
            (flyspell-prog-mode)))

(provide 'setup-flyspell)
