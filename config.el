;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marco Antonio Ponce Valdez"
      user-mail-address "marcoantonioponcevaldez@gmail.com"
      doom-font (font-spec :family "Hack" :size 18))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)
(setq projectile-project-search-path '("~/code/"))
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;;(pyenv-mode)

;; Timer bell. Download the sound at https://freesound.org/people/.Andre_Onate/sounds/484665/
(setq org-clock-sound "~/Music/sonidos/bell.wav")

;; Org mode
(setq org-directory "~/RoamNotes")
(after! org
  (setq org-agenda-files
        '("~/RoamNotes")))


;; https://zzamboni.org/post/my-doom-emacs-configuration-with-commentary/#programming-org
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(use-package! org-roam
      :ensure t
      :init
      (setq org-roam-v2-ack t)
      :custom
      (org-roam-directory (file-truename "~/RoamNotes"))
      (org-roam-complete-everywhere t)
      (org-roam-capture-templates
        '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)))
      :bind (("C-c n l" . org-roam-buffer-toggle)
             ("C-c n f" . org-roam-node-find)
             ("C-c n g" . org-roam-graph)
             ("C-c n i" . org-roam-node-insert)
             ("C-c n c" . org-roam-capture)
             :map org-mode-map
             ("C-M-i"   . completion-at-point)
             ;; Dailies
             ("C-c n j" . org-roam-dailies-capture-today))
      :config
      (require 'org-roam-dailies) ;; Ensure the keymap is available
      (org-roam-setup)
      ;; If using org-roam-protocol
      (require 'org-roam-protocol))

;; calibre
(use-package! calibredb
  :defer t
  :config
  (setq calibredb-root-dir "/home/holymc2/Calibre Library/")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist '(("~/home/holymc2/Calibre Library")))
  (setq calibredb-virtual-library-alist '(("1. Development - work" . "work \\(pdf\\|epub\\)")
                                          ("2. Read it later" . "Readit epub")
                                          ("3. Development" . "dev")))
  (setq turn-off-evil-mode t))

  (map! :leader
        ;;:prefix ("t". "toggle")
        :desc "List calibredb entries" "t t" #'calibredb)

;; nov - mode for reading epub
(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :hook (nov-mode . mixed-pitch-mode)
  :hook (nov-mode . visual-line-mode)
  :config
  (setq nov-text-width t)
  (setq nov-variable-pitch nil))

;; ESC cancels all
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
