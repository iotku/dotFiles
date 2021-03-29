;; Largly based on https://github.com/daviwil/emacs-from-scratch/blob/master/Emacs.org
;; The default is 800 kilobytes.  Measured in bytes.
;; Set GC threshold for perf.
(setq gc-cons-threshold (* 50 4000 4000))
;; The default is 800 kilobytes.  Measured in bytes.
(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

(setq inhibit-startup-message t)

;; Show startup time
(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

; Set home directory to ~
; Set local HOME var on windows...
(setq default-directory (concat (getenv "HOME") "/"))

;; prevent package.el loading packages prior to their init-file loading.
(setq package-enable-at-startup nil)

;; Bootstrap 'straight' package manager
;; https://github.com/raxod502/straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el" ;; pretty sus ngl
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Packages to use
(straight-use-package 'helm)
(straight-use-package 'evil)
(straight-use-package 'magit)
(straight-use-package 'dumb-jump)
(straight-use-package 'no-littering)
(straight-use-package 'doom-themes)
(straight-use-package 'doom-modeline)
(straight-use-package 'highlight-indent-guides)
(straight-use-package 'all-the-icons) ;; Install icons for doom-modeline (probably bloat)
(straight-use-package 'which-key)
(straight-use-package 'sml-mode)
;; Turn on vim emulation
(evil-mode 1)

;; Disable menubar
(menu-bar-mode -1)
(tool-bar-mode -1)
;; (toggle-scroll-bar -1) ;; breaks in nox, probably need to make conditional.

;; Hilight current line
(global-hl-line-mode +1)
;; Use line numbers on all files
(global-display-line-numbers-mode)

;; Keybindings https://www.masteringemacs.org/article/mastering-key-bindings-emacs
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Use helm
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; Hook for dumpjump gd
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
(setq dumb-jump-force-searcher 'rg) ;; use ripgrep

;; Hook for highlight indentation
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(defvar highlight-indent-guides-method 'bitmap) ;; use 'bitmap' guides


;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; Font Settings
(defvar efs/default-font-size 120)
(defvar efs/default-variable-font-size 120)
(set-face-attribute 'default nil :font "Source Code Pro" :height efs/default-font-size)

;; load doom theme
(load-theme 'doom-dracula t)
(defvar doom-modeline-height 15)
(doom-modeline-mode 1)

;; Make frame transparency overridable
; (defvar efs/frame-transparency '(90 . 90))

(which-key-mode)
(setq which-key-idle-delay 1)
;; S-up/down/left/right to switch between visable buffers
(windmove-default-keybindings)
;; Trunicate lines, don't wrap.
(set-default 'truncate-lines t)
(column-number-mode) ;; show line number/column in statusbar
;; Set tabwidth to sane amount
(setq-default tab-width 4) ;; Why would it be anything else?

;; Ruler
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(setq-default display-fill-column-indicator-column 85)

;; Run shell as powershell under windows
(when (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "powershell.exe")
  (setq explicit-powershell.exe-args '()))
