;; ===================================================
;; global settings
(display-time-mode 1)
(setq display-time-day-and-date t)
(setq display-time-use-mail-icon t)
(setq display-time-interval 60)

;; settings of w3m
;; ===================================================
;; =======Temporary Disabled===========
(add-to-list 'load-path "~/repos/emacs-confs/.emacs.d/emacs-w3m")
(setq w3m-use-cookies t)
(setq w3m-command-arguments '("-cookie" "-F"))
;; (setq w3m-display-inline-image t)
(setq w3m-home-page "about:blank")
;;	(setq w3m-home-page "http://www.google.com/ncr")
(require 'w3m-load)

;; settings of color-theme
;; (add-to-list 'load-path "~/elisp")
;; (add-to-list 'load-path "~/repos/emacs-confs/.emacs.d/color-theme/")
;; (require 'color-theme)
;; (setq color-theme-is-global t)
;; (color-theme-initialize)
;; (color-theme-lawrence)

;; settings of auto-complete
;; ===================================================

(add-to-list 'load-path "~/repos/emacs-confs/.emacs.d/auto-complete")
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
(add-to-list 'load-path "~/repos/emacs-confs/.emacs.d/cc-mode/cc-mode-5.31.3")
(require 'cc-mode)

;; settings of bind key-shortcut to goto-line command
(global-set-key (kbd "C-c g") 'goto-line)

;; settings of CEDET
;; ===================================================
(load-file "~/repos/emacs-confs/.emacs.d/cedet/common/cedet.el")

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

;; settings of html-mode
;; (add-to-list 'load-path "~/repos/emacs-confs/.emacs.d/html-mode")
;; (autoload 'html-mode "html-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.html$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.asp$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.php$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.tpl$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pss$" . css-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pjs$" . javascript-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.json$" . javascript-mode) auto-mode-alist))

;; load repos/emacs-confs/.emacs.d/miscs into path, prepared for single .el file
(add-to-list 'load-path "~/repos/emacs-confs/.emacs.d/miscs")

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
;; (load "~/repos/emacs-confs/.emacs.d/nxhtml/autostart")
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

;; ==============================================
;; settings of cursor change
(require 'cursor-chg)
(change-cursor-mode 1)
(toggle-cursor-type-when-idle 1)
(put 'downcase-region 'disabled nil)

;; ===================================================
;; smooth scroll
(require 'smooth-scroll)
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; ===============================================
;; directory tree
(autoload 'dirtree "dirtree" "Add directory to tree view" t)
(global-set-key (kbd "C-x d") 'dirtree)

;; ==============================================
;; SQL Completion
(require 'sql-completion)
(setq sql-interactive-mode-hook
      (lambda ()
        (define-key sql-interactive-mode-map "\t" 'comint-dynamic-complete)
        (sql-mysql-completion-init)))

;; ===================================================
;; auctex mode
(add-to-list 'load-path "~/repos/emacs-confs/.emacs.d/autex")
(load "auctex.el" nil t t)
(require 'tex-mik)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(require 'auto-complete-latex)
(setq ac-l-dict-directory "~/repos/emacs-confs/.emacs.d/miscs/ac-l-dict/")
(add-to-list 'ac-modes 'foo-mode)
(add-hook 'foo-mode-hook 'ac-l-setup)

(mapc (lambda (mode)
        (add-hook 'LaTeX-mode-hook mode))
      (list 'auto-fill-mode
            'LaTeX-math-mode
            'turn-on-reftex
            'linum-mode))

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq TeX-auto-untabify t     ; remove all tabs before saving
                  TeX-show-compilation t) ; display compilation windows
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (setq TeX-save-query nil)
            (imenu-add-menubar-index)
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))