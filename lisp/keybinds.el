(use-package evil  
  :straight t
  :init
  (setq evil-want-keybinding nil
  evil-undo-system 'undo-redo)
  :config
  (require 'evil)
  (evil-mode 1))

;; Enable Evil
;; evil collection
(use-package evil-collection
  :straight t
  :after evil
  :ensure t
  :config
  (evil-collection-init))


;; Keybindings 
(keymap-global-set "C-;" #'jinx-correct)
;; which key
(use-package which-key
  :straight t
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
;;buffer-move for better window management 
(require 'buffer-move)
;; keybindings
(use-package general
  :straight t
  :config
  (general-evil-setup)
  (general-create-definer zosmac/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (zosmac/leader-keys
    ;; persp mode
    "=" '(perspective-map :which-key "Perspective")
    ;;toggles
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(consult-theme :which-key "Choose Theme")
    "tv" '(vterm-toggle :which-key "vterm")
    "tm" '(treemacs :which-key "treemacs")
    ;; manage windows
    "w"  '(:ignore w :which-key "Window")
    "wd" '(delete-window :which-key "Delete Window")
    "wl" '(windmove-right :which-key "Move focus right")
    "wh" '(windmove-left :which-key "Move focus left")
    "wk" '(windmove-up :which-key "Move focus up")
    "wj" '(windmove-down :which-key "Move focus down")
    "wL" '(buf-move-right :which-key "Move right")
    "wH" '(buf-move-left :which-key "Move left")
    "wK" '(buf-move-up :which-key "Move up")
    "wJ" '(buf-move-down :which-key "Move down")
    "wv" '(split-window-right :which-key "v-split")
    "ws" '(split-window-below :which-key "h-split")
    ;; find stuff
    "f" '(:ignore f :which-key "Find")
    "ff" '(find-file :which-key "Find file")
    "fs" '(consult-line :which-key "Go to line")
    "fi" '(avy-goto-char-timer :which-key "Avy goto")
    ;; Buffer stuff
    "b"  '(:ignore b :which-key "Buffer")
    "bb" '(consult-buffer :which-key "Switch Buffer")
    "bi" '(ibuffer :which-key "ibuffer")
    "bd" '(kill-current-buffer :which-key "Delete Buffer")
    "b[" '(previous-buffer :which-key "Previous Buffer")
    "b]" '(next-buffer :which-key "Next Buffer")
    ;; org mode things
    "o" '(:ignore o :which-key "Org mode")
    "op" '(org-latex-export-to-pdf :which-key "Export to PDF")
    "or" '(:ignore r :which-key "Org Roam")
    "ort" '(org-roam-buffer-toggle :which-key "Buffer toggle")
    "orf" '(org-roam-node-find :which-key "Node Find")
    "ori" '(org-roam-node-insert :which-key "Node Insert")
    ;; reload
    "r" '(:ignore r :which-key "reload")
    "rr" '(eval-buffer :which-key "reload config")
    ;; Git stuff
    "g" '(:ignore g :which-key "Git")
    "g g" '(magit-status :which-key "Magit Status")
    ))




;; Emacs needs this to load elsewhere
(provide 'keybinds)

