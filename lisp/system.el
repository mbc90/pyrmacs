;; stop backup and lock files
(setq make-backup-files nil)
(setq create-lockfiles nil)

(use-package exec-path-from-shell
  :straight t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Magit
(use-package magit :straight t)

;; Jinx spell check
(use-package jinx :straight t)

;; tramp for ssh file editing
(setq tramp-default-method "ssh")

;; Alternative 2: Enable Jinx per mode
(dolist (hook '(org-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'jinx-mode))
;; Direnv - best for flake/podman devolper enviroments

(provide 'system)
