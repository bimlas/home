; http://ergoemacs.org/emacs/emacs_make_modern.html
; http://ergoemacs.org/emacs/effective_emacs.html
; http://www.emacswiki.org/emacs/Icicles
;
; Ne felejtsd el beallitani a HOME kornyezeti valtozot, hogy a megfelelo
; helyen keresse ezt a fajlt!
;
; A (kifejezesek) M-X parancsokat jelentenek, a ' karakter, ha jol ertem az
; Enter lenyomasat szimulalja.
;
; Nezz ra: M-X customize, M-X customize-group RET solarized
; (global-set-key (kbd "C-SPC") 'tempo-complete-tag)

;                               USE-PACKAGE                               {{{1
; ============================================================================
; https://github.com/jwiegley/use-package
; http://www.lunaryorn.com/2015/01/06/my-emacs-configuration-with-use-package.html

; install use-package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

; ; better modeline
; (use-package powerline-evil
;              :ensure t
;              :config
;                (require 'powerline))

; light/dark color theme
(use-package solarized-theme
             :ensure t
             :config
               (load-theme 'solarized-light t))  ; t means treat as safe

; display possibilities while hitting chords
(use-package guide-key
             :ensure t
             :init
               (setq guide-key/guide-key-sequence t
                     guide-key/recursive-key-sequence-flag t
                     guide-key/popup-window-position 'bottom)
             :config
               (guide-key-mode t))

; minibuffer-completion (vim: unite)
(use-package helm
             :ensure t
             :init
               (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
                     ; helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
                     helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
                     helm-ff-file-name-history-use-recentf t)

             :config
               (helm-mode t)
               (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
               (define-key helm-map (kbd "C-i")   'helm-execute-persistent-action) ; make TAB works in terminal
               (define-key helm-map (kbd "C-z")   'helm-select-action))            ; list actions using C-z

; vim: easymotion
(use-package avy
             :ensure t)

; auto completion
(use-package company
             :ensure t
             :config
               (global-company-mode t))

; display quickhelp with F1
(use-package company-quickhelp
             :ensure t)

; python support
; TODO: enable in python
(use-package jedi
             :ensure t)
(use-package company-jedi
             :ensure t)

; ruby support
(use-package rinari
             :ensure t)
(use-package company-inf-ruby
             :ensure t)

; git
(use-package magit
             :ensure t)

; display hex/rgb colors
; (use-package rainbow-mode
;              :ensure t)

; quickrun
; (use-package quickrun
;              :ensure t)

; built-in package settings
(global-visual-line-mode t)
(show-paren-mode t)
(setq show-paren-style 'expression)

; runtimepath
; http://emacswiki.org/emacs/LoadPath
; (let ((default-directory "~/.emacs.d/private"))
;   (normal-top-level-add-subdirs-to-load-path))

;                               BEALLITASOK                               {{{1
; ============================================================================

; Elvileg a swap fajlok helye, gyakorlatilag meg passz.
; TODO: Linux-on nezd meg, hogy van-e TMP valtozo.
; (setq temporary-file-directory (getenv "TMP"))

; Paros jelek mutatasakkor az egesz kifejezest szinezze.

; Ne keszitsen backup es autosave fajlokat.
(setq make-backup-files nil)
(setq auto-save-default nil)

; Ha elerheto, akkor ez legyen az alap betutipus.
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

; ~/.emacs.d/local/doc-mode
; http://sourceforge.net/projects/xpt/files/doc-mode/
; (require 'doc-mode)

;                                FILETYPE                                 {{{1
; ============================================================================

(add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode))

;                           KORNYEZETI VALTOZOK                           {{{2
; ____________________________________________________________________________
;
; A teljes listaert: <C-H> r <C-S> * Environment

; Msys-git hozzadasa a PATH-hoz Windows-on.
(setq exec-path (append '("~/git/bin") exec-path))

; Usenet server.
(setenv "NNTPSERVER" "news.gmane.org")
