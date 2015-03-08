; A (kifejezesek) M-X parancsokat jelentenek, a ' karakter, ha jol ertem az
; Enter lenyomasat szimulalja.
;
; Nezz ra: M-X customize, M-X customize-group RET solarized
; (global-set-key (kbd "C-SPC") 'tempo-complete-tag)

;                      AUTOMATIKUS CSOMAG TELEPITES                       {{{1
; ============================================================================
; http://stackoverflow.com/a/10093312

; evil:                   vim mode
; color-theme-solarized:  light/dark color theme
; magit:                  git
; sunrise:                double panel commander
(setq package-list '(evil color-theme-solarized magit))

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

;            GENERALT BEALLITASOK, NE PISZKALD (M-X CUSTOMIZE)            {{{1
; ============================================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" default)))
 '(dired-listing-switches "-alhk")
 '(sr-attributes-display-mask (quote (nil nil nil nil t t t)))
 '(sr-listing-switches "-alhk")
 '(sr-show-hidden-files t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;                            PLUGINOK INDITASA                            {{{1
; ============================================================================

(require 'evil)
; (evil-mode 1)

(require 'magit)

; Ez valamiert az utolso sorban akar csak mukodni.
(load-theme 'solarized-light)
