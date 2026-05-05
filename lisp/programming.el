;;;Lsp and other stuff
(use-package lsp-mode
  :straight t
  :init 
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :custom
  (lsp-completion-provider :none) ;; use corfu, not company
  :config
  (lsp-enable-which-key-integration t)
  :commands
  (lsp lsp-deferred))
;; Force corfu to work!!!
(add-hook 'lsp-completion-mode-hook
  (lambda ()
    (setq-local completion-category-defaults
		(assoc-delete-all 'lsp-capf completion-category-defaults))))

;; Rust
(use-package rust-mode :straight t :defer t)
;; Hook to load lsp-mode when entering a rust file
(add-hook 'rust-mode-hook #'lsp)

;; Go
(use-package go-mode :straight t :defer t)
(add-hook 'go-mode-hook #'lsp)

;; swift
(use-package swift-mode :straight t :defer t)

(use-package lsp-sourcekit
  :straight t
  :defer t
  :after lsp-mode
  :config
  (if (eq system-type 'darwin)
      (setq lsp-sourcekit-executable "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp")))
(add-hook 'swift-mode-hook #'lsp)

;; C
(add-hook 'c-mode-hook #'lsp)

;; Zig
(use-package zig-mode :straight t :defer t)
(add-hook 'zig-mode-hook #'lsp)
;;---------
;; Dockerfiles
 (use-package dockerfile-mode
   :straight t
   :defer t
   :config
   (setq dockerfile-docker-command "podman"))
;; Nix
(use-package nix-mode
  :straight t
  :mode "\\.nix\\'")

;; Arduino
(use-package arduino-cli-mode
  :straight t
  :ensure t
  ;; :hook arduino-mode
  :mode "\\.ino\\'"
  :custom
  (arduino-cli-warnings 'all)
  (arduino-cli-verify t))

;; Magit
(use-package magit :straight t :commands magit-status)

;; remove dos linendings
(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;; Make emacs use tabs
  (if (string-equal system-name "LT-C2C3CB4-2025")
      (progn (setq-default indent-tabs-mode t)
       (setq-default tab-width 4)
       (setq-default c-basic-offset tab-width)))


;; Perspective For better project management 
(use-package perspective
  :straight t
  :custom
  (persp-mode-prefix-key (kbd "C-c M-p"))
  :init
  (persp-mode))
(provide 'programming)
