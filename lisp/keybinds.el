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

;; EVIL surround allos changing the surrounding char.
;; Example: 'Hello, World!' -> cs'" "Hello,World!"
;; cs<current char><new char>
(use-package evil-surround
  :ensure t
  :straight t
  :after evil-collection
  :config
  (global-evil-surround-mode 1))
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
    "="     '(perspective-map :which-key "Perspective")
    ;;toggles
    "t"     '(:ignore t :which-key "toggles")
    "t t"   '(consult-theme :which-key "Choose Theme")
    "t v"   '(vterm-toggle :which-key "vterm")
    "t m"   '(treemacs :which-key "treemacs")
    ;;  manage windows
    "w"     '(:ignore w :which-key "Window")
    "w d"   '(delete-window :which-key "Delete Window")
    "w l"   '(windmove-right :which-key "Move focus right")
    "w h"   '(windmove-left :which-key "Move focus left")
    "w k"   '(windmove-up :which-key "Move focus up")
    "w j"   '(windmove-down :which-key "Move focus down")
    "w L"   '(buf-move-right :which-key "Move right")
    "w H"   '(buf-move-left :which-key "Move left")
    "w K"   '(buf-move-up :which-key "Move up")
    "w J"   '(buf-move-down :which-key "Move down")
    "w v"   '(split-window-right :which-key "v-split")
    "w s"   '(split-window-below :which-key "h-split")
    ;; find stuff
    "f"     '(:ignore f :which-key "Find")
    "f f"   '(find-file :which-key "Find file")
    "f s"   '(consult-line :which-key "Go to line")
    "f i"   '(avy-goto-char-timer :which-key "Avy goto")
    "f w"   '(avy-goto-word-0 :which-key "Avy goto word")
    "f g"   '(consult-grep :which-key "Grep Project")
    ;; Buffer stuff
    "b"     '(:ignore b :which-key "Buffer")
    "b b"   '(consult-buffer :which-key "Switch Buffer")
    "b i"   '(ibuffer :which-key "ibuffer")
    "b d"   '(kill-current-buffer :which-key "Delete Buffer")
    "b ["   '(previous-buffer :which-key "Previous Buffer")
    "b ]"   '(next-buffer :which-key "Next Buffer")
    ;; org mode things
    "o"     '(:ignore o :which-key "Org mode")
    "o s"   '(org-tree-slide-mode :which-key "Presentation mode")
    "o n"   '(org-tree-slide-move-next-tree :which-key "Next Slide")
    "o p"   '(org-tree-slide-move-previous-tree :which-key "Prev Slide")
    "o m"   '(moom-toggle-frame-maximized :which-key "Maximize for presentation")
    "o e"   '(:ignore e :which-key "Export")
    "o e p" '(org-latex-export-to-pdf :which-key "Export to pdf")
    "o e t" '(org-pandoc-export-to-typst-pdf :which-key "Export to Typst pdf")
    "o r "  '(:ignore r :which-key "Org Roam")
    "o r t" '(org-roam-buffer-toggle :which-key "Buffer Toggle")
    "o r f" '(org-roam-node-find :which-key "Node Find")
    "o r i" '(org-roam-node-insert :which-key "Node Insert")
    "o a"   '(org-agenda :which-key "Org Agenda")
    ;; reload
    "r "    '(:ignore r :which-key "Reload")
    "r r"   '(eval-buffer "~/.emacs.d/init.el" :which-key "Reload Config")
    ;; Git stuff
    "g"     '(:ignore g :which-key "Git")
    "g g"   '(magit-status :which-key "Magit Status")
    ;; treemacs
    "p"     '(:ignore g :which-key "Treemacs/Projects")
    "p t"   '(treemacs :which-key "Toggle Treemacs")
    "p a"   '(treemacs-add-project-to-workspace :which-key "Add project to treemacs")
    "p r"   '(treemacs-remove-project-from-workspace :which-key "Remove project from Treemacs")
    "p w"   '(:ignore w :which-key "Treemacs Workspaces")
    "p w a" '(treemacs-create-workspace :which-key "Create Workspace")
    "p w n" '(treemacs-next-workspace :which-key "Next Workspace")
    "p w s" '(treemacs-switch-workspace :which-key "Switch Worksapce")

    ;; RSS/ Elfeed
    "e" '(:ignore e :which-key "Elfeed/RSS")
    "e e" '(elfeed :which-key "Open Elfeed")
    "e u" '(elfeed-update :which-key "Update Feeds")

    ))




;; Emacs needs this to load elsewhere
(provide 'keybinds)

