;; Org-mode stuff 
;; org-agenda
(setq org-agenda-files
      (directory-files-recursively "~/org" "\\.org$"))

(setq org-todo-keywords
 '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELLED")))
(setq org-log-done 'time)               ;; timestamp when you mark something DONE
(setq org-agenda-start-on-weekday 1)
(use-package hl-todo :straight t)
(setq global-hl-todo-mode t)

;; Give me notifications
(require 'appt)
(appt-activate 1)
(org-agenda-to-appt) ;; Sync the TODOs

;; Auto refresh when agenda changes
(add-hook 'org-agenda-finalize-hook 'org-agenda-to-appt)
(use-package ob-mermaid :straight t)

(use-package org-tree-slide
  :straight t
  :defer t)
(use-package moom
  :straight t
  :config
  (moom-mode 1)
  (with-eval-after-load 'org
    (add-hook 'moom-font-after-resize-hook #'org-redisplay-inline-images)))
(use-package visual-fill-column :straight t)

(setq visual-fill-column-width 110
      visual-fill-column-center-text t)

(defvar my/org-present-remappings nil)

(defun my/org-present-start ()
  (setq-local visual-fill-column-width 110)
  (setq-local visual-fill-column-center-text t)
  (setq cursor-type nil)
  (org-tree-slide-presentation-profile) ;; hides drawers, blank lines between slides
  (visual-fill-column-mode 1)
  (visual-line-mode 1)
  (org-display-inline-images)
  (display-line-numbers-mode -1)
  (run-with-timer 0.3 nil
    (lambda ()
      (setq my/org-present-remappings
            (list
             (face-remapping-add-relative 'default '(:height 2.0) 'variable-pitch)
             (face-remapping-add-relative 'header-line '(:height 4.0) 'variable-pitch)
             (face-remapping-add-relative 'org-document-title '(:height 1.75))
             (face-remapping-add-relative 'org-code '(:height 1.55))
             (face-remapping-add-relative 'org-verbatim '(:height 1.55))
             (face-remapping-add-relative 'org-block '(:height 1.25))
             (face-remapping-add-relative 'org-block-begin-line '(:height 0.7))))
      (font-lock-flush))))

(defun my/org-present-end ()
  (visual-fill-column-mode 0)
  (visual-line-mode 0)
  (setq cursor-type t)
  (org-remove-inline-images)
  (display-line-numbers-mode 1)
  (dolist (cookie my/org-present-remappings)
    (face-remapping-remove-relative cookie))
  (setq my/org-present-remappings nil))

(add-hook 'org-tree-slide-play-hook 'my/org-present-start)
(add-hook 'org-tree-slide-stop-hook 'my/org-present-end)
;; org babel stuff
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (R . t)
   (scheme . t)
   (mermaid . t)))
;; add bullets instead of asteriks 
(use-package org-bullets :straight t)
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook 'visual-line-mode)

;; Org roam
(use-package org-roam
  :straight t
  :custom
  (org-roam-directory "~/org/roam/")
  (org-roam-completion-everywhere t)
  :config
  (org-roam-db-autosync-mode))

(use-package org-roam-ui
  :straight t
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t       ;; match your Emacs theme
        org-roam-ui-follow t           ;; graph follows your cursor
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil))

(use-package consult-org-roam
  :straight t
  :after org-roam
  :init (consult-org-roam-mode 1)
  :config
  (setq consult-org-roam-grep-func #'consult-grep))

;; Org roam properties search helpers
(cl-defmethod org-roam-node-ECO ((node org-roam-node))
  (or (cdr (assoc "ECO" (org-roam-node-properties node) #'string-equal)) ""))

(cl-defmethod org-roam-node-SW ((node org-roam-node))
 (or (cdr (assoc "SW" (org-roam-node-properties node) #'string-equal)) ""))

(setq org-roam-node-display-template
      (concat "${title:30} "
	      (propertize "${tags:25} " 'face 'org-tag)
              (propertize " ${ECO:10}" 'face 'org-tag)
              (propertize " ${SW:10} "  'face 'org-tag)))

(provide 'org-config)
