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
                     sunrise-commander      ; double panel commander
                     auto-complete          ; auto completion
                     ac-inf-ruby            ; ... ruby
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
;
; sr-: sunrise commander

; Msys-git hozzadasa Windows-on.
(setq exec-path (append exec-path '("~/git/bin")))

;                                GENERALT                                 {{{2
; ____________________________________________________________________________

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

;                                BUILTINS                                 {{{1
; ============================================================================
(ido-mode)

;                               TELEPITETT                                {{{2
; ____________________________________________________________________________

; (evil-mode)

; ac-inf-ruby
(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'inf-ruby-mode))
(add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)

; Ez valamiert az utolso sorban akar csak mukodni.
(load-theme 'solarized-light)
