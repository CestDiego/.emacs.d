(require 'tramp)

(setq tramp-default-method "ssh")

;(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

(provide 'setup-tramp)
