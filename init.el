;;; Code:

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Set path to dependencies
(setq general-lisp-dir
      (expand-file-name "general-lisp" user-emacs-directory))

(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq user-lisp-dir
      (expand-file-name "user-lisp" user-emacs-directory))

(setq w3m-lisp-dir
      (expand-file-name "site-misc/emacs-w3m" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path general-lisp-dir)
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path user-lisp-dir)
(add-to-list 'load-path w3m-lisp-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" general-lisp-dir))
(load custom-file)

;; Set up appearance early
(require 'appearance)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Add external projects to load path. That means site-lisp
;; stores some 3rd party projects that are not on melpa
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; Add User Defined Functions
(dolist (defuns (directory-files user-lisp-dir t "\\w+"))
  (when (file-directory-p defuns)
    (add-to-list 'load-path defuns)))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

;; Setup packages
(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(
     ;; Org Mode
     org
     org-plus-contrib
     o-blog

     ;; WordPress Edit
     metaweblog
     xml-rpc
     org2blog

     ;; Git
     magit
     git-gutter
     gitconfig-mode
     gitignore-mode
     git-commit-mode
     git-messenger
     git-timemachine
     gist

     ;; Company Mode for Completitions
     company-tern


     dired-details
     ;; auto-complete
     yasnippet
     flx-ido
     ido-ubiquitous
     smartparens
     rainbow-delimiters
     perspective
     projectile
     ;; multi-term
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

     ;; C/C++ Development
     ggtags
     
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
     helm-gtags
     helm-descbinds
     helm-github-stars

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

     ;; Elixir
     elixir-mode
     alchemist
     
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
     jinja2-mode
     grunt

     ;; Python
     elpy
     flycheck
     jedi
     epc
     
     ;; Lua
     lua-mode

     ;; Coffeescript
     coffee-mode

     ;; javaScript
     js2-mode
     js2-refactor
     requirejs-mode
     flymake-jshint
     tern
     skewer-mode
     ;; ac-js2

     ;;Goodies
     smooth-scrolling 
     ace-jump-mode
     ox-reveal
     aggressive-indent
     spray ;; Speed-reading
     nyan-mode

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

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Load PATH from shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Aggressive Indent Mode is better than electric
(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

;; Load user specific configuration
(when (file-exists-p user-lisp-dir)
  (mapc 'load (directory-files user-lisp-dir nil "^[^#].*el$")))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
