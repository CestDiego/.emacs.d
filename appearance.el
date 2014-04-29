(setq visible-bell t
      font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

;; Highlight current line
(global-hl-line-mode 1)

;; Set custom theme path
(setq custom-theme-directory (concat user-emacs-directory "themes"))

(dolist
    (path (directory-files custom-theme-directory t "\\w+"))
  (when (file-directory-p path)
    (add-to-list 'custom-theme-load-path path)))

(when (window-system)
  (set-frame-font "Monaco")
  (set-face-attribute 'default nil :family "Monaco" :height 110 :weight 'bold)
  (set-face-font 'default "Monaco"))
(load-theme 'zenburn)

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

;; epic red
(set-cursor-color "firebrick")
(setq initial-scratch-message "")

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(provide 'appearance)
