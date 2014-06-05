(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location '("~/.envs/"
                      "/Users/gleveroni/Documents/mvm/inca/env/"))
