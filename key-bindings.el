;; Nobody needs to kill emacs that easily

(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-x C-c") 'delete-frame)

;; helm
(global-set-key (kbd "C-c o") 'helm-overlord)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-<SPC>") 'helm-M-x)
(global-set-key (kbd "C-`") 'helm-yas-complete)

;; Org
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; decent navigation like a good citizen
(global-set-key (kbd "<C-tab>") 'persp-cycle-next)
(global-set-key (kbd "<C-S-iso-lefttab>") 'persp-cycle-prev)
(global-set-key (kbd "<C-f11>") 'toggle-fullscreen)

;; This i to bind Zoom in And Zoom Out with mouse, fuck yeah
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

(require 'iedit)
;; Multiple Cursors that work with Evil mode
;; Use M-I to limit to current line
;; Use M-{ M-} to expand one line above and one below
(global-set-key (kbd "C-c i") 'iedit-mode)

;; use windmove to navigate between windows easily
(when (fboundp 'windmove-default-keybindings)
  ;; (windmove-default-keybindings)
  (global-set-key (kbd "s-i") 'windmove-right)
  (global-set-key (kbd "s-u") 'windmove-up)
  (global-set-key (kbd "s-h") 'windmove-left)
  (global-set-key (kbd "s-j") 'windmove-down)
  )

(global-set-key (kbd "C-c j") 'winner-undo)
(global-set-key (kbd "C-c k") 'winner-redo)

;; Increase Height and Width of Windows
(global-set-key (kbd "C->")
                'increase-window-height)
(global-set-key (kbd "C-<")
                'decrease-window-height)
(global-set-key (kbd "s-,")
                'decrease-window-width)
(global-set-key (kbd "s-.")
                'increase-window-width)


;; Turn on the menu bar for exploring new modes
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)

(unless (and (boundp 'mac-mouse-wheel-smooth-scroll) mac-mouse-wheel-smooth-scroll)
  (global-set-key [wheel-down] (lambda () (interactive) (scroll-up-command 1)))
  (global-set-key [wheel-up] (lambda () (interactive) (scroll-down-command 1)))
  (global-set-key [double-wheel-down] (lambda () (interactive) (scroll-up-command 2)))
  (global-set-key [double-wheel-up] (lambda () (interactive) (scroll-down-command 2)))
  (global-set-key [triple-wheel-down] (lambda () (interactive) (scroll-up-command 4)))
  (global-set-key [triple-wheel-up] (lambda () (interactive) (scroll-down-command 4))))

;; Zeal-at-point
(global-set-key "\C-cz" 'zeal-at-point)
(global-set-key "\C-cZ" 'zeal-at-point-with-docset)

(global-set-key (kbd "C-c e <down>") 'emms-start)
(global-set-key (kbd "C-c e <up>") 'emms-stop)
(global-set-key (kbd "C-c e <left>") 'emms-previous)
(global-set-key (kbd "C-c e <right>") 'emms-next)

;; other goodies
(global-set-key (kbd "C-x C-y") 'kill-ring-ido)
(global-set-key (kbd "C-'") 'multi-term-dedicated-toggle)
(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-c C-s") 'gist-region-or-buffer-private)
(global-set-key (kbd "C-c C-u C-s") 'gist-region-or-buffer)
(global-set-key (kbd "C-\\") 'er/expand-region)


(global-set-key (kbd "<C-M-return>") 'rcirc-next-active-buffer)


;; prevent madness
(global-set-key (kbd "C-x 2") (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key (kbd "C-x 3") (lambda () (interactive)(split-window-horizontally) (other-window 1)))

;; Navigation Bindings
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<next>") 'end-of-buffer)

;; If you are loking for Evil Leader stuff, that's in the setup-evil file

;; smartparens
(define-key sp-keymap (kbd "C-M-f") 'sp-forward-sexp)
(define-key sp-keymap (kbd "C-M-b") 'sp-backward-sexp)

(define-key sp-keymap (kbd "C-M-d") 'sp-down-sexp)
(define-key sp-keymap (kbd "C-M-a") 'sp-backward-down-sexp)
(define-key sp-keymap (kbd "C-S-a") 'sp-beginning-of-sexp)
(define-key sp-keymap (kbd "C-S-d") 'sp-end-of-sexp)

(define-key sp-keymap (kbd "C-M-e") 'sp-up-sexp)
(define-key emacs-lisp-mode-map (kbd ")") 'sp-up-sexp)
(define-key sp-keymap (kbd "C-M-u") 'sp-backward-up-sexp)
(define-key sp-keymap (kbd "C-M-t") 'sp-transpose-sexp)

(define-key sp-keymap (kbd "C-M-n") 'sp-next-sexp)
(define-key sp-keymap (kbd "C-M-p") 'sp-previous-sexp)

(define-key sp-keymap (kbd "C-M-k") 'sp-kill-sexp)
(define-key sp-keymap (kbd "C-M-w") 'sp-copy-sexp)

(define-key sp-keymap (kbd "M-<delete>") 'sp-unwrap-sexp)
(define-key sp-keymap (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)

(define-key sp-keymap (kbd "C-<right>") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "C-<left>") 'sp-forward-barf-sexp)
(define-key sp-keymap (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
(define-key sp-keymap (kbd "C-M-<right>") 'sp-backward-barf-sexp)

(define-key sp-keymap (kbd "M-D") 'sp-splice-sexp)
(define-key sp-keymap (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
(define-key sp-keymap (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
(define-key sp-keymap (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)

(define-key sp-keymap (kbd "C-]") 'sp-select-next-thing-exchange)
(define-key sp-keymap (kbd "C-<left_bracket>") 'sp-select-previous-thing)
(define-key sp-keymap (kbd "C-M-]") 'sp-select-next-thing)

(define-key sp-keymap (kbd "M-F") 'sp-forward-symbol)
(define-key sp-keymap (kbd "M-B") 'sp-backward-symbol)

(define-key sp-keymap (kbd "H-t") 'sp-prefix-tag-object)
(define-key sp-keymap (kbd "H-p") 'sp-prefix-pair-object)
(define-key sp-keymap (kbd "H-s c") 'sp-convolute-sexp)
(define-key sp-keymap (kbd "H-s a") 'sp-absorb-sexp)
(define-key sp-keymap (kbd "H-s e") 'sp-emit-sexp)
(define-key sp-keymap (kbd "H-s p") 'sp-add-to-previous-sexp)
(define-key sp-keymap (kbd "H-s n") 'sp-add-to-next-sexp)
(define-key sp-keymap (kbd "H-s j") 'sp-join-sexp)
(define-key sp-keymap (kbd "H-s s") 'sp-split-sexp)


(provide 'key-bindings)
