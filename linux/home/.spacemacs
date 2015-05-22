;; -*- mode: dotspacemacs -*-
;; vim: filetype=lisp
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (ie. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; --------------------------------------------------------
     ;; Example of useful layers you may want to use right away
     ;; Uncomment a layer name and press C-c C-c to install it
     ;; --------------------------------------------------------
     ;; To get the list of layers, SPC f e h, modify .spacemacs, then
     ;; SPC f e R
     auto-completion
     ; ycmd
     syntax-checking
     ruby
     git
     ;; better-defaults
     ;; (git :variables
     ;;      git-gutter-use-fringe t)
     ;; markdown
     ;; org
     )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Either `vim' or `emacs'. Evil is always enabled but if the variable
   ;; is `emacs' then the `holy-mode' is enabled at startup.
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progess in `*Messages*' buffer.
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to a .PNG file.
   ;; If the value is nil then no banner is displayed.
   ;; dotspacemacs-startup-banner 'official
   dotspacemacs-startup-banner 'random
   ;; t if you always want to see the changelog at startup
   dotspacemacs-always-show-changelog t
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'."
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("DejaVu Sans Mono"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it.
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil the paste micro-state is enabled. While enabled pressing `p`
   ;; several times cycle between the kill ring content.
   dotspacemacs-enable-paste-micro-state t
   ;; Guide-key delay in seconds. The Guide-key is the popup buffer listing
   ;; the commands bound to the current keystrokes.
   dotspacemacs-guide-key-delay 0.4
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil ;; to boost the loading time.
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up.
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX."
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line.
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen.
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   dotspacemacs-smartparens-strict-mode nil
   ;; If non nil advises quit functions to keep server open when quitting.
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now.
   dotspacemacs-default-package-repository nil
   )
  ;; User initialization goes here
  )

(defun dotspacemacs/config ()
  "Configuration function.
 This function is called at the very end of Spacemacs initialization after
layers configuration."
  (setq-default
    ;; Textwidth, fill only the comments.
    set-fill-column 78
    comment-auto-fill-only-comments t
    ;; Put newline to the end of the file as Vim does.
    require-final-newline t
    ;; Highlight the whole text between pairs.
    show-paren-style 'expression
    indent-guide-delay 0.5
    ;; Move to end or beginning of source when reaching top or bottom of source.
    ; helm-move-to-line-cycle-in-source t
    auto-completion-enable-company-help-tooltip t
  )
  (add-hook 'prog-mode-hook #'indent-guide-mode)
  (add-hook 'prog-mode-hook #'company-mode)
  (add-hook 'prog-mode-hook #'flycheck-mode)
  ;; Global remaps to quit.
  ;; TODO: visual block.
  (define-key evil-insert-state-map           (kbd "C-g")   'evil-force-normal-state)
  (define-key evil-normal-state-map           (kbd "C-g")   'keyboard-escape-quit)
  (define-key evil-visual-state-map           (kbd "C-g")   'keyboard-escape-quit)
  (define-key minibuffer-local-map            (kbd "C-g")   'keyboard-escape-quit)
  (define-key minibuffer-local-ns-map         (kbd "C-g")   'keyboard-escape-quit)
  (define-key minibuffer-local-completion-map (kbd "C-g")   'keyboard-escape-quit)
  (define-key minibuffer-local-must-match-map (kbd "C-g")   'keyboard-escape-quit)
  (define-key minibuffer-local-isearch-map    (kbd "C-g")   'keyboard-escape-quit)
  ;; Global remaps to <return>.
  ;; TODO: google
  (define-key evil-motion-state-map           (kbd "C-j")   'widget-button-press)
  (define-key evil-normal-state-map           (kbd "C-j")   'widget-button-press)
  ;; Custom maps.
  (define-key evil-motion-state-map           (kbd "C-k")   'evil-window-next)
  (define-key evil-normal-state-map           (kbd "C-k")   'evil-window-next)
  (define-key evil-normal-state-map           (kbd "H")     'evil-first-non-blank-of-visual-line)
  (define-key evil-normal-state-map           (kbd "L")     'evil-end-of-visual-line)
  (define-key evil-motion-state-map           (kbd "s")     'evil-ace-jump-char-mode)
  (define-key evil-normal-state-map           (kbd "s")     'evil-ace-jump-char-mode)
  ;; TODO: not works
  (define-key evil-visual-state-map           (kbd "s")     'evil-ace-jump-char-mode)
  (define-key evil-motion-state-map           (kbd "C-e")   'evil-next-buffer)
  (define-key evil-normal-state-map           (kbd "C-e")   'evil-next-buffer)
  (define-key evil-motion-state-map           (kbd "C-y")   'evil-prev-buffer)
  (define-key evil-normal-state-map           (kbd "C-y")   'evil-prev-buffer)
  (define-key evil-motion-state-map           (kbd "<f12>") 'evil-search-highlight-persist-remove-all)
  (define-key evil-normal-state-map           (kbd "<f12>") 'evil-search-highlight-persist-remove-all)

  ;;  http://www.reddit.com/r/emacs/comments/35eoq3/how_i_use_vim_transferring_to_emacs_spacemacs
  ;;  TODO: fold, quickrun, easyalign, scroll margin, g; after exit, smartcase
  ;;  search, rainbowdeleimiters global off, smartparens global off

  ;; http://www.emacswiki.org/emacs/OutlineMinorMode#toc8
    (defun set-vim-foldmarker (fmr)
      "Set Vim-type foldmarkers for the current buffer"
      (interactive "sSet local Vim foldmarker: ")
      (if (equal fmr "")
          (message "Abort")
        (setq fmr (regexp-quote fmr))
        (set (make-local-variable 'outline-regexp)
             (concat ".*" fmr "\\([0-9]+\\)"))
        (set (make-local-variable 'outline-level)
             `(lambda ()
                (save-excursion
                  (save-match-data
                    (re-search-forward ,(concat fmr "\\([0-9]+\\)") nil t)
                    (string-to-number (match-string 1))))))))

    (outline-minor-mode t)
    (set-vim-foldmarker "{{{")
  )

  ;; Do not write anything past this comment. This is where Emacs will
  ;; auto-generate custom variable definitions.
