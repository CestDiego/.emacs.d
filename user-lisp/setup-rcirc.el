;; You can autoload, but at the end of this block we'll
;; connect to two networks anyway.
(require 'rcirc)
(require 'epa-file)
;; Change user info
(setq rcirc-default-nick "cestdiego")
(setq rcirc-default-user-name "cestdiego")
(setq rcirc-default-full-name "Diego Berrocal")


;; (require 'secrets)
;; (setq freenode-passwd (concat znc-user "/freenode:" znc-password ))
;; (setq geekshed-passwd (concat znc-user "/geekshed:" znc-password ))
;; (setq rcirc-server-alist
;;       '(("freenode.berrocal.me"
;;          :nick "cestdiego"
;;          :channels '("#limajs" "#emacs" "#haskell" )
;;          :password freenode-passwd )
;;         ("geekshed.berrocal.me"
;;          :nick "cestdiego"
;;          :channels '("#jupiterbroadcasting")
;;          :password geekshed-passwd ))

;; Join these channels at startup.

;; OLD SCHOOL RCIRC
;; ----------------- START ------------------

;; Join these channels at startup.
;; (setq rcirc-server-alist
;;       '(
;;         ("hackspace.irc.slack.com" :channels ("#emacs"))
;;         ("irc.geekshed.net" :channels ("#jupiterbroadcasting"))
;;         ("irc.freenode.net" :channels ("#limajs #emacs #rcirc #haskell"))))


;;Old school authinfo ;_;
;; (setq rcirc-authinfo
;;       '(("geekshed" nickserv "cestdiego" "password")
;;         ("freenode" nickserv "cestdiego" "password")))

;;       (defadvice rcirc (before rcirc-read-from-authinfo activate)
;;         "Allow rcirc to read authinfo from ~/.authinfo.gpg via the auth-source API.
;; This doesn't support the chanserv auth method"
;;         (unless arg
;;           (dolist (p (auth-source-search :port '("nickserv" "bitlbee" "quakenet")
;;                                          :require '(:port :user :secret)))
;;             (let ((secret (plist-get p :secret))
;;                   (method (intern (plist-get p :port))))
;;               (add-to-list 'rcirc-authinfo
;;                            (list (plist-get p :host)
;;                                  method
;;                                  (plist-get p :user)
;;                                  (if (functionp secret)
;;                                      (funcall secret)
;;                                    secret)))))))

;; ----------------- END ------------------

(defun rcirc-detach-buffer ()
  (interactive)
  (let ((buffer (current-buffer)))
    (when (and (rcirc-buffer-process)
             (eq (process-status (rcirc-buffer-process)) 'open))
      (with-rcirc-server-buffer
        (setq rcirc-buffer-alist
              (rassq-delete-all buffer rcirc-buffer-alist)))
      (rcirc-update-short-buffer-names)
      (if (rcirc-channel-p rcirc-target)
          (rcirc-send-strng (rcirc-buffer-process)
                            (concat "DETACH " rcirc-target))))
    (setq rcirc-target nil)
    (kill-buffer buffer)))

(define-key rcirc-mode-map [(control c) (control d)] 'rcirc-detach-buffer)

(setq rcirc-omit-responses '("JOIN" "PART" "QUIT" "NICK" "AWAY" "MODE"))

;; Adjust the colours of one of the faces.
(set-face-foreground 'rcirc-my-nick "#b0e060" nil)

;; Include date in time stamp.
(setq rcirc-time-format "%Y-%m-%d %H:%M ")



(defun rcirc-notify-send-popup (process sender response target text)
  (let ((nick (rcirc-nick process)))
    (when (and (string-match (regexp-quote nick) text)
             (not (string= nick sender))
             (not (string= (rcirc-server-name process) sender)))
      (notify-send-popup sender text))))

(add-hook 'rcirc-print-functions 'rcirc-notify-send-popup)


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

(add-hook 'rcirc-mode-hook '(lambda ()
                              ;; Turn on spell checking.
                              (flyspell-mode 1)
                              (rcirc-omit-mode)
                              (smartparens-mode 0)
                              (set-input-method "latin-1-prefix")
                              ;; Keep input line at bottom.
                              (set (make-local-variable 'scroll-conservatively)
                                   8192)
                              (rcirc-reconnect-mode 1)) )

(provide 'setup-rcirc)
