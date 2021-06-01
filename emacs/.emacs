(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-org helpful ivy-rich counsel org-bullets doom-themes diminish magit projectile which-key doom-modeline ivy evil-collection evil-commentary evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

(use-package diminish)

;; EVIL
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :custom
  (evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))
(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
(use-package evil-commentary
  :config
  (evil-commentary-mode))

;; IVY
(use-package ivy
  :diminish ivy-mode
  :config
  (ivy-mode 1))
(use-package counsel)
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; THEMES
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))
(use-package all-the-icons) ; run M-x all-the-icons-install-fonts
(use-package doom-themes
  :config
  (load-theme 'doom-one t)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package helpful
  :custom
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Documents/python")
    (setq projectile-project-search-path '("~/Documents/python")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package magit)

;; UI
(setq inhibit-startup-message t) ; disable start screen
(scroll-bar-mode -1) ; disable scrollbar
(tool-bar-mode -1) ; disable toolbar
;;(tooltip-mode -1) ; disable tooltips
(menu-bar-mode -1) ; disable menu bar

;; MISC
(server-start)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; make esc quit prompts
(global-display-line-numbers-mode)
(counsel-mode)
(setq display-line-numbers 'relative)

;; disable lockfiles, save backup files in tmp dir
(setq create-lockfiles nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; ORG-MODE
(setq org-log-into-drawer t)
(setq org-agenda-files
      '("~/Documents/org-mode/todolist/tasklist.org"
	"~/Documents/org-mode/todolist/birthdays.org"))
;; allow running elisp and python code blocks
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)))
;; code block template expansion
;; (<py <TAB> for python block)
(require 'org-tempo)
;; templates for code blocks
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

