;;; init.el --- . -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; STRAIGHT
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


;;; ENVIRONMENT
(use-package exec-path-from-shell)
;; (dolist (var '(""))
;;   (add-to-list 'exec-path-from-shell-variables var))
;; Only when executed in a GUI frame on OS X and Linux.
;; Set $MANPATH, $PATH
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
;; and Daemon
(when (daemonp)
  (exec-path-from-shell-initialize))


;;; SECRETS
(setq auth-sources '("~/vault/authinfo.gpg"))


;;; EVIL
(use-package evil
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil)
  :config
  (evil-mode 1))
(setq windmove-wrap-around t)
(global-set-key (kbd "C-h") #'evil-windmove-left)
(global-set-key (kbd "C-j") #'evil-windmove-down)
(global-set-key (kbd "C-k") #'evil-windmove-up)
(global-set-key (kbd "C-l") #'evil-windmove-right)
(use-package evil-collection
  :config
  (evil-collection-init))


;;; GDB
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

;;; FLYMAKE
;; (use-package flymake
;;   :straight nil
;;   :hook
;;   (prog-mode-hook .
;; 		  (lambda ()
;; 		    (flymake-mode)
;; 		    (set-face-attribute 'flymake-error nil :underline nil)
;; 		    (set-face-attribute 'flymake-warning nil :underline nil)
;; 		    (set-face-attribute 'flymake-note nil :underline nil)
;; 		    (setq flymake-show-diagnostics-at-end-of-line nil)
;; 		    (setq flymake-note-bitmap nil)
;; 		    (setq flymake-fringe-indicator-position nil))))


;;; SNIPPETS
(use-package yasnippet
  :hook
  (prog-mode . yas-minor-mode)
  (text-mode . yas-minor-mode)
  :config
  (yas-reload-all))

;;; AUTO COMPLETION
(use-package corfu
  :init
  (global-corfu-mode t))

;;; UNDO
(use-package undo-fu)
(use-package undo-fu-session
  :after undo-fu
  :config
  (undo-fu-session-global-mode))

;;; VERTICO
(use-package vertico
  :init
  (vertico-mode)
  :custom
  (vertico-count 15)
  (vertico-cycle nil)
  (vertico-resize nil)
  (vertico-scroll-margin 0))
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))
;; Add richer metadata display
;; Show additional info like file size/type
(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))
;; Flexible completion style
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles basic partial-completion)))))
;; Remove directory when pressing DEL in vertico path.
(use-package vertico-directory
  :after vertico
  :straight nil
  :bind (:map vertico-map
	      ("DEL" . vertico-directory-delete-char)
	      ("M-DEL" . vertico-directory-delete-word)))
(use-package consult
  :init
  (setq consult-ripgrep-args "rg --no-ignore --null --line-buffered --color=never --max-columns=1000 --path-separator /   --smart-case --no-heading --with-filename --line-number --search-zip")
  (setq consult-fd-args "fd --hidden --no-ignore-vcs --full-path --color=never"))
(use-package recentf
  :init
  (recentf-mode 1)
  :custom
  (recentf-max-saved-items 200)
  (recentf-max-menu-items 25)
  (recentf-auto-cleanup 'never)
  :config
  (add-to-list 'recentf-exclude "\\.git/.*")
  (add-to-list 'recentf-exclude "/tmp/")
  (add-to-list 'recentf-exclude "recentf"))

(setq make-backup-files nil
      auto-save-default nil)

;; Turn off global line numbers by default
(setq display-line-numbers nil)

;; Enable relative line numbers in prog-mode (all programming modes)
(add-hook 'prog-mode-hook
          (lambda ()
            (setq display-line-numbers 'relative)
            (display-line-numbers-mode 1)))

(setq scroll-margin 8
      scroll-conservatively 101)

(use-package emacs
  :custom
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (context-menu-mode t)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))


;;; TERMINAL
;; -> ESHELL
(with-eval-after-load 'eshell
  (evil-define-key 'insert eshell-mode-map
    (kbd "C-p") #'eshell-previous-input
    (kbd "C-n") #'eshell-next-input))


;;; PROJECT
(use-package projectile
  :init
  (setq projectile-project-search-path '("~/codes"))
  (setq projectile-completion-system 'auto)
  :config
  (projectile-mode +1)
  (setq projectile-enable-caching t) ; Optional: cache projects for speed
  (setq projectile-globally-ignored-directories
        '(".git" "node_modules" "dist" "build")))

;;; GIT
(use-package magit)
(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))


;;; ORG
(use-package org
  :straight nil
  :custom
  (org-directory "~/org")
  (org-hide-emphasis-markers t)
  (org-startup-indented t))


;;; MODELINE
(use-package doom-modeline
  :config
  (doom-modeline-mode)
  (setq doom-modeline-height 0)
  (setq doom-modeline-bar-width 0)
  (setq doom-modeline-buffer-file-name-style 'relative-from-project)
  (setq doom-modeline-icon nil)
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-percent-position '(-3 ""))
  (setq doom-modeline-position-line-format '("")))


;;; KEYMAPS
(use-package general
  :config
  (general-override-mode)
  (general-def 'normal 'override
    "C-h" 'evil-window-left
    "C-j" 'evil-window-down
    "C-k" 'evil-window-up
    "C-l" 'evil-window-right
    )
  (general-create-definer my/leader
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")
  (my/leader
    ;; FILES
    "f" '(:ignore t :which-key "files")
    "r" '(recentf :which-key "recent")
    "ff" '(find-file :which-key "find file")
    "fg" '(consult-ripgrep :which-key "ripgrep")
    "fc" '(copy-file :which-key "copy file")
    "fr" '(rename-file :which-key "rename file")
    "fd" '(delete-file :which-key "delete file")
    ;; PROJECTS
    "pf" '(projectile-switch-project :which-key "find project")
    "pk" '(projectile-kill-buffers :which-key "kill project")
    ;; BUFFERS
    "b" '(:ignore t :which-key "buffers")
    "bb" '(consult-buffer :which-key "switch")
    "bd" '(kill-current-buffer :which-key "kill current buffer")
    "bk" '(kill-buffer :which-key "kill buffers")
    "bw" '(save-buffer :which-key "save buffer")
    ;; EGLOT
    "e" '(:ignore t :which-key "eglot")
    "ee" '(eglot :which-key "start eglot")
    "ed" '(eglot-shutdown :which-key "shutdown eglot")
    "er" '(eglot-rename :which-key "eglot rename")
    ;; DIAGNOSTICS/DEBUG/DIRED
    "d" '(:ignore t :which-key "diagnostic")
    "ds" '(consult-flymake :which-key "show diagnostics")
    "da" '(eglot-code-action-quickfix :which-key "apply quickfix")
    "dd" '(dired-jump :which-key "dired")
    ;; WINDOWS
    "w" '(:ignore t :which-key "window")
    "wd" '(delete-window :which-key "close window")
    "wh" '(split-window-vertically :which-key "split window vertically")
    "wv" '(split-window-horizontally :which-key "split window horizontally")
    "." '(maximize-window :which-key "maximize window")
    "," '(balance-windows :which-key "balance windows")
    ;; ORG
    "o" '(:ignore t :which-key "org")
    "ol" '(org-insert-link :which-key "insert link")
    "oo" '(org-open-at-point :which-key "open link")
    ;; GIT
    "g" '(:ignore t :which-key "magit")
    "gg" '(magit :which-key "magit-status")
    "gs" '(magit-stage-files :which-key "magit-stage-files")
    ;; VARIOUS
    "l" '(execute-extended-command :which-key "execute command")
    "c" '(compile :which-key "compile")
    "m" '(consult-man :which-key "man pages")
    "t" '(eshell :which-key "open eshell")))

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.75)
  (setq which-key-idle-secondary-delay 0.05)
  (setq which-key-popup-type 'side-window)
  (setq which-key-side-window-location 'right))


;;; COMMENTS
(use-package evil-commentary
  :config
  (evil-commentary-mode))


;;; ICONS
;;; NOTE: exec all-the-icons-install-fonts
(use-package all-the-icons)


;;; TODO
(use-package hl-todo
  :config (global-hl-todo-mode))


;;; FONT
(add-to-list 'default-frame-alist
             '(font . "CaskaydiaCove Nerd Font-14"))


;;; FORMATTING
(use-package format-all
  :config
  (setq format-all-show-errors 'never)
  (setq format-all-formatters
	'(("Shell" (shfmt "-i" "4" "-ci"))
	  ("C" (clang-format))
	  ("Python" (ruff))
	  )))
(add-hook 'format-all-mode-hook 'format-all-ensure-formatter)
(add-hook 'prog-mode-hook 'format-all-mode)


;;; FEED
(use-package elfeed
  :config
  (setq elfeed-feeds
	'("http://nullprogram.com/feed/"
          "https://planet.emacslife.com/atom.xml")))


;;; THEME
(load-theme 'modus-vivendi)


;; VARIOUS SETTINGS
(setq display-line-numbers-type 'relative)
(global-visual-line-mode)
(add-hook 'before-save-hook #'delete-trailing-whitespace)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t
      ring-bell-function 'ignore
      use-dialog-box nil
      confirm-kill-emacs 'y-or-n-p)


;;; MULTIMEDIA
;; (use-package empv
;;   :config
;;   (setq empv-video-dir "~/video")
;;   (setq empv-audio-dir "~/music"))


;;; DIRED
(use-package dired-open
  :config
  (setq dired-open-extensions
	'(("mp4" . "mpv")
	  ("mkv" . "mpv")
	  ("avi" . "mpv")
	  ("webm" . "mpv")
	  ("mov" . "mpv"))))


;;; DASHBOARD
;; use-package with package.el:
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-startupify-list '(dashboard-insert-items))
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-set-heading-icons nil)
  (setq dashboard-set-file-icons nil)
  (setq dashboard-week-agenda t)
  (setq dashboard-items '((recents   . 5)
                          (bookmarks . 5)
                          (projects  . 5)
                          (agenda    . 5))))

;;; SYNTAX
;;; NIX
(use-package nix-mode
  :mode "\\.nix\\'")

;;; WRAPPERS
;; Use mpv to open youtube links instead of a web browser.
;; (defun my/browse-url-mpv (url &optional _new-window)
;;   "Open YouTube URLs with mpv, everything else with the default browser."
;;   (if (string-match-p
;;        (regexp-opt '("youtube.com"))
;;        url)
;;       (start-process "mpv" nil "mpv" url)
;;     (browse-url-default-browser url)))
;; (advice-add 'browse-url :override #'my/browse-url-mpv)


;;; init.el ends here
