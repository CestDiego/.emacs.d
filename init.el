;;; Code:

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq user-lisp-dir
      (expand-file-name "user-lisp" user-emacs-directory))

(setq w3m-dir
      (expand-file-name "site-misc/emacs-w3m" user-emacs-directory))

(setq webkit-dir
      (expand-file-name "site-list/webkit" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path user-lisp-dir)
(add-to-list 'load-path w3m-dir)
(add-to-list 'load-path webkit-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Set up appearance early
(require 'appearance)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

;; Setup packages
(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(dired-details
     auto-complete
     gist
     yasnippet
     flx-ido
     ido-ubiquitous
     smartparens
     rainbow-delimiters
     magit
     git-gutter
     perspective
     projectile
     multi-term
     exec-path-from-shell
     whitespace-cleanup-mode
     saveplace
     browse-kill-ring
     guide-key
     expand-region
     diminish
     pretty-mode
     itail
     prodigy
     restclient
     deferred
     xml-rpc
     metaweblog

     ;; Common Lisp
     slime
     ac-slime

     ;; Elisp
     dash 
     elisp-slime-nav
     
     ;; Evil
     evil
     evil-visualstar
     evil-surround				
     evil-leader
     evil-numbers
     
     ;; Haskell
     haskell-mode
     hi2
     
     ;; Helm
     helm
     helm-projectile
     helm-themes
     helm-c-yasnippet

     ;; MongoDB
     inf-mongo
     ob-mongo

     ;; gnus
     ;; gnus
     ;; bbdb

     ;; OSX
     erc-terminal-notifier
     dash-at-point

     ;; Clojure
     cider
     ac-cider
     clj-refactor
     clojure-cheatsheet
     clojure-snippets
     latest-clojure-libraries
     align-cljlet
     slamhound
     midje-mode

     ;; Org Mode
     org
     org-plus-contrib
     o-blog
     org2blog
     
     ;; YAML
     yaml-mode
     ansible
     ansible-doc

     ;; Zeal (Dash Replacement for Linux)
     ;; zeal-at-point
     helm-dash
     
     ;; MATLAB
     ;; matlab-mode
     
     ;; ;; Server
     ;; elnode
     ;; peek-mode

     ;; LaTeX
     auctex
     latex-preview-pane
     ac-math
     ebib
     gnuplot-mode
     ac-ispell
     
     ;; HTML
     emmet-mode
     web-mode
     less-css-mode
     rainbow-mode
     htmlize

     ;; Python
     elpy
     flycheck
     jedi
     epc
     
     ;; Lua
     lua-mode

     ;; Coffeescript
     coffee-mode

     ;; Javascript
     js2-mode
     js2-refactor
     ac-js2
     skewer-mode

     ;;Goodies
      
     ace-jump-mode
     ox-reveal
     calfw
     spray ;; Speed-reading

     ;; jabber
     ;; twittering-mode

     ;; Themming
     smart-mode-line
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; Lets start with a smattering of sanity
(require 'sane-defaults)

;; Setup Key bindings
(require 'key-bindings)

;; Load Mac-only config
(when is-mac (require 'mac))

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Load PATH from shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Load user specific configuration
(when (file-exists-p user-lisp-dir)
  (mapc 'load (directory-files user-lisp-dir nil "^[^#].*el$")))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
