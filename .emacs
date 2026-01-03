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
  (keyboard-quit))

(with-eval-after-load 'evil
  (define-key evil-normal-state-map [escape] #'my/evil-escape)
  (define-key evil-visual-state-map [escape] #'my/evil-escape)
  (define-key evil-motion-state-map [escape] #'my/evil-escape))

(use-package evil-collection
  :config
  (evil-collection-init))

(use-package evil-mc
  :config
  (global-evil-mc-mode 1))

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

(use-package corfu
  :init
  (global-corfu-mode 1))

(use-package undo-fu)

(use-package undo-fu-session
  :after undo-fu
  :config
  (undo-fu-session-global-mode))

(use-package vertico
  :init
  (vertico-mode 1)
  :custom
  (vertico-count 15)
  (vertico-cycle nil)
  (vertico-resize nil)
  (vertico-scroll-margin 0))

(use-package savehist
  :init
  (savehist-mode 1))

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode 1))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico-directory
  :after vertico
  :straight nil
  :bind (:map vertico-map
	      ("DEL" . vertico-directory-delete-char)
	      ("M-DEL" . vertico-directory-delete-word)))

(use-package consult
  :custom
  (consult-ripgrep-args "rg --no-ignore --null --line-buffered --color=never --max-columns=1000 --path-separator /   --smart-case --no-heading --with-filename --line-number --search-zip")
  (consult-fd-args "fd --hidden --no-ignore-vcs --full-path --color=never"))

(use-package recentf
  :init
  (recentf-mode 1)
  :custom
  (recentf-auto-cleanup 'never)
  :config
  (add-to-list 'recentf-exclude "\\.git/.*")
  (add-to-list 'recentf-exclude "/tmp/")
  (add-to-list 'recentf-exclude "recentf"))

(use-package emacs
  :init
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (set-scroll-bar-mode -1)
  (load-theme 'modus-operandi-tinted)
  (set-face-attribute 'default nil
                      :family "CaskaydiaCove Nerd Font"
                      :height 140)
  (set-face-attribute 'variable-pitch nil
                      :family "CaskaydiaCove Nerd Font"
                      :height 140)
  :config
  (add-to-list 'default-frame-alist '(width . 120))
  (add-to-list 'default-frame-alist '(height . 35))
  :hook
  (prog-mode . (lambda ()
		 (setq display-line-numbers 'relative)))

  (before-save . delete-trailing-whitespace)
  :custom
  ;; (make-backup-files nil)
  ;; (auto-save-default nil)
  (auth-sources '("~/vault/authinfo.gpg"))
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (context-menu-mode t)
  (global-visual-line-mode)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (ring-bell-function 'ignore)
  (use-dialog-box nil)
  (inhibit-startup-message t)
  (confirm-kill-emacs 'y-or-n-p)
  (display-line-numbers nil)
  (scroll-margin 8)
  (scroll-conservatively 101)
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

(with-eval-after-load 'eshell
  (evil-define-key 'insert eshell-mode-map
    (kbd "C-p") #'eshell-previous-input
    (kbd "C-n") #'eshell-next-input))

(use-package projectile
  :custom
  (projectile-project-search-path '("~/codes"))
  (projectile-completion-system 'auto)
  (projectile-mode 1)
  (projectile-enable-caching t)
  (projectile-globally-ignored-directories
   '(".git" "node_modules" "dist" "build")))

(use-package magit)
(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))

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

(use-package doom-modeline
  :config
  (doom-modeline-mode)
  (setq doom-modeline-height 0)
  (setq doom-modeline-bar-width 0)
  (setq doom-modeline-buffer-file-name-style 'relative-from-project)
  (setq doom-modeline-icon t)
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-percent-position '(-3 ""))
  (setq doom-modeline-position-line-format '("")))

(use-package general
  :config
  (general-create-definer my/leader
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")
  (my/leader
    "," '(balance-windows :which-key "balance windows")
    "." '(maximize-window :which-key "maximize window")
    "b" '(:ignore t :which-key "buffers")
    "bb" '(consult-buffer :which-key "switch")
    "bd" '(kill-current-buffer :which-key "kill current buffer")
    "bk" '(kill-buffer :which-key "kill buffers")
    "bw" '(save-buffer :which-key "save buffer")
    "c" '(compile :which-key "compile")
    "d" '(:ignore t :which-key "diagnostic")
    "da" '(eglot-code-action-quickfix :which-key "apply quickfix")
    "dd" '(dired-jump :which-key "dired")
    "ds" '(consult-flymake :which-key "show diagnostics")
    "e" '(:ignore t :which-key "eglot")
    "ed" '(eglot-shutdown :which-key "shutdown eglot")
    "ee" '(eglot :which-key "start eglot")
    "er" '(eglot-rename :which-key "eglot rename")
    "f" '(:ignore t :which-key "files")
    "fc" '(copy-file :which-key "copy file")
    "fd" '(delete-file :which-key "delete file")
    "ff" '(find-file :which-key "find file")
    "fg" '(consult-ripgrep :which-key "ripgrep")
    "fm" '(rename-file :which-key "move file")
    "fr" '(consult-recent-file :which-key "recent files")
    "g" '(:ignore t :which-key "magit")
    "gg" '(magit :which-key "magit-status")
    "gs" '(magit-stage-files :which-key "magit-stage-files")
    "l" '(execute-extended-command :which-key "execute command")
    "m" '(consult-man :which-key "man pages")
    "o" '(:ignore t :which-key "org")
    "ol" '(org-insert-link :which-key "insert link")
    "oo" '(org-open-at-point :which-key "open link")
    "oa" '(org-agenda :which-key "agenda")
    "oc" '(org-todo :which-key "cycle todo")
    "ot" '(org-set-tags-command :which-key "tag")
    "pf" '(projectile-switch-project :which-key "find project")
    "pk" '(projectile-kill-buffers :which-key "kill project")
    "t" '(eshell :which-key "open eshell")
    "w" '(:ignore t :which-key "window")
    "wd" '(delete-window :which-key "close window")
    "wh" '(split-window-vertically :which-key "split window vertically")
    "wv" '(split-window-horizontally :which-key "split window horizontally")))

(use-package evil-commentary
  :init
  (evil-commentary-mode 1))

(use-package all-the-icons)

(use-package hl-todo
  :init
  (global-hl-todo-mode 1))

(use-package format-all
  :hook
  (prog-mode . format-all-mode)
  :custom
  (format-all-show-errors 'never)
  (format-all-formatters
   '(("Shell" (shfmt "-i" "4" "-ci"))
     ("C" (clang-format))
     ("Python" (ruff))
     )))

(use-package elfeed
  :custom
  (elfeed-feeds
   '("http://nullprogram.com/feed/"
     "https://planet.emacslife.com/atom.xml")))

(use-package dired-open
  :custom
  (dired-open-extensions
   '(("mp4" . "mpv")
     ("mkv" . "mpv")
     ("avi" . "mpv")
     ("webm" . "mpv")
     ("mov" . "mpv"))))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  :custom
  (initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  (dashboard-center-content t)
  (dashboard-vertically-center-content t)
  (dashboard-display-icons-p t)
  (dashboard-icon-type 'all-the-icons)
  (dashboard-set-file-icons t)
  (dashboard-set-heading-icons t)
  (dashboard-startupify-list '(dashboard-insert-items))
  (dashboard-week-agenda t)
  (dashboard-items '((recents   . 5)
                     (agenda    . 5)))
  (dashboard-item-shortcuts '((recents   . "r")
                              (agenda    . "a")))
  (dashboard-item-names '(("Recent Files:"               . "Recently opened files:")
			  ("Agenda for today:"           . "Today's agenda:")
			  ("Agenda for the coming week:" . "Agenda:"))))


(use-package nix-mode
  :mode "\\.nix\\'")


;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
