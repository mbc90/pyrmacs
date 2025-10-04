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
;;---------

(provide 'programming)
