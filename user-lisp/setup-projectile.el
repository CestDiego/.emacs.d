(require 'persp-projectile)
(projectile-persp-bridge helm-projectile)
(setq projectile-switch-project-action 'helm-projectile)
(projectile-global-mode)

(provide 'setup-projectile)
