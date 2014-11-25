;;; Commentary:
;;; This file is in charge of all appearance related stuff

;;; Code:
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

(load-theme 'hc-zenburn t)

;; Highlight current line
(global-hl-line-mode 1)
(set-face-background 'region "#202020")
;; No scratch Message
(setq initial-scratch-message ";; So this is you again, Diego\n\n")

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

(when (window-system)
  (add-hook 'after-init-hook (lambda ()
                               (when (fboundp 'auto-dim-other-buffers-mode)
                                 (auto-dim-other-buffers-mode t))))
  (set-frame-font "Consolas")
  (custom-set-faces
   '(default ((t (:family "Consolas" :height 130 :embolden t))))
   '(auto-dim-other-buffers-face ((t (:background "#1f1f1f")))))
  (set-face-font 'default "Consolas"))


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
