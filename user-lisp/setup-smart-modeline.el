;; Smart Modeline Theme
(sml/setup)
(sml/apply-theme 'respectful)

(add-to-list 'sml/replacer-regexp-list '("^~/Documents/Projects/" ":ProjDev:") t)
(add-to-list 'sml/replacer-regexp-list '("^:ProjDev:gmatnew" ":GMAT_Dudes:") t)

;; epic red Cursor
(set-cursor-color "firebrick")
