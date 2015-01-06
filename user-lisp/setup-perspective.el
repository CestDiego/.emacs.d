(require 'perspective)
(require 'org)

;; loading code for our custom perspectives
;; taken from Magnar Sveen
(defmacro custom-persp (name &rest body)
  `(let ((initialize (not (gethash ,name perspectives-hash)))
         (current-perspective persp-curr))
     (persp-switch ,name)
     (when initialize ,@body)
     (setq persp-last current-perspective)))

;; Jump to last perspkective
;; taken from Magnar Sveen
(defun custom-persp-last ()
  (interactive)
  (persp-switch (persp-name persp-last)))

(defun persp-cycle-next ()
  "Cycle throught the available perspectives."
  (interactive)
  (let ((next-pos (1+ (persp-curr-position)))
        (list-size (length (persp-all-names))))
    (cond ((eq 1 list-size) (persp-switch nil))
          ((>= next-pos list-size) (persp-switch (nth 0 (persp-all-names))))
          (t (persp-next)))))

(defun persp-cycle-prev ()
  "Cycle throught the available perspectives."
  (interactive)
  (let ((next-pos (- (persp-curr-position) 1))
        (list-size (length (persp-all-names))))
    (cond ((eq 1 list-size) (persp-switch nil))
          ((< next-pos 0) (persp-switch (nth (- list-size 1) (persp-all-names))))
          (t (persp-prev)))))

;; Easily switch to your last perspective
(define-key persp-mode-map (kbd "C-x p -") 'custom-persp-last)

;; muh perspectives
(defun custom-persp/emacs ()
  (interactive)
  (custom-persp ".emacs.d"
                (find-file "~/.emacs.d/init.el")))
(define-key persp-mode-map (kbd "C-x p e") 'custom-persp/emacs)

(defun irc-config()
  (load-library "~/.emacs.d/user-lisp/defuns/secret.el.gpg")
  (irc-cestdiego))

(defun custom-persp/irc ()
  (interactive)
  ;; (custom-persp "@IRC" (irc-cestdiego)))
  (custom-persp "@IRC" (irc-config)))
(define-key persp-mode-map (kbd "C-x p i") 'custom-persp/irc)

;; (defun custom-persp/calfw()
;;   (interactive)
;;   (custom-persp "Calendar" (cfw:open-ical-calendar "https://www.google.com/calendar/ical/rmhn208r5foam7t129q9pbuo8g%40group.calendar.google.com/private-313974a16c0f9be18a26acb2d02853fa/basic.ics")))
;; (define-key persp-mode-map (kbd "C-x p c") 'custom-persp/calfw)

(defun custom-persp/paradox-list-packages()
  (interactive)
  (custom-persp "Paradox Package List" (paradox-list-packages nil)))
(define-key persp-mode-map (kbd "C-x p l") 'custom-persp/paradox-list-packages)

;; (defun connect-to-jabber ()
;;   (jabber-connect-all)
;;   (jabber-switch-to-roster-buffer))

;; (defun custom-persp/jabber ()
;;   (interactive)
;;   (custom-persp "@Jabber" (connect-to-jabber)))
;; (define-key persp-mode-map (kbd "C-x p j") 'custom-persp/jabber)

;; (defun custom-persp/gnus ()
;;   (interactive)
;;   (custom-persp "gnus" (gnus)))
;; (define-key persp-mode-map (kbd "C-x p g") 'custom-persp/gnus)

;; (defun custom-persp/matlab ()
;;   (interactive)
;;   (custom-persp "MATLAB Shell" (matlab-shell)))
;; (define-key persp-mode-map (kbd "C-x p m") 'custom-persp/matlab)

(defun custom-persp/periodic ()
  (interactive)
  (custom-persp "Periodic Table" (eperiodic)))
(define-key persp-mode-map (kbd "C-x p p") 'custom-persp/periodic)

;; (defun setup-soundklaus ()
;;   (dolist (p (auth-source-search :port "soundklaus"
;;                                  :require '(:secret)))
;;     (let ((token (plist-get p :secret)))
;;       (setq soundklaus-access-token  (if (functionp token)
;;                                          (funcall token)
;;                                        token))))
;;   (soundklaus-my-tracks))
;; (defun custom-persp/soundklaus ()
;;   (interactive)
;;   (custom-persp "SoundKlaus" (setup-soundklaus)))
;; (define-key persp-mode-map (kbd "C-x p s") 'custom-persp/soundklaus)


(defun setup-swank ()
  (find-file "~/.stumpwm.d/init.lisp")
  (slime-connect "127.0.0.1" "4005"))

(defun custom-persp/stumpwm-swank ()
  (interactive)
  (custom-persp "StumpWM" (setup-swank)))
(define-key persp-mode-map (kbd "C-x p s") 'custom-persp/stumpwm-swank)
;; (defun custom-persp/twitter ()
;;   (interactive)
;;   (custom-persp "@Twitter" (twit)))
;; (define-key persp-mode-map (kbd "C-x p t") 'custom-persp/twitter)

(defun custom-persp/org ()
  (interactive)
  (custom-persp "@org"
                (find-file (first org-agenda-files))))
(define-key persp-mode-map (kbd "C-x p o") 'custom-persp/org)

(persp-mode)

(provide 'setup-persp-mode)
