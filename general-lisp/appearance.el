(setq visible-bell t
      font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)


;; Set custom theme path
(setq custom-theme-directory (concat user-emacs-directory "themes"))
(dolist
    (path (directory-files custom-theme-directory t "\\w+"))
  (when (file-directory-p path)
    (add-to-list 'custom-theme-load-path path)))

(load-theme 'zenburn t)

;; Highlight current line
(global-hl-line-mode 0)

;; No scratch Message
(setq initial-scratch-message ";; So this is you again, Diego\n\n")

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

(when (window-system)
  (set-frame-font "Monaco")
  (set-face-attribute 'default nil :family "Monaco" :height 120)
  (set-face-font 'default "Monaco")
  (set-frame-parameter (selected-frame) 'alpha '(60 60))
  )

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))


(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (when window-system
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen))))))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(fringe-mode -1)
(set-fringe-mode '(0 . 0))
(set-face-attribute 'mode-line nil  :inverse-video nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)
(set-face-attribute 'vertical-border nil :foreground "#1a1a1a")


(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))

(rename-modeline "Javascript-IDE" js2-mode "JS2")
(rename-modeline "clojure-mode" clojure-mode "Clj")


(provide 'appearance)
