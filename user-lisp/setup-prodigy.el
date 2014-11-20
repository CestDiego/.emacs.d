(require 'prodigy)
(global-set-key (kbd "C-x M-m") 'prodigy)

(defface prodigy-dull-face
  '((((class color)) :foreground "#999999"))
  "Gray color indicating waiting."
  :group 'prodigy)

(prodigy-define-status :id 'running :face 'prodigy-dull-face)
(prodigy-define-status :id 'exception :face 'prodigy-red-face)

;; (prodigy-define-tag
;;   :name 'django
;;   :on-output (lambda (service output)
;;                (when (s-matches? "Starting development server " output)
;;                  (prodigy-set-status service 'ready))
;;                (when (s-matches? "Exception" output)
;;                  (prodigy-set-status service 'exception))))

(prodigy-define-service
  :name "GMAT Dudes"
  :cwd "~/Documents/Projects/gmatnew/"
  :command "python"
  :args '("manage.py" "runserver" )
  :init (lambda ()
          (pyvenv-workon "test"))
  :kill-signal 'sigkill
  :kill-process-buffer-on-stop t
  )

;; (prodigy-define-service
;;   :name "kodemaker.no"
;;   :cwd "~/projects/kodemaker.no/"
;;   :command "lein"
;;   :args '("trampoline" "ring" "server-headless")
;;   :port 3333
;;   :tags '(ring))

;; (comment
;;  (prodigy-define-service
;;    :name "datomic oiiku-central-api"
;;    :cwd "~/data/datomic-free-0.8.4218"
;;    :path '("~/data/datomic-free-0.8.4218/bin")
;;    :command "transactor"
;;    :args '("../../projects/oiiku/oiiku-central-api/oiiku-central-api-server/config/datomic-transactor-free.properties")
;;    :tags '(oiiku datomic pillar))

;;  (prodigy-define-service
;;    :name "datomic oiiku-badges-app"
;;    :cwd "~/data/datomic-free-0.8.4218"
;;    :path '("~/data/datomic-free-0.8.4218/bin")
;;    :command "transactor"
;;    :args '("../../projects/oiiku/oiiku-badges-app/config/datomic-transactor-free.properties")
;;    :tags '(oiiku datomic pillar))

;;  (prodigy-define-service
;;    :name "datomic oiiku-screen-admin"
;;    :cwd "~/data/datomic-free-0.8.4218"
;;    :path '("~/data/datomic-free-0.8.4218/bin")
;;    :command "transactor"
;;    :args '("../../projects/oiiku/oiiku-screen-admin-app/config/datomic-transactor-free.properties")
;;    :tags '(oiiku datomic pillar))

;;  (prodigy-define-service
;;    :name "elasticsearch"
;;    :cwd "~/data/elasticsearch-1.0.0.Beta1/"
;;    :path '("~/data/elasticsearch-1.0.0.Beta1/bin/")
;;    :command "elasticsearch"
;;    :args '("-f")
;;    :tags '(oiiku elasticsearch pillar)
;;    :on-output (lambda (service output)
;;                 (when (s-matches? "] started" output)
;;                   (prodigy-set-status service 'ready))))

;;  (prodigy-define-service
;;    :name "oiiku-central-api"
;;    :cwd "~/projects/oiiku/oiiku-central-api/oiiku-central-api-server/"
;;    :command "lein"
;;    :args '("trampoline" "ring" "server-headless")
;;    :tags '(oiiku pillar))

;;  (prodigy-define-service
;;    :name "oiiku-sso"
;;    :cwd "~/projects/oiiku/oiiku-sso/"
;;    :command "lein"
;;    :args '("trampoline" "ring" "server-headless")
;;    :tags '(oiiku pillar))

;;  (prodigy-define-service
;;    :name "oiiku-event-admin"
;;    :cwd "~/projects/oiiku/oiiku-event-admin/"
;;    :command "lein"
;;    :args '("trampoline" "ring" "server-headless")
;;    :tags '(oiiku pillar))

;;  (prodigy-define-service
;;    :name "oiiku-attendants-app"
;;    :cwd "~/projects/oiiku/oiiku-attendants-app/"
;;    :command "lein"
;;    :args '("trampoline" "ring" "server-headless")
;;    :tags '(oiiku pillar))

;;  (prodigy-define-service
;;    :name "oiiku-messages-app"
;;    :cwd "~/projects/oiiku/oiiku-messages-app/"
;;    :command "lein"
;;    :args '("trampoline" "ring" "server-headless")
;;    :tags '(oiiku messages))

;;  (prodigy-define-service
;;    :name "oiiku-messages-gateway"
;;    :cwd "~/projects/oiiku/oiiku-messages-gateway/"
;;    :command "lein"
;;    :args '("trampoline" "ring" "server-headless")
;;    :tags '(oiiku messages))

;;  (prodigy-define-service
;;    :name "oiiku-messages-dummy"
;;    :cwd "~/projects/oiiku/oiiku-messages-dummy/"
;;    :path '("~/projects/oiiku/oiiku-messages-dummy/")
;;    :command "gradlew"
;;    :args '("run")
;;    :tags '(oiiku messages))

;;  (prodigy-define-service
;;    :name "oiiku-badges-app"
;;    :cwd "~/projects/oiiku/oiiku-badges-app/"
;;    :command "lein"
;;    :args '("trampoline" "ring" "server-headless")
;;    :tags '(oiiku))

;;  (prodigy-define-service
;;    :name "oiiku-invitations-app"
;;    :cwd "~/projects/oiiku/oiiku-invitations-app/"
;;    :command "lein"
;;    :args '("trampoline" "ring" "server-headless")
;;    :tags '(oiiku))

;;  (prodigy-define-service
;;    :name "oiiku-screen-admin-app"
;;    :cwd "~/projects/oiiku/oiiku-screen-admin-app/"
;;    :command "lein"
;;    :args '("trampoline" "ring" "server-headless")
;;    :tags '(oiiku)))

(provide 'setup-prodigy)
