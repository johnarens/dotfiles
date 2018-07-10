;;; package --- Summary

;;; Commentary:

;; MELPA
(require 'package)

;;; Code:
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
; (add-to-list 'package-archives
;              '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;;  El-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)


;; Time Display
(setq display-time-24hr-format t)
(display-time)
(column-number-mode 1)


(show-paren-mode 1)
(setq comint-prompt-read-only t)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; Misc
;; ;; Use font lock mode
;; (global-font-lock-mode t)
;; ;; Highlight cursor line
;; (global-hl-line-mode t)
;; ;; Highlight selected region
;; (transient-mark-mode t)
;; (menu-bar-mode t)

;; IDO
(require 'ido)
(setq ido-create-new-buffer 'always)
;; setq ido-file-extensions-order '(".org" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))
(ido-mode t)


;; Jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "jedi-direx")
(eval-after-load "python"
  '(define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer))
(add-hook 'jedi-mode-hook 'jedi-direx:setup)

(setq jedi:server-args
      '("--sys-path" "~/anaconda2/lib/python2.7/site-packages"))


;; ;; Flycheck
;; ;; To install: M-x package-install flycheck
;; ;; (require 'flycheck)
;; (add-hook 'after-init-hook #'global-flycheck-mode)

;; ;; FlySpell
;; (setq-default ispell-program-name "/usr/bin/aspell")
;; (add-hook 'python-mode-hook 'flyspell-prog-mode)
;; (add-hook 'rst-mode-hook 'flyspell-prog-mode)
;; (add-hook 'rst-mode-hook (lambda () (subword-mode 1)))

;; Pymacs
(add-to-list 'load-path "~/.emacs.d/elisp/Pymacs")
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

;; Org Mode
(setq org-startup-with-inline-images t)

(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.x?html?\\'" . "firefox %s")
        ("\\.pdf\\'" . "evince \"%s\"")
        ("\\.pdf::\\([0-9]+\\)\\'" . "evince \"%s\" -p %1")
        ("\\.pdf.xoj" . "xournal %s")))

;; Plant UML
;; http://plantuml.com/
;; https://emacs.stackexchange.com/questions/13107/replace-plantuml-source-with-generated-image-in-org-mode
;; https://github.com/skuro/plantuml-mode
;; https://github.com/alexmurray/flycheck-plantuml
;; install plantuml-mode
;; copy JAR to path below:
;; (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
(setq org-plantuml-jar-path (expand-file-name "~/bin/plantuml.jar"))

;; Org Babel
;; (require 'org)
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (ditaa . t)
   (dot . t)
   (emacs-lisp . t)
   (plantuml . t)
   (python . t)
   (sh . t)
   ))
(setq org-confirm-babel-evaluate nil)

;; ;; helper function
;; (defun my-org-confirm-babel-evaluate (lang body)
;; "Do not ask for confirmation to evaluate code for specified languages."
;; (member lang '("plantuml")))
;; 
;; ;; trust certain code as being safe
;; (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
;; 

;; automatically show the resulting image
;; (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

;; (defun my/fix-inline-images ()
;;   (when org-inline-image-overlays
;;     (org-redisplay-inline-images)))
;; (add-hook 'org-babel-after-execute-hook 'my/fix-inline-images)

(org-display-inline-images t)
(add-hook 'org-babel-after-execute-hook'org-redisplay-inline-images)
(add-hook 'org-babel-after-execute-hook'org-display-inline-images)

;; (setq org-file-apps org-file-apps-defaults-gnu)

;; Must see
;; http://katherine.cox-buday.com/blog/2015/03/14/writing-specs-with-org-mode/
;; https://zeekat.nl/articles/making-emacs-work-for-me.html#sec-10-6

;; ECB
;; (require 'ecb)


;; Projectile
(require 'projectile)
(projectile-global-mode)


;; GNU Global
(setq load-path (cons "/home/simplex/svn/trunk" load-path))
(autoload 'gtags-mode "gtags" "" t)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

;; TIKZ
(setq org-latex-packages-alist '())
(add-to-list 'org-latex-packages-alist
              '("" "tikz" t))

(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))

(setq org-latex-create-formula-image-program 'imagemagick)
(setq org-export-latex-packages-alist '(("" "tikz")))

(defvar org-latex-fragment-last nil
  "Holds last fragment/environment you were on.")

(defun org-latex-fragment-toggle ()
  "Toggle a latex fragment image "
  (and (eq 'org-mode major-mode)
       (let* ((el (org-element-context))
              (el-type (car el)))
         (cond
          ;; were on a fragment and now on a new fragment
          ((and
            ;; fragment we were on
            org-latex-fragment-last
            ;; and are on a fragment now
            (or
             (eq 'latex-fragment el-type)
             (eq 'latex-environment el-type))
            ;; but not on the last one this is a little tricky. as you edit the
            ;; fragment, it is not equal to the last one. We use the begin
            ;; property which is less likely to change for the comparison.
            (not (= (org-element-property :begin el)
                    (org-element-property :begin org-latex-fragment-last))))
           ;; go back to last one and put image back
           (save-excursion
             (goto-char (org-element-property :begin org-latex-fragment-last))
             (org-preview-latex-fragment))
           ;; now remove current image
           (goto-char (org-element-property :begin el))
           (let ((ov (loop for ov in org-latex-fragment-image-overlays
                           if
                           (and
                            (<= (overlay-start ov) (point))
                            (>= (overlay-end ov) (point)))
                           return ov)))
             (when ov
               (delete-overlay ov)))
           ;; and save new fragment
           (setq org-latex-fragment-last el))

          ;; were on a fragment and now are not on a fragment
          ((and
            ;; not on a fragment now
            (not (or
                  (eq 'latex-fragment el-type)
                  (eq 'latex-environment el-type)))
            ;; but we were on one
            org-latex-fragment-last)
           ;; put image back on
           (save-excursion
             (goto-char (org-element-property :begin org-latex-fragment-last))
             (org-preview-latex-fragment))
           ;; unset last fragment
           (setq org-latex-fragment-last nil))

          ;; were not on a fragment, and now are
          ((and
            ;; we were not one one
            (not org-latex-fragment-last)
            ;; but now we are
            (or
             (eq 'latex-fragment el-type)
             (eq 'latex-environment el-type)))
           (goto-char (org-element-property :begin el))
           ;; remove image
           (let ((ov (loop for ov in org-latex-fragment-image-overlays
                           if
                           (and
                            (<= (overlay-start ov) (point))
                            (>= (overlay-end ov) (point)))
                           return ov)))
             (when ov
               (delete-overlay ov)))
           (setq org-latex-fragment-last el))))))


(add-hook 'post-command-hook 'org-latex-fragment-toggle)



;; Color
;; (require 'color-theme-sanityinc-tomorrow)


(global-set-key [home] (quote beginning-of-buffer))
(global-set-key [end] (quote end-of-buffer))
(global-set-key [f12] (quote repeat-complex-command))
;; (global-set-key [f5] (quote kmacro-end-and-call-macro))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(define-key org-mode-map (kbd "$") (lambda ()
                                     (interactive)
                                     (insert "$")
                                     (save-excursion
                                       (left-char 1)
                                       (if (org-inside-LaTeX-fragment-p)
                                           (progn
                                             (right-char 2)
                                             (org-preview-latex-fragment))))))


(setq custom-file "~/.emacs.d/custom.el")
    (load custom-file)

(provide '.emacs)
;;; .emacs ends here

