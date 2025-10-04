;;;Lsp and other stuff
(use-package lsp-mode
  :straight t
  :custom
  (lsp-completion-provider :none) ;; use corfu, not company
  :commands (lsp lsp-deferred)
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
	  '(orderless)))
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :hook
  (lsp-completion-mode . my/lsp-mode-setup-completion)
  :config
  (lsp-enable-which-key-integration t))
;; Rust
(use-package rust-mode :straight t)
;; Hook to load lsp-mode when entering a rust file
(add-hook 'rust-mode-hook #'lsp)
;;---------

(provide 'programming)
