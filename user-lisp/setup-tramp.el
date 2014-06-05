(require 'tramp)

(setq tramp-default-method "ssh")
(add-to-list 'load-path "~/.emacs.d/site-lisp/vagrant-tramp")
(add-to-list 'exec-path "~/.emacs.d/site-lisp/vagrant-tramp")
(eval-after-load 'tramp
  '(progn
     (require 'vagrant-tramp)))

;(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

(provide 'setup-tramp)
