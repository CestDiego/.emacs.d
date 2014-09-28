;; ;;; Commentary:

;; ;;; Code:
;; (require 'emms-setup)
;; (emms-standard)
;; (emms-default-players)
;; (setq emms-source-file-default-directory "~/Music")

;; ;; use system-notify with emms
;; (add-hook
;;  'emms-player-started-hook
;;  '(lambda ()(notify-send-popup
;;              "SoundKlaus is now playing..."
;;              (emms-track-description (emms-playlist-current-selected-track))
;;              "~/.emacs.d/site-misc/soundcloud.png"
;;              )))

;; (require 'emms-player-vlc)
;; (define-emms-simple-player vlc '(file url)
;;   (concat "\\`\\(https?\\|mms\\)://\\|"
;;       (emms-player-simple-regexp
;;        "ogg" "mp3" "wav" "mpg" "mpeg" "wmv" "wma"
;;        "mov" "avi" "divx" "ogm" "ogv" "asf" "mkv"
;;        "rm" "rmvb" "mp4" "flac" "vob" "m4a" "ape"))
;;   "vlc" "--intf=rc")

;; ;;; Add music file to playlist on '!', --lgfang
;; (add-to-list 'dired-guess-shell-alist-user
;;              (list "\\.\\(flac\\|mp3\\|ogg\\|wav\\)\\'"
;;                    '(if (y-or-n-p "Add to emms playlist?")
;;                         (progn (emms-add-file (dired-get-filename))
;;                                (keyboard-quit))
;;                       "mplayer")))
;; (provide 'setup-emms)

;; ;; (require 'emms-setup)
;; ;; (emms-devel)

;; ;; (setq emms-source-file-default-directory "~/Music/")

;; ;; (define-emms-simple-player mplayer-mp3 '(file url)
;; ;;   "\\.[mM][pP][23]$" "mplayer")

;; ;; (define-emms-simple-player mplayer-ogg '(file)
;; ;;   (regexp-opt '(".ogg" ".OGG" ".FLAC" ".flac" )) "mplayer")

;; ;; (define-emms-simple-player mplayer-playlist '(streamlist)
;; ;;   "http://" "mplayer" "-playlist")

;; ;; (define-emms-simple-player mplayer-list '(file url)
;; ;;   (regexp-opt '(".m3u" ".pls")) "mplayer" "-playlist")

;; ;; (define-emms-simple-player mplayer-video '(file url)
;; ;;   (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv"
;; ;;                 ".wma" ".mov" ".avi" ".divx" ".ogm" ".asf"
;; ;;                 ".mkv" "http://")) "mplayer")

;; ;; (setq emms-player-list '(emms-player-mplayer-mp3
;; ;;                          emms-player-mplayer-ogg
;; ;;                          emms-player-mplayer-playlist
;; ;;                          emms-player-mplayer-video
;; ;;                          emms-player-mplayer-list
;; ;;                          ))

;; ;; (setq emms-playlist-buffer-name "*EMMS*")

;; ;; (setq emms-info-asynchronously t)

;; ;; (setq emms-stream-default-action "play")

;; ;; (defun emms-add-universe-synchronously ()
;; ;;   (interactive)
;; ;;   (let ((emms-info-asynchronously nil))
;; ;;     (emms-add-directory-tree emms-source-file-default-directory)
;; ;;      (message "Thud!")))

;; ;; ;debug players
;; ;; ; (emms-player-for '(*track* (type . file)
;; ;; ;                           (name . "myfile.pls")))

;; ;; (provide 'setup-emmms)
