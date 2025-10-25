;;;Lsp and other stuff
(use-package lsp-mode
  :straight t
  :custom
  (lsp-completion-provider :none) ;; use corfu, not company
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
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
(use-package rust-mode :straight t)
;; Hook to load lsp-mode when entering a rust file
(add-hook 'rust-mode-hook #'lsp)

;; Go
(use-package go-mode :straight t)
(add-hook 'go-mode-hook #'lsp)

;; swift
(use-package swift-mode :straight t)

(use-package lsp-sourcekit
  :straight t
  :defer t
  :after lsp-mode
  :config
  (setq lsp-sourcekit-executable "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"))
(add-hook 'swift-mode-hook #'lsp)

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


(provide 'programming)
