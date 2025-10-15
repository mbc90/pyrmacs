;; Enable Vertico
(use-package vertico
  :straight t
  :custom
   ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init 
  (vertico-mode))

(use-package orderless
  :straight t
  :init
  (setq completion-styles '(orderless partial-completion basic)
        completion-category-defaults nil
        completion-category-overrides nil)
  ;; :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  ;; (completion-styles '(orderless partial-completion basic))
  ;; (completion-category-overrides '((file (styles partial-completion))))
  ;; (completion-category-defaults nil) ;; Disable defaults, use our settings
  ;; (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring
  )
;; Enable Consult
(use-package consult 
  :straight t
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init)

;; Corfu Completion 
(use-package corfu
  :straight t
  ;; Optional customizations
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0)
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  :init

  ;; Recommended: Enable Corfu globally.  Recommended since many modes provide
  ;; Capfs and Dabbrev can be used globally (M-/).  See also the customization
  ;; variable `global-corfu-modes' to exclude certain modes.
  (global-corfu-mode)

  ;; Enable optional extension modes:
  (corfu-history-mode)
  (corfu-popupinfo-mode))
;;Cape completion
(use-package cape
  :straight t
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>,
  :init

  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :straight t 
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))


;; Navigiation packages
(use-package avy
  :straight t)
(use-package treemacs
  :straight t)

;; modeline
(use-package doom-modeline
  :straight t
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 30
	doom-modeline-bar-width 5
	doom-modeline-persp-name t
	doom-modeline-icon t
	doom-modeline-persp-icon t))

;; add indent guides
(use-package indent-guide
  :defer t
  :straight t
  :ensure t
  :hook
  (prog-mode . indent-guide-mode)  ;; Activate indent-guide in programming modes.
  :config
  (setq indent-guide-char "│"))
;; Pulsar: highlights last action to make it easier to understand what you did
(use-package pulsar
  :defer t
  :straight t
  :ensure t
  :hook
  (after-init . pulsar-global-mode)
  :config
  (setq pulsar-pulse t)
  (setq pulsar-delay 0.025)
  (setq pulsar-iterations 10)
  (setq pulsar-face 'evil-ex-lazy-highlight)
  (add-to-list 'pulsar-pulse-functions 'evil-scroll-down)
  (add-to-list 'pulsar-pulse-functions 'evil-yank)
  (add-to-list 'pulsar-pulse-functions 'evil-yank-line)
  (add-to-list 'pulsar-pulse-functions 'evil-delete)
  (add-to-list 'pulsar-pulse-functions 'evil-delete-line)
  (add-to-list 'pulsar-pulse-functions 'evil-jump-item))

(use-package dired
  :custom
  (setf dired-listing-switches "-lah --group-directories-first") ;; group directories and make dired a bit more readable. Does not work on MacOS. need GNU ls
  (setf dired-kill-when-opening-new-dired-buffer t)) ;; stop dired from opening so many buffers

;; Nerd Icons for all my stuff
;; add icons to corfu
(use-package nerd-icons-corfu
  :straight t
  :ensure t
  :after corfu)
(use-package nerd-icons-dired
  :straight t
  :ensure t                               ;; Ensure the package is installed.
  :defer t                                ;; Load the package only when needed to improve startup time.
  :hook
  (dired-mode . nerd-icons-dired-mode))
(use-package nerd-icons-completion
  :straight t
  :ensure t
  :after (:all nerd-icons marginalia)
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))



;; Emacs minibuffer configurations.
(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (text-mode-ispell-word-completion nil)
  (minibuffer-prompt-properties
  '(read-only t cursor-intangible t face minibuffer-prompt)))


(provide 'user-interface)
