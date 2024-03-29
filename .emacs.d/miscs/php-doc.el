;;; php-doc.el --- Php document helper

;; Copyright (C) 2009 Free Software Foundation, Inc.
;;
;; Author: Ye Wenbin <wenbinye@gmail.com>
;; Maintainer: Ye Wenbin <wenbinye@gmail.com>
;; Created: 01 Jan 2009
;; Version: 0.01
;; Keywords: languages, convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Dependency:
;; 1. tree-mode.el - http://www.emacswiki.org/cgi-bin/emacs/tree-mode.el
;; 2. windata.el   - http://www.emacswiki.org/cgi-bin/emacs/windata.el
;; 3. help-dwim.el - http://www.emacswiki.org/cgi-bin/emacs/help-dwim.el
;;
;; If you use perl, install Emacs::PDE instead, it provide more features.

;;; Installation:

;; 1. Download php_manaul_en.tar.gz to local
;; 2. extract to certain directory
;; 3. add this to .emacs
;;    (require 'php-doc nil t)
;;    (setq php-doc-directory "/path/to/php_manual/html")
;;    (add-hook 'php-mode-hook
;;              (lambda ()
;;                (local-set-key "\t" 'php-doc-complete-function)
;;                (local-set-key (kbd "\C-c h") 'php-doc)
;;                (set (make-local-variable 'eldoc-documentation-function)
;;                     'php-doc-eldoc-function)
;;                (eldoc-mode 1)))

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'php-doc)

;;; Code:

(eval-when-compile
  (require 'cl))

(require 'complete)
(require 'tree-mode)
(require 'windata)

(defgroup php-doc nil
  "View Php manual in emacs"
  :group 'tools)

(defcustom php-doc-directory "/usr/share/doc/php-doc/html"
  "*Directory of php manual (multiple page html version)"
  :type 'directory
  :group 'php-doc)

(defcustom php-doc-cachefile "~/.emacs.d/php-doc"
  "*File to save php function symbol"
  :type 'file
  :group 'php-doc)

(defcustom php-doc-tree-windata '(frame left 0.3 delete)
  "*Arguments to set the window buffer display.
See `windata-display-buffer' for setup the arguments."
  :type 'sexp
  :group 'php-doc)

(defcustom php-doc-tree-theme "default"
  "*Theme of tree-widget."
  :type 'string
  :group 'php-doc)

(defcustom php-doc-tree-buffer "*PHP-doc*"
  "*Buffer name for `php-doc-tree'"
  :type 'string
  :group 'php-doc)

(defcustom php-doc-browser-function
  (if (featurep 'w3m-load)
      'php-doc-w3m
    browse-url-browser-function)
  "*Function to browse html file"
  :type 'function
  :group 'php-doc)

(defvar php-doc-tree nil)

(defvar php-doc-obarray nil
  "All php functions")

(defsubst php-doc-function-file (sym)
  (expand-file-name (format "function.%s.html" (replace-regexp-in-string "_" "-" (symbol-name sym)))
                    php-doc-directory))

(defun php-doc-build-tree (&optional no-cache)
  (interactive "P")
  (let (functions function tree path)
    (if (and (not no-cache)
             (file-readable-p php-doc-cachefile))
        (with-temp-buffer
          (insert-file-contents php-doc-cachefile)
          (setq functions (read (current-buffer))))
      (let ((files (directory-files php-doc-directory nil "\\.html$")))
        (dolist (file files)
          (when (not (string-match "^index" file))
            (setq path (nbutlast (split-string file "\\."))
                  function nil)
            (when (string= (car path) "function")
              (setq function (replace-regexp-in-string "-" "_" (cadr path)))
              (if (string-match "-" (cadr path))
                  (setq path (nconc (list (car path) (substring (cadr path) 0 (match-beginning 0)))
                                    (cdr path)))))
            (push (cons path function) functions)))
        ;; save to cache file
        (when (file-writable-p php-doc-cachefile)
          (with-temp-buffer
            (prin1 functions (current-buffer))
            (write-file php-doc-cachefile)))))
    (setq php-doc-obarray (make-vector 1519 nil))
    (dolist (function functions)
      (when (cdr function)
        (intern (cdr function) php-doc-obarray))
      (php-doc-add-to-tree 'tree (car function)))
    (setq php-doc-tree tree)))

(defun php-doc-add-to-tree (sym list)
  (if list
      (let ((val (assoc (car list) (symbol-value sym)))
            (subtree (gensym))
            restree)
        (unless val
          (setq val (cons (car list) nil))
          (set sym (cons val (symbol-value sym))))
        (set subtree (cdr val))
        (setq restree (php-doc-add-to-tree subtree (cdr list)))
        (if restree
            (setcdr val restree))
        (symbol-value sym))))

(define-derived-mode php-doc-mode tree-mode "PHPDoc"
  "List perl module using tree-widget.

\\{perldoc-mode-map}"
  (tree-widget-set-theme php-doc-tree-theme))

(defun php-doc (sym)
  "Display document of php function"
  (interactive
   (progn
     (or php-doc-obarray (php-doc-build-tree))
     (let ((def (current-word)))
       (list (intern (completing-read (if def
                                          (format "PHP Function(default %s): " def)
                                        "PHP Function: ")
                                      php-doc-obarray nil t nil nil def) php-doc-obarray)))))
  (let ((browse-url-browser-function php-doc-browser-function)
        (file (php-doc-function-file sym)))
    (if (file-exists-p file)
        (browse-url (concat "file://" file)))))

(defun php-doc-tree ()
  (interactive)
  (unless php-doc-tree
    (php-doc-build-tree))
  (unless (get-buffer php-doc-tree-buffer)
    (with-current-buffer (get-buffer-create php-doc-tree-buffer)
      (php-doc-mode)
      (widget-apply-action (widget-create (php-doc-tree-widget (cons "PHP-Doc" php-doc-tree))))
      (widget-setup)
      (goto-char (point-min))))
  (select-window (apply 'windata-display-buffer
                        (get-buffer php-doc-tree-buffer)
                        php-doc-tree-windata)))

(defun php-doc-tree-widget (list)
  `(tree-widget
    :node (push-button :button-face dired-directory
                       :notify php-doc-view-or-expand
                       :tag ,(car list)
                       :format "%[%t%]\n")
    ,@(mapcar
       (lambda (el         (if (cdr el             (ph           `(push-button                       (cdr l    (while (widget-get node :pare           (if (and (string= (car path) "funct        (setq path       (tree
(defun php-doc-w3m (url &rest ignore)
  (let ((win (next-window))
            (save-wind    (di
(if (featurep 'help-dwim)
    (help-dwim-register
     (cons 'php-do(defun php-doc-comple  (un    (php-doc-build-tree))  (let* ((en         (beg (save-excur                  (while (= (ch         (PC-not-m           (PC-do-completion nil beg PC-li      (if          (move-marker PC-lisp-(defun  (let (string symbol done)
    (save-excursion
                  (s    (when symbol
      (             (when (file-exists-            (inser            (re-sea                (setq syno            ( 
(provide 'php-doc)
;;; php-doc.el ends here