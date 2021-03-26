;; Largly based on https://github.com/daviwil/emacs-from-scratch/blob/master/Emacs.org
;; The default is 800 kilobytes.  Measured in bytes.
;; Set GC threshold for perf.
(setq gc-cons-threshold (* 50 1000 1000))
;; Show startup time
(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; Set home directory to ~
;; Set local HOME var on windows...
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
(straight-use-package 'all-the-icons)
(straight-use-package 'which-key)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(custom-safe-themes
   '("165e3571f414b5f18517431f1fe6d1c7b62a0dad26e781be02ff2b3b91d49f17" default))
 '(package-selected-packages '(evil-tutor org evil-org evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Turn on vim emulation
(evil-mode 1)

(setq inhibit-startup-message t)
;; Disable menubar
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; Hilight current line
(global-hl-line-mode +1)
;; Use line numbers on all files
(global-display-line-numbers-mode)

;; Keybindings https://www.masteringemacs.org/article/mastering-key-bindings-emacs
;; Use helm for file search
; (define-key (current-global-map) [remap find-file] 'helm-find-files)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; Hook for dumpjump gd
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
(setq dumb-jump-force-searcher 'rg) ;; use ripgrep
;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

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
; (doom-modeline-height 15)
(doom-modeline-mode 1)

;; Make frame transparency overridable
(defvar efs/frame-transparency '(90 . 90))

(which-key-mode)
(setq which-key-idle-delay 1)
