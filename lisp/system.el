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



;; Alternative 2: Enable Jinx per mode
(dolist (hook '(org-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'jinx-mode))

;; Eat for term
(use-package eat :straight t)

(use-package vterm
  :straight t)
(use-package vterm-toggle
  :straight t
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (add-to-list 'display-buffer-alist
	       '((lambda (buffer-or-name _)
                   (let ((buffer (get-buffer buffer-or-name)))
                     (with-current-buffer buffer
                       (or (equal major-mode 'vterm-mode)
                           (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                (display-buffer-reuse-window display-buffer-at-bottom)
                ;;(display-buffer-reuse-window display-buffer-in-direction)
                ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                ;;(direction . bottom)
                ;;(dedicated . t) ;dedicated is supported in emacs27
                (reusable-frames . visible)
                (window-height . 0.3))))


;; tramp for ssh file editing
(setq tramp-default-method "ssh")
;; Direnv - best for flake/podman devolper enviroments

(provide 'system)
