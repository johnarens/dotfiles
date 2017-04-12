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

(setq display-time-24hr-format t)
(display-time)
(column-number-mode 1)

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



;; Color
(require 'color-theme-sanityinc-tomorrow)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes (quote ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(display-time-mode t)
 '(inhibit-startup-screen t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Bitstream Vera Sans Mono" :foundry "bitstream" :slant normal :weight normal :height 143 :width normal)))))

(global-set-key [home] (quote beginning-of-buffer))
(global-set-key [end] (quote end-of-buffer))
(global-set-key [f12] (quote repeat-complex-command))
(global-set-key [f5] (quote kmacro-end-and-call-macro))

(provide '.emacs)
;;; .emacs ends here

