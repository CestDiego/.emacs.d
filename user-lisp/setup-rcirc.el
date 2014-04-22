;; You can autoload, but at the end of this block we'll
;; connect to two networks anyway.
(require 'rcirc)

(setq rcirc-omit-responses '("JOIN" "PART" "QUIT" "NICK" "AWAY" "MODE"))

;; Adjust the colours of one of the faces.
(set-face-foreground 'rcirc-my-nick "blue" nil)

;; Include date in time stamp.
(setq rcirc-time-format "%Y-%m-%d %H:%M ")

;; Change user info
(setq rcirc-default-nick "ppold")
(setq rcirc-default-user-name "ppold")
(setq rcirc-default-full-name "Giorgio Leveroni")

;; Join these channels at startup.
(setq rcirc-server-alist
      '(("irc.freenode.net" :channels ("#limajs"))))

(defadvice rcirc (before rcirc-read-from-authinfo activate)
  "Allow rcirc to read authinfo from ~/.authinfo.gpg via the auth-source API.
This doesn't support the chanserv auth method"
  (unless arg
    (dolist (p (auth-source-search :port '("nickserv" "bitlbee" "quakenet")
                                   :require '(:port :user :secret)))
      (let ((secret (plist-get p :secret))
            (method (intern (plist-get p :port))))
        (add-to-list 'rcirc-authinfo
                     (list (plist-get p :host)
                           method
                           (plist-get p :user)
                           (if (functionp secret)
                               (funcall secret)
                             secret)))))))

;;;; Auto reconnect
;;;; Taken from http://www.emacswiki.org/emacs/rcircReconnect
(defun-rcirc-command reconnect (arg)
  "Reconnect the server process."
  (interactive "i")
  (if (buffer-live-p rcirc-server-buffer)
      (with-current-buffer rcirc-server-buffer
        (let ((reconnect-buffer (current-buffer))
              (server (or rcirc-server rcirc-default-server))
              (port (if (boundp 'rcirc-port) rcirc-port rcirc-default-port))
              (nick (or rcirc-nick rcirc-default-nick))
              channels)
          (dolist (buf (buffer-list))
            (with-current-buffer buf
              (when (equal reconnect-buffer rcirc-server-buffer)
                (remove-hook 'change-major-mode-hook
                             'rcirc-change-major-mode-hook)
                (let ((server-plist (cdr (assoc-string server rcirc-server-alist))))
                  (when server-plist
                    (setq channels (plist-get server-plist :channels))))
                  )))
          (if process (delete-process process))
          (rcirc-connect server port nick
                         nil
                         nil
                         channels)))))

;;; Attempt reconnection at increasing intervals when a connection is
;;; lost.

(defvar rcirc-reconnect-attempts 0)

;;;###autoload
(define-minor-mode rcirc-reconnect-mode
  nil
  nil
  " Auto-Reconnect"
  nil
  (if rcirc-reconnect-mode
      (progn
        (make-local-variable 'rcirc-reconnect-attempts)
        (add-hook 'rcirc-sentinel-hooks
                  'rcirc-reconnect-schedule nil t))
    (remove-hook 'rcirc-sentinel-hooks
                 'rcirc-reconnect-schedule t)))

(defun rcirc-reconnect-schedule (process &optional sentinel seconds)
  (condition-case err
      (when (and (eq 'closed (process-status process))
                 (buffer-live-p (process-buffer process)))
        (with-rcirc-process-buffer process
          (unless seconds
            (setq seconds (exp (1+ rcirc-reconnect-attempts))))
          (rcirc-print
           process "my-rcirc.el" "ERROR" rcirc-target
           (format "scheduling reconnection attempt in %s second(s)." seconds) t)
          (run-with-timer
           seconds
           nil
           'rcirc-reconnect-perform-reconnect
           process)))
    (error
     (rcirc-print process "RCIRC" "ERROR" nil
                  (format "%S" err) t)))
)

(defun rcirc-reconnect-perform-reconnect (process)
  (when (and (eq 'closed (process-status process))
             (buffer-live-p (process-buffer process))
             )
    (with-rcirc-process-buffer process
      (when rcirc-reconnect-mode
        (if (get-buffer-process (process-buffer process))
            ;; user reconnected manually
            (setq rcirc-reconnect-attempts 0)
          (let ((msg (format "attempting reconnect to %s..."
                             (process-name process)
                             )))
            (rcirc-print process "my-rcirc.el" "ERROR" rcirc-target
                         msg t))
          ;; remove the prompt from buffers
          (condition-case err
              (progn
                (save-window-excursion
                  (save-excursion
                    (rcirc-cmd-reconnect nil)))
                (setq rcirc-reconnect-attempts 0))
            ((quit error)
             (incf rcirc-reconnect-attempts)
             (rcirc-print process "my-rcirc.el" "ERROR" rcirc-target
                          (format "reconnection attempt failed: %s" err)  t)
             (rcirc-reconnect-schedule process))))))))

(add-hook 'rcirc-mode-hook (lambda ()
                             ;; Turn on spell checking.
                             (flyspell-mode 1)
                             (rcirc-omit-mode)
                             (rcirc-track-minor-mode 1)
                             ;; Keep input line at bottom.
                             (set (make-local-variable 'scroll-conservatively)
                                  8192)
                             (rcirc-reconnect-mode 1)))

(require 'erc-terminal-notifier)
(defun rcirc-osx-notify (process sender response target text)
  (let ((nick (rcirc-nick process)))
    (when (and (string-match (regexp-quote nick) text)
               (not (string= nick sender))
               (not (string= (rcirc-server-name process) sender)))
      (erc-terminal-notifier-notify sender text))))
(add-hook 'rcirc-print-functions 'rcirc-osx-notify)

(provide 'setup-rcirc)
