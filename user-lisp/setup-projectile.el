(require 'persp-projectile)
(projectile-persp-bridge helm-projectile)
(setq projectile-switch-project-action 'helm-projectile-find-file)
(projectile-global-mode)

;; Disable this line  if you do not want to use helm and
;; use old boring ido for this
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)
(setq projectile-other-file-alist
      '(("cpp" "h" "hpp" "ipp")
        ("ipp" "h" "hpp" "cpp")
        ("hpp" "h" "ipp" "cpp")
        ("cxx" "hxx" "ixx")
        ("ixx" "cxx" "hxx")
        ("hxx" "ixx" "cxx")
        ("c" "h")
        ("m" "h")
        ("mm" "h")
        ("h" "c" "cpp" "ipp" "hpp" "m" "mm")
        ("cc" "hh")
        ("hh" "cc")
        ("vert" "frag")
        ("frag" "vert")
        (nil "lock" "gpg")
        ("lock" "")
        ("gpg" "")))

(provide 'setup-projectile)
