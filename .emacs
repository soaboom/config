;; Disable menubar etc
(menu-bar-mode -1)
(show-paren-mode 1)


;; Setup tabs and spaces
(setq-default c-basic-offset 4
	      c-default-style "stroustrup"
	      tab-width 4
	      indent-tabs-mode t)

;; Package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
;(package-refresh-contents)

;; Install my packages
(defvar soaboom-packages
  '(slime ac-slime switch-window magit paredit tuareg merlin utop))

(require 'cl-lib)

(dolist (pkg soaboom-packages)
  (when (not (package-installed-p pkg))
	(package-install pkg)))

;; Keyboard shortcuts
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "C-x d") 'delete-other-window)

(require 'paredit)

;; Paredit keys
(define-key paredit-mode-map (kbd "M-]") 'paredit-forward-slurp-sexp)
(define-key paredit-mode-map (kbd "M-[") 'paredit-forward-barf-sexp)

(define-key paredit-mode-map (kbd "C-M-[") 'paredit-backward-slurp-sexp)
(define-key paredit-mode-map (kbd "C-M-]") 'paredit-backward-barf-sexp)

;; Setup ido-mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Auto complete
(require 'auto-complete-config)
(ac-config-default)

; Sane ac delay times
(setq ac-delay 1.0)
(setq ac-quick-help-delay 2.0)

;; Setup Common Lisp
(setq inferior-lisp-program "sbcl")
(slime-setup '(slime-repl slime-fancy slime-banner))

(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

;; Setup OCaml
(setq auto-mode-alist
	  (append '(("\\.ml[ily]?$" . tuareg-mode)
				("\\.topml$" . tuareg-mode))
			  auto-mode-alist))

(autoload 'utop "utop" "Toplevel for OCaml" t)
(autoload 'utop-minor-mode "utop" "Minor mode for utop" t)
(add-hook 'tuareg-mode-hook 'utop-minor-mode)

;; Merlin
(add-to-list 'load-path (concat (substring (shell-command-to-string "opam config var share") 0 -1)
								"/emacs/site-lisp"))
(require 'merlin)

(add-hook 'tuareg-mode-hook 'merlin-mode)

(setq merlin-use-auto-complete-mode 'easy)
(setq merlin-error-after-save nil)

