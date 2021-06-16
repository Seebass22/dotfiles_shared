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
   '(general yasnippet edit-indirect elpher flycheck lsp-ui company lsp-pyright lsp-mode auctex-latexmk auctex erc-hl-nicks erc-highlight-nicknames dired-single evil-org helpful ivy-rich counsel org-bullets doom-themes diminish magit projectile which-key doom-modeline ivy evil-collection evil-commentary evil)))
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
(use-package evil-matchit
  :config
  (global-evil-matchit-mode 1))
(evil-select-search-module 'evil-search-module 'evil-search)

;; IVY
(use-package ivy
  :diminish ivy-mode
  :config
  (ivy-mode 1))
(use-package counsel
  :config
  (counsel-mode))
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


;; HELPFUL STUFF
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

;; indirect editing for markdown code blocks
(use-package edit-indirect)


;; UI
(setq inhibit-startup-message t) ; disable start screen
(scroll-bar-mode -1) ; disable scrollbar
(tool-bar-mode -1) ; disable toolbar
;;(tooltip-mode -1) ; disable tooltips
(menu-bar-mode -1) ; disable menu bar

;; MISC
(server-start)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; make esc quit prompts
(global-unset-key (kbd "C-z"))

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
	"~/Documents/org-mode/todolist/exams.org"
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
(add-to-list 'org-structure-template-alist '("vh" . "src vhdl"))
(add-to-list 'org-structure-template-alist '("o" . "src octave"))
;; syntax highlighting for LaTeX export
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))


;; DIRED
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))
(use-package dired-single)


;; ERC
(setq erc-server "irc.libera.chat"
      erc-nick "Seebass22"
      erc-track-exclude-types '("JOIN" "NICK" "QUIT" "MODE" "AWAY")
      erc-keywords '("vim"))
(use-package erc-hl-nicks
  :after erc
  :config
  (add-to-list 'erc-modules 'hl-nicks))


;; AUCTeX
(use-package latex
  :ensure auctex)
(use-package auctex-latexmk)
(auctex-latexmk-setup)

(use-package flycheck
  :defer t)


;; LSP-MODE
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (lsp-enable-which-key-integration t))
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
	      ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))
(use-package yasnippet
  :config (yas-global-mode 1))
;; LSP-LANGUAGES
;; python
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
			 (require 'lsp-pyright)
			 (lsp-deferred))))  ; or lsp-deferred
;; LaTeX
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (lsp)
	    (setq-local lsp-diagnostic-package :none)
	    (setq-local flycheck-checker 'tex-chktex)))
;; VHDL
(use-package vhdl-mode
  :ensure nil
  :defer t
  :config
  (setq lsp-vhdl-server 'ghdl-ls
	lsp-vhdl-server-path (executable-find "ghdl-ls")
	lsp-vhdl--params nil)
  (require 'lsp-vhdl)
  :hook (vhdl-mode . (lambda()
		       (lsp t)
		       (flycheck-mode t))))


;; EWW
;; follow gopher and gemini links from EWW
(use-package elpher)
(advice-add 'eww-browse-url :around 'elpher:eww-browse-url)
(defun elpher:eww-browse-url (original url &optional new-window)
  "Handle gemini links."
  (cond ((string-match-p "\\`\\(gemini\\|gopher\\)://" url)
	 (require 'elpher)
	 (elpher-go url))
	(t (funcall original url new-window))))


;; GENERAL
(use-package general)
(general-create-definer my-leader-def
  ;; :prefix my-leader
  :prefix "SPC")
(my-leader-def
  :keymaps 'normal
  ;; bind "SPC a"
  "a" 'org-agenda
  "f" 'projectile-find-file)
