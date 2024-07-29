(context-menu-mode)                                   ; show context menu on right click
(column-number-mode)                                  ; display position on modeline
(global-visual-line-mode t)                           ; wrap lines
(global-auto-revert-mode)
(setq blink-cursor-mode nil)
(add-hook 'prog-mode-hook 'hs-minor-mode)             ; enable folding
(add-hook 'TeX-mode-hook 'hs-minor-mode)              ; enable folding for latex mode

(setq-default savehist-mode t)                                       ; persist history over emacs restarts
(setq-default tab-width 2
              ;; display-line-numbers-type 'relative
              use-short-answers t                     ; Replace yes/no prompts with y/n
              confirm-nonexistent-file-or-buffer nil) ; Ok to visit non existent files

(setq visible-bell '1)                                ; use visible bell instead of beep
;; (recentf-mode 1)                                      ; Allow storing of recent files list
;; (setq recentf-max-menu-items 25)
;; (setq recentf-max-saved-items 50)

;; get latest version
(setq straight-repository-branch "develop")

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; install package using straight if not installled
(setq straight-use-package-by-default 't)
;; integrate with use-package
(straight-use-package 'use-package)
;; to change git protocol
;; (straight-vc-git-default-protocol 'ssh)

;; (require 'package)
;; (add-to-list 'package-archives
;;       '("melpa" . "https://melpa.org/packages/") t)

;; (package-refresh-contents)
;; M-x package-install RET use-package RET

(use-package general
  :init
  (setq general-override-states '(insert
                                  emacs
                                  hybrid
                                  normal
                                  visual
                                  motion
                                  operator
                                  replace))
  :config
  (general-create-definer my/leader
    ;; :keymaps '(normal insert visual emacs override)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (general-create-definer my/ctrl-c
    :prefix "C-c"))

(my/leader :states 'normal :kemaps 'override
  "."    '(find-file :which-key "find file")
  "SPC"  (general-simulate-key "M-x" :which-key "M-x") 
  "p"    (general-simulate-key "C-x p" :which-key "project"))

(general-def :states 'normal
	"RET" 'evil-collection-unimpaired-insert-newline-below
  "j"   'evil-next-visual-line
  "k"   'evil-previous-visual-line)

;; required as during daemon initialization, there are no frames
;; (use-package modus-themes
;;  :config
;;  (load-theme 'modus-vivendi-tinted t))
;; (use-package gruvbox-theme
;;   :config
;;   (load-theme 'gruvbox-dark-medium t))

(use-package sublime-themes)
(load-theme 'junio t)

(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)

;; set the default encoding system
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-completion
  :after all-the-icons
  :config (all-the-icons-completion-mode))

;; (use-package all-the-icons-dired
;;   :if (display-graphic-p)
;;   :hook (dired-mode . all-the-icons-dired-mode))

;; run the below command to install fonts
;; (all-the-icons-install-fonts)

;; (set-face-attribute 'default nil :family "Iosevka Fixed SS07" :height 135)
;; (set-face-attribute 'font-lock-comment-face nil
;;                     :family "Iosevka Fixed SS07"
;;                     :height 135
;;                     :slant 'italic)

;; (set-face-attribute 'font-lock-keywod-face nil
;;                     :family "Source Code Pro"
;;                     :height 140
;;                     :slant 'italic)

(use-package no-littering)

(use-package evil
  :init
  (setq evil-want-keybinding nil) ;; required by evil-collection
  :custom
  (evil-shift-width 2)
  (evil-want-find-undo t) ;; insert mode undo steps as per emacs
  (evil-undo-system 'undo-redo) ;; use native commands in emacs 28
  :config
  (evil-mode 1)
  ;; replace <C-z> with <C-x C-z> to use <C-z> to suspend frame instead
  (define-key evil-motion-state-map (kbd "C-z") 'suspend-frame)
  (define-key evil-motion-state-map (kbd "C-x C-z") 'evil-emacs-state)
  (define-key evil-emacs-state-map (kbd "C-z") 'suspend-frame)
  (define-key evil-emacs-state-map (kbd "C-x C-z") 'evil-exit-emacs-state)
  ;; make <C-z> emulate vim in insert/replace mode 
  (define-key evil-insert-state-map (kbd "C-z") (kbd "C-q C-z"))
  (define-key evil-insert-state-map (kbd "C-x C-z") 'evil-emacs-state)
  (define-key evil-replace-state-map (kbd "C-z") (kbd "C-q C-z"))
  )

(use-package evil-collection
  :after evil
  :custom (evil-collection-setup-minibuffer t)
  :init (evil-collection-init))

(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :general
  (:states 'normal :keymaps 'dired-mode-map
    "l"  'dired-find-file
    "h"  'dired-up-directory)
  (:states 'normal :keymaps 'dirvish-mode-map
    "g?"  'dirvish-dispatch
    "a"   'dirvish-quick-access
    "f"   'dirvish-file-info-menu
    "o"   'dirvish-quicksort
    "q"   'dirvish-quit
    "v"   'dirvish-vc-menu
    "y"   'dirvish-yank-menu
    "N"   'dirvish-narrow
    "H"   'dirvish-history-last
    "L"   'dirvish-history-jump
    "TAB" 'dirvish-subtree-toggle
    "M-f" 'dirvish-history-go-forward
    "M-b" 'dirvish-history-go-backward
    "M-l" 'dirvish-ls-switches-menu
    "M-m" 'dirvish-mark-menu
    "M-t" 'dirvish-layout-toggle
    "M-s" 'dirvish-setup-menu
    "M-e" 'dirvish-emerge-menu
    "M-j" 'dirvish-fd-jump)
  :custom
  (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
   '(("h" "~/"                          "Home")
     ("d" "~/Downloads/"                "Downloads")
     ("c" "~/Documents/Courses/Aug23/"  "Courses")
     ("s" "~/.local/src"                "Sources")
     ("m" "/mnt/"                       "Drives")
     ("t" "~/.local/share/Trash/files/" "TrashCan")))
  :config
  (dirvish-peek-mode) ; Preview files listed in minibuffer
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index)))
  (setq dirvish-attributes
        '(all-the-icons file-time file-size collapse subtree-state vc-state git-msg))
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group"))

(setq dired-auto-revert-buffer t)
(setq dired-mouse-drag-files t)                   ; added in Emacs 29
(setq mouse-drag-and-drop-region-cross-program t) ; added in Emacs 29


(setq mouse-1-click-follows-link nil)
(define-key dirvish-mode-map (kbd "<mouse-1>") 'dirvish-subtree-toggle-or-open)
(define-key dirvish-mode-map (kbd "<mouse-2>") 'dired-mouse-find-file-other-window)
(define-key dirvish-mode-map (kbd "<mouse-3>") 'dired-mouse-find-file)


(use-package sudo-edit)

(use-package magit)

(use-package company
  :custom (company-minimum-prefix-length 1)
  :config (global-company-mode)
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  :custom
	(company-idle-delay 0.5))

;; company front-end with icons
(use-package company-box
  :hook (company-mode . company-box-mode))

;; (use-package copilot
;;   :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
;;   :general
;;   (:states 'insert :keymaps 'copilot-mode-map
;;            "M-h"  'copilot-complete
;;            "M-n"  'copilot-next-completion
;;            "M-p"  'copilot-previous-completion
;;            "M-l"  'copilot-accept-completion-by-word
;;            "M-j"  'copilot-accept-completion-by-line
;;            "M-<return>"  'copilot-accept-completion))

;; (add-hook 'prog-mode-hook 'copilot-mode)

(use-package vertico
  :init (vertico-mode)
	:config
	:general
	(:states 'insert :keymaps 'vertico-map
					 "M-j" 'vertico-next
					 "M-k" 'vertico-previous)
  :custom (vertico-cycle t))

(use-package orderless
  :config (setq orderless-component-separator "[ &]") ; to search with multiple components in company
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides
   '((file (styles basic partial-completion)))))

(use-package marginalia
  :init (marginalia-mode)
  ;; :config (add-hook 'marginalia-mode-hook
  ;;                   #'all-the-icons-completion-marginalia-setup)
  )

(use-package consult
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-recent-file
   consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
)

(use-package evil-surround
  :config (global-evil-surround-mode 1))

(use-package helpful
  :commands (helpful-callable   ; for functions and macros
            helpful-function    ; for functions only
            helpful-macro
            helpful-command     ; for interactive functions
            helpful-key
            helpful-variable
            helpful-at-point)
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap Info-goto-emacs-command-node] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key)
  ([remap describe-variable] . helpful-variable)
  ([remap display-local-help] . helpful-at-point))

(use-package which-key
  :config (which-key-mode))

(use-package pdf-tools)

(use-package multi-term)

(use-package markdown-mode)

(use-package tex
  :straight auctex
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-PDF-mode t)
  (preview-auto-cache-preamble t)
  ;; (TeX-view-program-selection '((output-pdf "xdg-open")))
  (TeX-source-correlate-method (quote synctex))
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-start-server t)
  (TeX-view-program-selection '((output-pdf "PDF Tools")))
  (TeX-output-dir "output")
  :config
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer)
  (setq-default TeX-master nil))

(setq evil-symbol-word-search t)

(use-package evil-visualstar)
(global-evil-visualstar-mode)


;; ------------ Custom Commands -------------------

(set-face-attribute 'default nil :height 150)
(setq default-frame-alist '((undecorated . t)))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(use-package key-chord
  :config
    (setq key-chord-two-keys-delay 0.5)
    (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
    (key-chord-mode 1))

(define-key evil-normal-state-map (kbd "C-q") 'evil-window-delete)

(define-key evil-normal-state-map (kbd "C-h") 'evil-prev-buffer)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-vsplit)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-split)
(define-key evil-normal-state-map (kbd "C-l") 'evil-next-buffer)

(define-key evil-normal-state-map (kbd "M-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "M-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "M-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "M-l") 'evil-window-right)

(define-key evil-normal-state-map (kbd "M--") 'evil-window-decrease-height)
(define-key evil-normal-state-map (kbd "M-=") 'evil-window-increase-height)
(define-key evil-normal-state-map (kbd "M-<") 'evil-window-decrease-width)
(define-key evil-normal-state-map (kbd "M->") 'evil-window-decrease-width)

(menu-bar-mode -1)
(tool-bar-mode -1) 

(setq-default display-line-numbers 'relative)

(recentf-mode 1)
(add-hook 'after-init-hook 'recentf-load-list)

;; Clashes with evil normal state map
;; (define-key dired-mode-map (kbd "<tab>") 'dirvish-layout-toggle)

(define-key evil-normal-state-map (kbd "<tab>") 'consult-recent-file)
(define-key evil-normal-state-map (kbd "C-<tab>") 'consult-buffer)

(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

(setq initial-scratch-message nil)
(setq inhibit-startup-screen t)

;; (load-file "~/.config/emacs/custom_splash.el")
;; (when (< (length command-line-args) 2)
;;   (add-hook 'emacs-startup-hook (lambda ()
;;                                   (when (display-graphic-p)
;;                                     (ar/show-welcome-buffer)))))
