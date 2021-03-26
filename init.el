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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(package-selected-packages
   '(evil-tutor org evil-org evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Turn on vim emulation
(evil-mode 1)
;; Use line numbers on all files
(global-display-line-numbers-mode)
;; Disable menubar
(menu-bar-mode -1)

;; Use helm for file search
(define-key (current-global-map) [remap find-file] 'helm-find-files)