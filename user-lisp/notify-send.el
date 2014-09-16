(defun notify-send-popup (title msg &optional icon sound)
  "Show a popup if we're on X, or echo it otherwise; TITLE is the title
of the message, MSG is the context. Optionally, you can provide an ICON and
a sound to be played"

  (interactive)
  (when sound (shell-command
                (concat "mplayer -really-quiet " sound " 2> /dev/null")))
  (if (eq window-system 'x)
    (shell-command (concat "notify-send "

                     (if icon (concat "-i " icon) "")
                     " '" title "' '" msg "'"))
    ;; text only version

    (message (concat title ": " msg))))

;; Display Emacs Startup Time
(add-hook 'after-init-hook (lambda ()
                             (notify-send-popup
                              "Happy Hacking!!!"
                              "Welcome to HackSpace, Diego!"
                              "~/.emacs.d/site-misc/hack.png"
                              "~/.emacs.d/site-misc/startup.ogg"
                              )
                             (notify-send-popup
                              "Emacs Startup"
                              (format "The init sequence took %s."
                               (emacs-init-time))
                              "~/.emacs.d/site-misc/emacs.png"
                              "~/.emacs.d/site-misc/startup.ogg"
                              )))


;; (notify-send-popup "Welcome to" "Emacs the great"
;;                    "/usr/share/app-install/icons/lostirc.png" "~/.emacs.d/site-misc/startup.ogg")
