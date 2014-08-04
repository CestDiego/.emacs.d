(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(require 'w3m-load)

(defun w3m-browse-url-other-window (url &optional newwin)
  (interactive
   (browse-url-interactive-arg "w3m URL: "))
  (let ((pop-up-frames nil))
    (switch-to-buffer-other-window
     (w3m-get-buffer-create "*w3m*"))
    (w3m-browse-url url)))

(setq browse-url-browser-function
      '(("hyperspec" . w3m-browse-url-other-window)
        ("." . browse-url-default-browser)))

(setq w3m-use-cookies t
      w3m-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-input-coding-system 'utf-8
      w3m-output-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)
