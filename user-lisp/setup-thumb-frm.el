(require 'thumb-frm)
(global-set-key [(shift mouse-3)]
                'thumfr-toggle-thumbnail-frame)
(global-set-key [(shift control mouse-3)]
                'thumfr-thumbify-other-frames)
(global-set-key [(shift control ?z)]
                'thumfr-thumbify-other-frames)
(global-set-key [(shift control ?p)]
                'thumfr-fisheye-previous-frame)
(global-set-key [(shift control ?n)]
                'thumfr-fisheye-next-frame)
(global-set-key [(control meta ?z)]
                'thumfr-really-iconify-or-deiconify-frame)

(provide 'setup-thumb-frm)
