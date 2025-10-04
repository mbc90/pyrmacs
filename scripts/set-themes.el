
;; set-themes.el --- Summary
;;; Commentary:

;; a simple function that compares the system and sets the font
;; if system-type = darwin, return 120
;; else return 95

;;; Code:
(defun set-font-height ()
  "Check hostname and return a value."
  (if (eq system-type 'darwin)
      (progn 120)
  (progn 95)))

(defun set-font ()
  "Check host name and return font."
  (if (eq system-type 'darwin)
        (progn "FiraCode Nerd Font Mono")
        (progn "Maple Mono NF CN")))
;; only used if I set global theme through nixos
  (defun set-theme()
    (if (eq system-type 'darwin)

	( use-package doom-themes
		      :straight t
		      :config
	 		;; set doom-themes variables
	 		;; Global settings (defaults)
	 		(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
         		doom-themes-enable-italic t) ; if nil, italics is universally disabled
	 		(load-theme 'doom-monokai-pro t))))

(provide 'set-themes)
;;; set-themes.el ends here
