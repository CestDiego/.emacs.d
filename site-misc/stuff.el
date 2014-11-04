;; eval this buffer and then start modifying the data in the table below.
;;
;; ------------
;; Alpha   | 110
;; Beta    | 185
;; Gamma   | 164
;; Delta   | 20
;; Epsilon | 180
;; 
;; ----------------------------------------------------------------------

;; ----------------------------------------------------------------------

(defun my-chart-update ()
  (interactive)
  (save-excursion
    (let (data label)
      (goto-char (point-min))
      (search-forward "--------")
      (forward-line)
      (while (looking-at ";;\\s-*\\(\\w+\\)\\s-*|\\s-*\\([0-9.]+\\)")
        (push (match-string 1) label)
        (push (match-string 2) data)
        (forward-line))

      (let ((url (format "http://chart.googleapis.com/chart?chs=500x250&chd=t:%s&chl=%s"
                         (mapconcat 'identity (reverse data) ",")
                         (mapconcat 'identity (reverse label) "|"))))

        (when (not (equal my-chart-last-data url))
          (setq my-chart-last-data url)

          (search-forward "--------")
          (forward-line)
          (delete-region (point)
                         (save-excursion
                           (search-forward "--------")
                           (line-beginning-position)))
          (dolist (type '("p" "lc" "bhs"))
            (insert-image
             (with-current-buffer 
                 (url-retrieve-synchronously
                  (let ((url (concat url "&cht=" type)))
                    ;; a little ugly hack, because it's just a prototype
                    (if (equal "bhs" type)
                        (concat (replace-regexp-in-string
                                 "chl=[^&]+"
                                 (concat "chxl=1:|" (mapconcat 'identity
                                                               label
                                                               "|"))
                                 url)
                                "&chxt=x,y")
                      url)))
               
               (goto-char (point-min))
               (search-forward "\n\n")
               (create-image (buffer-substring (point) (point-max)) 'png t)))
            (insert " "))
          (insert "\n"))))))

(setq my-chart-update-delay 0.1)

(setq my-chart-buffer-tick (buffer-modified-tick))

(setq my-chart-last-data "")

(defun my-chart-update-monitor ()
  (when (and (not (equal my-chart-buffer-tick (buffer-modified-tick)))
           (sit-for my-chart-update-delay))
    (setq my-chart-buffer-tick (buffer-modified-tick))
    (my-chart-update)
    (message "")))

(add-hook 'post-command-hook 'my-chart-update-monitor nil t)

(my-chart-update)
