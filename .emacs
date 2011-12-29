;; settings of w3m
;; ===================================================
;; =======Temporary Disabled===========
(add-to-list 'load-path "~/.emacs.d/emacs-w3m")
(setq w3m-use-cookies t)
(setq w3m-command-arguments '("-cookie" "-F"))
;; (setq w3m-display-inline-image t)
(setq w3m-home-page "http://php.net")
;;	(setq w3m-home-page "http://www.google.com/ncr")
(require 'w3m-load)

;; settings of color-theme
;; (add-to-list 'load-path "~/elisp")
;; (add-to-list 'load-path "~/.emacs.d/color-theme/")
;; (require 'color-theme)
;; (setq color-theme-is-global t)
;; (color-theme-initialize)
;; (color-theme-lawrence)

;; settings of auto-complete
;; ===================================================

(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete)
(global-auto-complete-mode t)

;; settings of auto-indent
;; ===================================================

(add-hook 'lisp-mode-hook '(lambda ()
			     (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'c-mode-common-hook '(lambda ()
				 (local-set-key (kbd "RET") 'newline-and-indent)))
(setq-default indent-tabs-mode nil)
(setq c-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 4))))
(setq objc-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 4))))
(setq c++-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 4))))
(setq-default c-basic-offset 4)
(setq ruby-indent-level 4)
(setq python-indent-level 4)
(setq-default tab-width 4)

;; settings of auto word wrap
;; ===================================================
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(truncate-partial-width-windows nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; settings of inline display images
;; ===================================================
;; (setq w3m-default-display-inline-images t)

;; settings of shell-mode
;; ===================================================
(setq shell-file-name "/bin/bash")
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)

;; settings of cc-mode (for C/C++)
;; ===================================================
(add-to-list 'load-path "~/.emacs.d/cc-mode/cc-mode-5.31.3")
(require 'cc-mode)

;; settings of bind key-shortcut to goto-line command
(global-set-key (kbd "C-c g") 'goto-line)

;; settings of CEDET
;; ===================================================
(load-file "~/.emacs.d/cedet/common/cedet.el")

;; enable EDE mode
(global-ede-mode 1)

;; enable semantic features
(semantic-load-enable-gaudy-code-helpers)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-idle-completions-mode 1)
(global-semantic-idle-summary-mode 1)

;; work with customerized include folder
(semantic-add-system-include "/usr/local/include" 'c++-mode)
(semantic-add-system-include "/usr/local/include" 'c-mode)

;; name completions and display tags & classes information
(require 'semantic-ia)

;; work with gcc
(require 'semantic-gcc)

;; load semanticdb
(require 'semanticdb)

(global-set-key (kbd "C-x g") 'semantic-ia-fast-jump)
;; settings of linum-mode
;; (global-linum-mode 1)
;; (put 'upcase-region 'disabled nil)

;; settings of html-helper-mode
(add-to-list 'load-path "~/.emacs.d/html-helper-mode")
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.asp$" . html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.php$" . html-helper-mode) auto-mode-alist))

;; load .emacs.d/miscs into path, prepared for single .el file
(add-to-list 'load-path "~/.emacs.d/miscs")

;; php-mode
(require 'php-mode)

;; php-completion

;; search in region
;; (defun isearch-forward-region-cleanup ()
;;   "turn off variable, widen"
;;   (if isearch-forward-region
;;       (widen))
;;   (setq isearch-forward-region nil))
;; (defvar isearch-forward-region nil
;;   "variable used to indicate we're in region search")
;; (add-hook 'isearch-mode-end-hook 'isearch-forward-region-cleanup)
;; (defun isearch-forward-region (&optional regexp-p no-recursive-edit)
;;   "Do an isearch-forward, but narrow to region first."
;;   (interactive "P\np")
;;   (narrow-to-region (point) (mark))
;;   (goto-char (point-min))
;;   (setq isearch-forward-region t)
;;   (isearch-mode t (not (null regexp-p)) nil (not no-recursive-edit)))

;; (global-set-key (kbd "C-c s") 'isearch-forward-region)

;; ===============================================
;; settings of nxhtml
;; (load "~/.emacs.d/nxhtml/autostart.el")
;; (setq mumamo-chunk-coloring 5)

;; ===============================================
;; settings of folding mode
(autoload 'folding-mode "folding" "Folding mode" t)
(autoload 'turn-off-folding-mode "folding" "Folding mode" t)
(autoload 'turn-on-folding-mode "folding" "Folding mode" t)

;; ===============================================
;; anything
(require 'anything)

;; ==============================================
;; tail
(require 'tail)

;; ===============================================
;; faster prev-next frame
(global-set-key (kbd "M-`") 'other-window)