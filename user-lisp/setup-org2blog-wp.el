(require 'org2blog)

(setq org2blog/wp-blog-alist
      '(("astro-fc"
         :url "http://astronomia.uni.edu.pe/xmlrpc.php"
         :username "cestdiego"
         :default-title "Hello World"
         :default-categories ("org2blog" "emacs")
         :tags-as-categories nil)
        ("my-blog"
         :url "http://username.server.com/xmlrpc.php"
         :username "admin")))

(setq org2blog/wp-confirm-post t)

(provide 'setup-org2blog-wp)
