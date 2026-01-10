;;; init.el --- . -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil)
  (setq evil-search-module 'evil-search)
  :config
  (evil-mode 1))

(defun my/evil-escape ()
  (interactive)
  (evil-ex-nohighlight)
  (evil-mc-undo-all-cursors)
  (keyboard-quit)) ;; keep it here.

(with-eval-after-load 'evil
  (define-key evil-normal-state-map [escape] #'my/evil-escape)
  (define-key evil-visual-state-map [escape] #'my/evil-escape)
  (define-key evil-motion-state-map [escape] #'my/evil-escape))

(use-package evil-collection
  :config
  (evil-collection-init)
  :custom
  (evil-collection-setup-minibuffer t))

(use-package evil-mc
  :config
  (global-evil-mc-mode 1)
  (evil-define-key 'normal evil-normal-state-map
    (kbd "C-n") #'evil-mc-make-and-goto-next-match
    (kbd "C-p") #'evil-mc-make-and-goto-prev-match
    (kbd "gz") #'evil-mc-make-all-cursors
    (evil-define-key 'normal evil-mc-key-map
      (kbd "C-n") #'evil-mc-make-and-goto-next-match
      (kbd "C-p") #'evil-mc-make-and-goto-prev-match
      (kbd "gz") #'evil-mc-make-all-cursors)))

(setq gdb-many-windows t)
(setq gdb-show-main t)

(with-eval-after-load 'evil
  (dolist (mode '(gdb-mode
                  gdb-breakpoints-mode
                  gdb-locals-mode
                  gdb-frames-mode
                  gdb-inferior-io-mode
                  gdb-registers-mode
                  gdb-memory-mode
                  gdb-disassembly-mode))
    (setq evil-emacs-state-modes
          (delq mode evil-emacs-state-modes))))

(use-package yasnippet
  :hook
  (prog-mode . yas-minor-mode)
  (text-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package undo-fu)

(use-package undo-fu-session
  :after undo-fu
  :config
  (undo-fu-session-global-mode))

(use-package savehist
  :init
  (savehist-mode 1))

;; like nvim flash
(use-package ace-jump-mode)
(evil-define-key 'normal 'global (kbd "f") #'ace-jump-char-mode)

;; Vertico
(use-package vertico
  :init
  (vertico-mode 1)
  :custom
  (vertico-count 5)
  (vertico-cycle nil)
  (vertico-resize nil)
  (vertico-scroll-margin 0))

;; Vertico extension
(use-package vertico-directory
  :after vertico
  :straight nil
  :bind (:map vertico-map
	      ("DEL" . vertico-directory-delete-char)
	      ("M-DEL" . vertico-directory-delete-word)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; I just use it for ripgrep and fdfind/fd.
;; Probably overkill for my needs.
(use-package consult
  :custom
  (consult-ripgrep-args "rg --no-ignore --null --line-buffered --color=never --max-columns=1000 --path-separator /   --smart-case --no-heading --with-filename --line-number --search-zip")
  (consult-fd-args "fdfind --hidden --no-ignore-vcs --full-path --color=never"))

;; Recent files.
(use-package recentf
  :straight nil ;; built-in
  :init
  (recentf-mode 1)
  :custom
  (recentf-auto-cleanup 'never)
  :config
  (add-to-list 'recentf-exclude "\\.git/.*")
  (add-to-list 'recentf-exclude "/tmp/")
  (add-to-list 'recentf-exclude "recentf"))

(use-package emacs
  :straight nil ;; built-in emacs configurations.
  :init
  (setenv "PATH" (concat "/home/simone/.local/bin:" (getenv "PATH")))
  (setenv "PATH" (concat "/home/simone/.cargo/bin:" (getenv "PATH")))
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (make-directory "~/.emacs.d/backups/" t)
  (make-directory "~/.emacs.d/auto-saves/" t)
  ;; Gui Only.
  ;; (set-face-attribute 'default nil
  ;; 		      :family "Monaco Mono Nerd Font"
  ;; 		      :height 140)
  ;; (set-face-attribute 'variable-pitch nil
  ;; 		      :family "Monaco Mono Nerd Font"
  ;; 		      :height 140)
  ;; (set-scroll-bar-mode nil)
  :config
  ;; (add-to-list 'default-frame-alist '(width . 120))
  ;; (add-to-list 'default-frame-alist '(height . 35))
  (set-fringe-mode 0)
  (global-visual-line-mode 1)
  (global-eldoc-mode 0)
  (load-theme 'manoj-dark)
  :hook
  (prog-mode . (lambda ()
		 (setq display-line-numbers 'relative)))
  (before-save . delete-trailing-whitespace)
  :custom
  ;; files and environment
  (exec-path (append '("/home/simone/.local/bin" "/home/simone/.cargo/bin") exec-path))
  (make-backup-files t)
  (backup-directory-alist `((".*" . "~/.emacs.d/backups/")))
  (auto-save-default t)
  (auto-save-interval 300)
  (auto-save-file-name-transforms `((".*" "~/.emacs.d/auto-saves/" t)))
  (auth-sources '("~/vault/authinfo.gpg"))
  ;; Various stuff.
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (ring-bell-function 'ignore)
  (use-dialog-box nil)
  (confirm-kill-emacs 'y-or-n-p)
  ;; Spelling.
  (ispell-program-name "aspell")
  (ispell-dictionary "en_US")
  ;; No mouse allowed.
  (context-menu-mode nil)
  (make-pointer-invisible 1)
  ;; UI releated stuff.
  (display-line-numbers nil)
  (inhibit-startup-message 1)
  (scroll-margin 8)
  (scroll-conservatively 101)
  (save-place-mode 1)
  ;; Modeline.
  (mode-line-format '("%b"))
  ;; Minibuffer.
  (enable-recursive-minibuffers t)
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

;; Terminal settings.
(with-eval-after-load 'eshell
  (evil-define-key 'insert eshell-mode-map
    (kbd "C-p") #'eshell-previous-input
    (kbd "C-n") #'eshell-next-input))

;; Projects.
(use-package projectile
  :custom
  (projectile-project-search-path '("~/codes"))
  (projectile-completion-system 'auto)
  (projectile-mode 1)
  (projectile-enable-caching t)
  (projectile-globally-ignored-directories
   '(".git" "node_modules" "dist" "build")))

(use-package feebleline
  :config
  (feebleline-mode 1))

;; Git.
(use-package magit) ;; built-in
(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))

;; Org.
(use-package org
  :straight nil
  :config
  (setq org-agenda-overriding-header "")
  :custom
  (org-M-RET-may-split-line '((default . nil)))
  (org-insert-heading-respect-content t)
  (org-directory "~/documents/org")
  (org-agenda-files (list org-directory))
  (org-hide-emphasis-markers t)
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-startup-indented t)
  (org-tag-alist '(("home" . ?h)
		   ("work" . ?w)
		   )))

;; Eglot
(use-package eglot
  :straight nil ;; built-in
  :hook
  (eglot-managed-mode . (lambda () (eglot-inlay-hints-mode 0))))

;; Custom functions.
(defun my/disable-visual-lines ()
  (interactive)
  (global-visual-line-mode -1)
  (setq-default truncate-lines 1))

(defun my/enable-visual-lines ()
  (interactive)
  (global-visual-line-mode 1)
  (setq-default truncate-lines 0))

;; Keymaps.
(use-package general
  :config
  (general-create-definer my/leader
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")
  (my/leader
    "," 'balance-windows
    "." 'maximize-window
    "bb" 'switch-to-buffer
    "bd" 'kill-current-buffer
    "bk" 'kill-buffer
    "bw" 'save-buffer
    "c" 'compile
    "da" 'eglot-code-action-quickfix
    "dd" 'dired-jump
    "ds" 'consult-flymake
    "ed" 'eglot-shutdown
    "ee" 'eglot
    "er" 'eglot-rename
    "ei" 'eglot-inlay-hints-mode
    "fc" 'copy-file
    "fd" 'delete-file
    "ff" 'find-file
    "fz" 'consult-fd
    "fg" 'consult-ripgrep
    "fm" 'rename-file
    "fr" 'recentf
    "g" 'magit
    "l" 'execute-extended-command
    "m" 'consult-man
    "ol" 'org-insert-link
    "oo" 'org-open-at-point
    "oa" 'org-agenda
    "oc" 'org-todo
    "ot" 'org-set-tags-command
    "os" 'org-schedule
    "od" 'org-deadline
    "pf" 'projectile-switch-project
    "pk" 'projectile-kill-buffers
    "ve" 'my/enable-visual-lines
    "vd" 'my/disable-visual-lines
    "s" 'async-shell-command
    "t" 'eshell))

;; Use gc to comment.
;; Do not worry about which symbol to use.
(use-package evil-commentary
  :init
  (evil-commentary-mode 1))

;; Highlights TODOs and friends.
(use-package hl-todo
  :init
  (global-hl-todo-mode 1))

;; Best thing ever made.
(use-package format-all
  :hook
  (prog-mode . format-all-mode)
  (format-all-mode . format-all-ensure-formatter)
  :custom
  (format-all-show-errors 'never)
  (format-all-formatters
   '(("Shell" (shfmt "-i" "4" "-ci"))
     ("C" (clang-format))
     ("Python" (ruff))
     )))

;; It removes the modeline and uses the echo area for info.
(use-package feebleline
  :config
  (feebleline-mode 1))

;; News.
(use-package elfeed
  :custom
  (elfeed-feeds
   '("http://nullprogram.com/feed/"
     "https://planet.emacslife.com/atom.xml")))

;; Dired.
(use-package dired-open
  :custom
  (dired-open-extensions
   '(("mp4" . "mpv")
     ("mkv" . "mpv")
     ("avi" . "mpv")
     ("webm" . "mpv")
     ("mov" . "mpv")
     )))

;; Syntax on for .nix
(use-package nix-mode
  :mode "\\.nix\\'")

;;; init.el ends here
