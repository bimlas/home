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
                     rainbow-mode           ; hex/rgb szines megjelenitese
                     sunrise-commander      ; double panel commander
                     auto-complete          ; auto completion
                     ; company                ; auto completion
                     magit                  ; git
                     ))

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
    ("31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" default)))
 '(global-auto-complete-mode t)
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

(global-set-key (kbd "C-SPC") 'completion-at-point)

;                            PLUGINOK INDITASA                            {{{1
; ============================================================================

;                                BUILTINS                                 {{{2
; ____________________________________________________________________________

(ido-mode)

;                               TELEPITETT                                {{{2
; ____________________________________________________________________________

; (evil-mode)

; Ez valamiert az utolso sorban akar csak mukodni.
(load-theme 'solarized-light)
