; A (kifejezesek) M-X parancsokat jelentenek, a ' karakter, ha jol ertem az
; Enter lenyomasat szimulalja.
;
; Nezz ra: M-X customize
; (global-set-key (kbd "C-SPC") 'tempo-complete-tag)

;            GENERALT BEALLITASOK, NE PISZKALD (M-X CUSTOMIZE)            {{{1
; ============================================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;                      AUTOMATIKUS CSOMAG TELEPITES                       {{{1
; ============================================================================
; http://stackoverflow.com/a/10093312

; list the packages you want
; evil: vim mode
; magit: git
(setq package-list '(evil color-theme-solarized magit))

; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;                            PLUGINOK INDITASA                            {{{1
; ============================================================================

(require 'evil)
; (evil-mode 1)

(require 'magit)

(load-theme 'solarized-light)
