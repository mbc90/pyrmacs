;;; Code: 
(require 'set-themes)
(setq global-font-lock-mode t)
(use-package doom-themes
  :straight t
  :ensure t
  :config
  ; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package nerd-icons
  :straight t)
(require 'nerd-icons)

(use-package catppuccin-theme
  :straight t)
;; call set theme function
(add-hook 'after-init-hook (lambda()(load-theme 'doom-one t)))
;; (setq catppuccin-flavor 'frappe)
;; (catppuccin-reload)
;; font
(set-face-attribute 'default nil :font (set-font) :height (set-font-height))

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;; remove line numbers in vterm
(add-hook 'vterm-mode-hook(lambda() (display-line-numbers-mode -1)))

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tooltip-mode -1)           ; Disable tooltips
(tool-bar-mode -1)          ; Disable the toolbar

(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; use-package with package.el:
(use-package dashboard
  :straight t
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(add-hook 'server-after-make-frame-hook (lambda () (dashboard-refresh-buffer)))

;; (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))


(setq dashboard-startup-banner "~/.emacs.d/image/pyr-bubble.png")
(setq dashboard-image-banner-max-width 512)

;; this makes the buffer on emacsclient be dashboard
(setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
(setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package
(setq dashboard-set-heading-icons nil)
(setq dashboard-set-file-icons t)

(use-package all-the-icons :straight t)

;; Org-mode stuff 
(use-package hl-todo :straight t)
(setq global-hl-todo-mode t)
(use-package ob-mermaid :straight t)
;; (use-package org-present :straight t)
;; (use-package visual-fill-column :straight t)


;; ;; Configure fill width
;; (setq visual-fill-column-width 110
;;       visual-fill-column-center-text t)

;; (defun my/org-present-start ()
;;   ;; Center the presentation and wrap lines
;;   (visual-fill-column-mode 1)
;;   (visual-line-mode 1)
;;   ;; Tweak font sizes
;; (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
;;                                    (header-line (:height 4.0) variable-pitch)
;;                                    (org-document-title (:height 1.75) org-document-title)
;;                                    (org-code (:height 1.55) org-code)
;;                                    (org-verbatim (:height 1.55) org-verbatim)
;;                                    (org-block (:height 1.25) org-block)
;;                                    (org-block-begin-line (:height 0.7) org-block))))

;; (defun my/org-present-end ()
;;   ;; Stop centering the document
;;   (visual-fill-column-mode 0)
;;   (visual-line-mode 0)
;;   ;; Reset font customizations
;; (setq-local face-remapping-alist '((default variable-pitch default))))

;; ;; Register hooks with org-present
;; (add-hook 'org-present-mode-hook 'my/org-present-start)
;; (add-hook 'org-present-mode-quit-hook 'my/org-present-end)

;; org babel stuff
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (R . y)
   (scheme . t)
   (mermaid . t)))
;; add bullets instead of asteriks 
(use-package org-bullets :straight t)
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook 'visual-line-mode)

;; ligature
(use-package ligature
  :straight t
  :config
  ;; enable all ligatures
  (ligature-set-ligatures 't '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  (global-ligature-mode t))

;;org-tempo makes it faster to input source blocks
(require 'org-tempo)
;; editing nice to haves 
;; Tree Sitter Stuff
(use-package tree-sitter
  :straight t)
(use-package tree-sitter-langs
  :straight t)
;; give your brackets a friend
(electric-pair-mode 1)
;; Stop getting lost in lisp!
(use-package rainbow-delimiters
  :straight t)
;; start rainbow-delimiter mode in all programming modes
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(provide 'theme)

