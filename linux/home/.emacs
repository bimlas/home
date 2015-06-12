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

;                      AUTOMATIKUS CSOMAG TELEPITES                       {{{1
; ============================================================================
; http://stackoverflow.com/a/10093312

(setq package-list '(evil                   ; vim mode
                     color-theme-solarized  ; light/dark color theme
                     ; rainbow-mode           ; hex/rgb szines megjelenitese
                     ; sunrise-commander      ; double panel commander
                     guide-key              ; gomb lenyomasa utan mutassa a lehetseges folytatasokat
                     helm                   ; minibuffer-kiegeszites (kb. unite)
                     ace-jump-mode            ; easymotion (C-c Space)
                     ; auto-complete          ; auto completion
                     ; company                ; auto completion
                     ; quickrun               ; quickrun
                     ; magit                  ; git
                     ))
; https://github.com/jwiegley/use-package
; (use-package guide-key
; :diminish guide-key-mode  ; Don't show 'guide-key in mode line
; :ensure t ;auto install the package if it is not installed.
; :config
; (setq guide-key/guide-key-sequence t) ;show guide key for all key combos. but you can configure it for specific combos also.
; (setq guide-key/recursive-key-sequence-flag t) ;recurse into all key combos.
; (setq guide-key/popup-window-position 'bottom) ;I want the help-pop up to be at the bottom like most buffer popups.
; (setq guide-key/highlight-command-regexp
; '("my/"  ; all my functions have a 'my/...' prefix, I like to highlight them.
; ("template" . "hot pink")  ; also highlight any function that have the word 'template' in them.
; ("helm-" . "green")  ; you can copy & paste lines like this to further highlight regions. use helm-color to find colors
; ))
; (guide-key-mode 1)  ; Enable guide-key-mode
; )

(setq package-archives '(("elpa"  . "http://tromey.com/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("SC"    . "http://joseito.republika.pl/sunrise-commander/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;                               BEALLITASOK                               {{{1
; ============================================================================

; Elvileg a swap fajlok helye, gyakorlatilag meg passz.
; TODO: Linux-on nezd meg, hogy van-e TMP valtozo.
(setq temporary-file-directory (getenv "TMP"))

; Paros jelek mutatasakkor az egesz kifejezest szinezze.
(setq show-paren-style 'expression)

; Ne keszitsen backup es autosave fajlokat.
(setq make-backup-files nil)
(setq auto-save-default nil)

; Ha elerheto, akkor ez legyen az alap betutipus.
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

; runtimepath
; http://emacswiki.org/emacs/LoadPath
; (let ((default-directory "~/.emacs.d/local/"))
;   (normal-top-level-add-subdirs-to-load-path))

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

;                                GENERALT                                 {{{2
; ____________________________________________________________________________
;
; sr-: sunrise commander

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" default)))
 '(global-auto-complete-mode t)
 '(global-linum-mode t)
 '(global-visual-line-mode 1)
 '(show-paren-mode t)
 '(sr-cursor-follows-mouse nil)
 '(sr-listing-switches "-alhk")
 '(sr-show-hidden-files t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;                                   MAP                                   {{{1
; ============================================================================

; (global-set-key (kbd "C-SPC") 'completion-at-point)
(global-set-key (kbd "C-SPC") 'ace-jump-char-mode)

;                            PLUGINOK INDITASA                            {{{1
; ============================================================================

;                                   IDO                                   {{{2
; ____________________________________________________________________________

; <C-X><C-F>  fajlok megnyitasa, ala CtrlP.
; <C-X>b      bufferek megnyitasa
; (ido-mode 1)

;                                GUIDE-KEY                                {{{2
; ____________________________________________________________________________

(setq guide-key/guide-key-sequence t)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)
(guide-key-mode 1)

;                                  EVIL                                   {{{2
; ____________________________________________________________________________

; (evil-mode 1)

;                                  HELM                                   {{{2
; ____________________________________________________________________________

(helm-mode 1)
; (helm-autoresize-mode 1)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i")   'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")   'helm-select-action)             ; list actions using C-z

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-ff-file-name-history-use-recentf t)

;                                SOLARIZED                                {{{2
; ____________________________________________________________________________

; Ez valamiert az utolso sorban akar csak mukodni.
(load-theme 'solarized)
