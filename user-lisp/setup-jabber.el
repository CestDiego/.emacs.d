;; (require 'jabber-autoloads)
;; (require 'auth-source)

;; ;; for best experience install 'gnutls' and 'terminal-notifier'

;; ;; Jabber client configuration
;; (defadvice jabber-connect-all (before jabber-read-from-authinfo)
;;   (let ((auths (auth-source-search :port "xmpp"
;;                                    :require '(:secret))))
;;     (setq jabber-account-list
;;           (mapcar (lambda (account-auth)
;;                     (let ((acc (list (concat (plist-get account-auth :user) "@"
;;                                              (plist-get account-auth :host)))))
;;                       (if (string= (plist-get account-auth :host) "gmail.com")
;;                           (append acc '((:network-server . "talk.google.com")
;;                                         (:connection-type . ssl)))
;;                         acc)))
;;                   auths))))

;; (defadvice jabber-connect-all (after jabber-read-from-authinfo)
;;   (require 'jabber)
;;   (define-key jabber-chat-mode-map [escape]
;;     'my-jabber-chat-delete-or-bury)

;;   (define-key mode-specific-map "jr"
;;     (lambda ()
;;       (interactive)
;;       (switch-to-buffer "*-jabber-*")))

;;   (define-key mode-specific-map "jc"
;;     '(lambda ()
;;        (interactive)
;;        (call-interactively 'jabber-connect)))

;;   (define-key mode-specific-map "jd"
;;     '(lambda ()
;;        (interactive)
;;        (call-interactively 'jabber-disconnect)))

;;   (define-key mode-specific-map "jj"
;;     '(lambda ()
;;        (interactive)
;;        (call-interactively 'jabber-chat-with)))

;;   (define-key mode-specific-map "ja"
;;     '(lambda ()
;;        (interactive)
;;        (jabber-send-presence "away" "" 10)))

;;   (define-key mode-specific-map "jo"
;;     '(lambda ()
;;        (interactive)
;;        (jabber-send-presence "" "" 10)))

;;   (define-key mode-specific-map "jx"
;;     '(lambda ()
;;        (interactive)
;;        (jabber-send-presence "xa" "" 10)))

;;   ;(define-key jabber-chat-mode-map (kbd "RET") 'newline)
;;   ;(define-key jabber-chat-mode-map [C-return] 'jabber-chat-buffer-send)
;; )

;; ;; http://stackoverflow.com/questions/5583413/how-do-i-get-jabber-el-to-not-show-the-user-icons
;; (setq
;;  jabber-show-offline-contacts nil
;;  jabber-roster-line-format " %c %-25n %u %-8s (%r)"
;;  jabber-roster-buffer "*-jabber-*"
;;  jabber-mode-line-mode t
;;  jabber-chat-buffer-format "*-jabber-%n-*"
;;  jabber-avatar-verbose nil
;;  jabber-auto-reconnect t
;;  jabber-vcard-avatars-retrieve nil
;;  jabber-chat-buffer-show-avatar nil
;;  jabber-history-enabled t
;;  jabber-use-global-history nil
;;  jabber-backlog-number 40
;;  jabber-backlog-days 30)

;; (setq jabber-alert-presence-message-function
;;       (lambda (who oldstatus newstatus statustext)
;;         nil))

;; (add-hook 'jabber-chat-mode-hook 'goto-address)

;; (setq jabber-chat-header-line-format
;;       '(" " (:eval (jabber-jid-displayname jabber-chatting-with))
;;         " " (:eval (jabber-jid-resource jabber-chatting-with)) "\t";
;;         (:eval (let ((buddy (jabber-jid-symbol jabber-chatting-with)))
;;                  (propertize
;;                   (or
;;                    (cdr (assoc (get buddy 'show) jabber-presence-strings))
;;                    (get buddy 'show))
;;                   'face
;;                   (or (cdr (assoc (get buddy 'show) jabber-presence-faces))
;;                       'jabber-roster-user-online))))
;;         "\t" (:eval (get (jabber-jid-symbol jabber-chatting-with) 'status))
;;         (:eval (unless (equal "" *jabber-current-show*)
;;                  (concat "\t You're " *jabber-current-show*
;;                          " (" *jabber-current-status* ")")))))

;; (require 'autosmiley)
;; (add-hook 'jabber-chat-mode-hook 'autosmiley-mode)

;; (require 'erc-terminal-notifier)

;; (defun notify-jabber-notify (from buf text proposed-alert)
;;   "(jabber.el hook) Notify of new Jabber chat messages via notify.el"
;;   (when (or jabber-message-alert-same-buffer
;;             (not (memq (selected-window) (get-buffer-window-list buf))))
;;     (if (jabber-muc-sender-p from)
;;         (erc-terminal-notifier-notify (format "(PM) %s"
;;                        (jabber-jid-displayname (jabber-jid-user from)))
;;                (format "%s: %s" (jabber-jid-resource from) text)))
;;       (erc-terminal-notifier-notify (format "%s" (jabber-jid-displayname from))
;;              text)))

;; (add-hook 'jabber-alert-message-hooks 'notify-jabber-notify)

;; (defun jabber-visit-history (jid)
;;   "Visit jabber history with JID in a new buffer.

;; Performs well only for small files.  Expect to wait a few seconds
;; for large histories.  Adapted from `jabber-chat-create-buffer'."
;;   (interactive (list (jabber-read-jid-completing "JID: ")))
;;   (let ((buffer (generate-new-buffer (format "*-jabber-history-%s-*"
;;                                              (jabber-jid-displayname jid)))))
;;     (switch-to-buffer buffer)
;;     (make-local-variable 'jabber-chat-ewoc)
;;     (setq jabber-chat-ewoc (ewoc-create #'jabber-chat-pp))
;;     (mapc 'jabber-chat-insert-backlog-entry
;;           (nreverse (jabber-history-query nil nil t t "."
;;                                           (jabber-history-filename jid))))
;;     (view-mode)))

;; (defun x-urgency-hint (frame arg &optional source)
;;   (let* ((wm-hints (append (x-window-property
;;                             "WM_HINTS" frame "WM_HINTS" source nil t) nil))
;;          (flags (car wm-hints)))
;;     (setcar wm-hints
;;             (if arg
;;                 (logior flags #x00000100)
;;               (logand flags #x1ffffeff)))
;;     (x-change-window-property "WM_HINTS" wm-hints frame "WM_HINTS" 32 t)))

;; ;; usage example
;; (defvar jabber-activity-jids-count 0)

;; (defun jabber-urgency-hint ()
;;   (let ((count (length jabber-activity-jids)))
;;     (unless (= jabber-activity-jids-count count)
;;       (if (zerop count)
;;           (x-urgency-hint (selected-frame) nil)
;;         (x-urgency-hint (selected-frame) t))
;;       (setq jabber-activity-jids-count count))))

;; (add-hook 'jabber-activity-update-hook 'jabber-urgency-hint)

;; (require 'evil)
;; (add-hook 'jabber-chat-mode-hook 'evil-emacs-state)
;; (add-hook 'jabber-browse-mode-hook 'evil-emacs-state)
;; (add-hook 'jabber-roster-mode-hook 'evil-emacs-state)

;; (provide 'setup-jabber)
