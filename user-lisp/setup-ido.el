(require 'ido)
(ido-mode t)
(setq ido-enable-prefix nil 
      ido-enable-flex-matching t 
      ido-case-fold nil 
      ido-auto-merge-work-directories-length -1 
      ido-create-new-buffer 'always 
      ido-use-filename-at-point nil 
      ido-max-prospects 10) 

(require 'flx-ido)
(flx-ido-mode 1)

;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

;; Use ido everywhere
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

(provide 'setup-ido)
