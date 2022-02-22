;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; My user information
(setq user-full-name "Marco Antonio Ponce Valdez"
      user-mail-address "marcoantonioponcevaldez@gmail.com")

;; Theme
(setq doom-theme 'doom-dracula)
(setq doom-font (font-spec :family "Hack" :size 18)
      doom-big-font (font-spec :family "Hack" :size 26)
      doom-variable-pitch-font (font-spec :family "sans" :size 20))

;; doom disables auto-save and backup files, lets reenable them
(setq auto-save-default t
      make-backup-files t)

;; Disable exit confirmation
(setq confirm-kill-emacs nil)
;; Projectile
(setq projectile-project-search-path '("~/code/"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Timer bell. Download the sound at https://freesound.org/people/.Andre_Onate/sounds/484665/
(setq org-clock-sound "~/Music/sonidos/bell.wav")

;; Org mode
(setq org-directory "~/org")
(after! org
  (setq org-agenda-files
        '("~/org")))

(setq org-pomodoro-length 25)

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
;; Org chef
(after! org-capture
(setq org-capture-templates
      '(("t" "Personal todo" entry
           (file+headline +org-capture-todo-file "Inbox")
           "* [ ] %?\n%i\n%a" :prepend t)
          ("n" "Personal notes" entry
           (file+headline +org-capture-notes-file "Inbox")
           "* %u %?\n%i\n%a" :prepend t)
          ("j" "Journal" entry
           (file+olp+datetree +org-capture-journal-file)
           "* %U %?\n%i\n%a" :prepend t)
           ("c" "Cookbook" entry (file "~/org/cookbook.org")
         "%(org-chef-get-recipe-from-url)"
         :empty-lines 1)
        ("m" "Manual Cookbook" entry (file "~/org/cookbook.org")
         "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n"))))


;; commonly-used org file
;;(zz/add-file-keybinding "C-c z w" "~/org/work.org" "work.org")
;; calibre
(use-package! calibredb
  :defer t
  :config
  (setq calibredb-root-dir "/home/holymc2/Calibre Library/")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist '(("~/home/holymc2/Calibre Library")))
  (setq calibredb-virtual-library-alist '(("1. Development - work" . "work \\(pdf\\|epub\\)")
                                          ("2. Read it later" . "Readit epub")
                                          ("3. Development" . "dev"))))
  (evil-set-initial-state 'calibredb-search-mode 'emacs)

  (map! :leader
        :desc "List calibredb entries" "t t" #'calibredb)

;; Info pages color
(use-package! info-colors
  :after info
  :commands (info-colors-fontify-node)
  :hook (Info-selection . info-colors-fontify-node))

;; nov - mode for reading epub
(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :hook (nov-mode . mixed-pitch-mode)
  :hook (nov-mode . visual-line-mode)
  :config
  (setq nov-text-width t)
  (setq nov-variable-pitch nil))

;; Org heading minimap
(use-package! org-ol-tree
  :commands org-ol-tree)

(map! :map org-mode-map
      :after org
      :localleader
      :desc "Outline" "O" #'org-ol-tree)

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
