(defun increase-window-height (&optional arg)
  "Make the window taller by one line. Useful when bound to a repeatable key combination."
  (interactive "p")
  (enlarge-window arg))

(defun decrease-window-height (&optional arg)
  "Make the window shorter by one line. Useful when bound to a repeatable key combination."
  (interactive "p")
  (enlarge-window (- 0 arg)))

(defun decrease-window-width (&optional arg)
  "Make the window narrower by one column. Useful when bound to a repeatable key combination."
  (interactive "p")
  (enlarge-window (- 0 arg) t))

(defun increase-window-width (&optional arg)
  "Make the window wider by one column. Useful when bound to a repeatable key combination."
  (interactive "p")
  (enlarge-window arg t))
