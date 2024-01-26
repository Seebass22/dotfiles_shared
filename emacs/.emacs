(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-verbose t)

(eval-when-compile
  (require 'use-package))

(use-package exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq use-package-always-ensure t)

(use-package diminish)

(use-package undo-fu)

;; EVIL
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  :init
  (setq evil-undo-system 'undo-fu))
(use-package evil-collection
  :after evil
  :custom
  (evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))
(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))
(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))
(evil-select-search-module 'evil-search-module 'evil-search)
(use-package evil-numbers)
;; Vim increment/decrement keys.
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
(define-key evil-visual-state-map (kbd "g C-a") 'evil-numbers/inc-at-pt-incremental)
(define-key evil-visual-state-map (kbd "g C-x") 'evil-numbers/dec-at-pt-incremental)

;; IVY
(use-package ivy
  :diminish ivy-mode
  :config
  (ivy-mode 1))
(use-package counsel
  :config
  (counsel-mode))
(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))


;; THEMES
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))
;; run nerd-icons-install-fonts
(use-package doom-themes
  :config
  (load-theme 'doom-one t)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


;; HELPFUL STUFF
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
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
  (setq projectile-switch-project-action #'projectile-dired))
(use-package ripgrep)

(use-package magit
  :commands magit-status)

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

;; scroll N lines to screen edge
(setq scroll-margin 2)
;; don't recenter after scrolling
(setq scroll-conservatively scroll-margin)

;; enable features disabled by default
(put 'narrow-to-region 'disabled nil)

;; show matching parentheses
(show-paren-mode 1)


;; ORG-MODE
(setq org-log-into-drawer t)
(setq org-catch-invisible-edits 'error)
(setq org-agenda-files
      '("~/Documents/notes/orgnotes/tasklist.org"
	"~/Documents/notes/orgnotes/exams.org"
	"~/Documents/notes/orgnotes/meetups.org"
	"~/Documents/notes/orgnotes/birthdays.org"))
;; allow running elisp and python code blocks
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t))))
;; code block template expansion
;; (<py <TAB> for python block)
(with-eval-after-load 'org
  (require 'org-tempo)
  ;; templates for code blocks
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("R" . "src R"))
  (add-to-list 'org-structure-template-alist '("p" . "src perl"))
  (add-to-list 'org-structure-template-alist '("vh" . "src vhdl"))
  (add-to-list 'org-structure-template-alist '("o" . "src octave"))
  (add-to-list 'org-structure-template-alist '("sw" . "src swift"))
  (add-to-list 'org-structure-template-alist '("lua" . "src lua"))
  (add-to-list 'org-structure-template-alist '("r" . "src rust")))
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
(use-package dired-single
  :after dired)


;; ERC
(setq erc-server "irc.libera.chat"
      erc-nick "Seebass22"
      erc-track-exclude-types '("JOIN" "NICK" "QUIT" "MODE" "AWAY")
      erc-keywords '("vim"))
(use-package erc-hl-nicks
  :after erc
  :config
  (add-to-list 'erc-modules 'hl-nicks))


(use-package flycheck
  :defer t)


;; languages
;; R support
(use-package ess
  :defer t)
;; rust
(use-package rustic
  :defer 5
  :config
  ;; do less when cursor moves
  (setq lsp-signature-auto-activate nil)
  (setq lsp-enable-symbol-highlighting nil)
  ;; disable minibuffer doc
  (setq lsp-eldoc-hook nil)
  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  :custom
  (rustic-analyzer-command '("rustup" "run" "stable" "rust-analyzer")))

(use-package csharp-mode
  :ensure nil
  :config
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-tree-sitter-mode)))

;; TREE-SITTER
(use-package tree-sitter
  :defer 0
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
  (add-to-list 'tree-sitter-major-mode-language-alist '(mhtml-mode . html)))
(use-package tree-sitter-langs
  :after tree-sitter)

;; LSP-MODE
(use-package company
  :after lsp-mode)
(setq company-idle-delay 0.0
      company-minimum-prefix-length 1)
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  ;; (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  (lsp-inlay-hint-enable nil)
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-parameter-hints t)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (lsp-enable-which-key-integration t))
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  ;; (lsp-ui-peek-always-show t)
  ;; (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable t)) ;; maybe change this

(setq lsp-enable-indentation nil)
;; LSP-LANGUAGES
;; python
(use-package lsp-pyright
  :defer 5
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
;; godot
(use-package gdscript-mode
  :config
  (setq warning-suppress-types '((lsp-mode)))
  :hook (gdscript-mode . lsp))


;; YASNIPPET
(use-package yasnippet
  :defer 5
  :config (yas-global-mode 1))
(use-package yasnippet-snippets
  :defer 10)


;; EWW
;; follow gopher and gemini links from EWW
(use-package elpher
  :defer 20)
(advice-add 'eww-browse-url :around 'elpher:eww-browse-url)
(defun elpher:eww-browse-url (original url &optional new-window)
  "Handle gemini links."
  (cond ((string-match-p "\\`\\(gemini\\|gopher\\)://" url)
	 (require 'elpher)
	 (elpher-go url))
	(t (funcall original url new-window))))


;; VTERM
(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000))


;; GENERAL
(use-package general)
(general-create-definer my-leader-def
  ;; :prefix my-leader
  :prefix "SPC")
(my-leader-def
  :keymaps 'normal
  ;; bind "SPC a"
  "a" 'org-agenda
  "f" 'counsel-find-file
  "t" 'vterm
  "d" 'dired-jump
  "e" 'org-edit-special
  "q" 'org-edit-src-exit
  ;; LSP
  "l"   '(:ignore t :which-key "LSP mode stuff")
  "lh" 'lsp-inlay-hints-mode
  "lu" 'lsp-ui-mode
  "ld" 'lsp-rust-analyzer-open-external-docs
  ;; buffer management
  "b" '(:ignore t :which-key "buffer stuff")
  "bb" 'persp-switch-to-buffer
  "bp" 'persp-switch-to-buffer*
  "bi" 'persp-ibuffer
  "br" 'rename-buffer
  ;; workspace management (perspective.el)
  "w" '(:ignore t :which-key "workspace stuff")
  "ws" 'persp-switch
  "wn" 'persp-next
  "wp" 'persp-prev
  "wa" 'persp-add-buffer
  "wA" 'persp-set-buffer
  "wr" 'persp-rename
  "wd" 'persp-kill
  ;; projectile
  "p" '(:ignore t :which-key "project stuff")
  "pp" 'projectile-switch-project
  "pf" 'projectile-find-file
  ;; bookmarks
  "r" '(:ignore t :which-key "bookmarks")
  "rl" 'bookmark-bmenu-list
  "rj" 'bookmark-jump
  "rm" 'bookmark-set
  "rd" 'bookmark-delete
  ;; git
  "g"   '(:ignore t :which-key "git")
  "gs"  'magit-status
  "gd"  'magit-diff-unstaged
  "gF"  'magit-pull-from-pushremote
  "gg"  'magit-file-dispatch
  "gl"   '(:ignore t :which-key "log")
  "gll" 'magit-log-current
  "glf" 'magit-log-buffer-file)
(general-define-key
 :states 'normal
 "C-l" 'evil-ex-nohighlight)


;; C languages indentation style
(setq c-default-style "linux"
      c-basic-offset 4)
;; indent with spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; distraction-free writing
(use-package olivetti
  :commands olivetti-mode)


;; better PDF viewer
(use-package pdf-tools
  :defer 10
  :config
  (pdf-tools-install))

;; Use pdf-tools to open PDF files
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)

;; Update PDF buffers after successful LaTeX runs
(add-hook 'TeX-after-compilation-finished-functions
           #'TeX-revert-document-buffer)


;; email
(let ((email-file  "~/.emacs.d/emacs_email.el"))
  (when (file-exists-p email-file)
    (load-file email-file)))


;; workspace management
(use-package perspective
  :custom
  (persp-suppress-no-prefix-key-warning t)
  :config
  (persp-mode))

(add-hook 'ibuffer-hook
	  (lambda ()
	    (persp-ibuffer-set-filter-groups)
	    (unless (eq ibuffer-sorting-mode 'alphabetic)
	      (ibuffer-do-sort-by-alphabetic))))

(use-package dashboard
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  ;; use standard emacs logo as banner
  (setq dashboard-startup-banner `logo)
  (setq dashboard-center-content t)
  (setq dashboard-set-navigator t)
  (setq dashboard-items '((recents . 5)
			  (agenda . 5 )
			  (bookmarks . 5)
			  (projects . 3)
			  ))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
				    (bookmarks . "book"))))

(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "worktracker")
(setq worktracker-activities '((el . "emacs")
                               (rs . "rust")
                               (py . "python")
                               (org . "kernel dev")
                               (c . "kernel dev")
                               (sh . "linux")
                               (swift . "swift")
                               (gd . "godot")))

;;; cperl-mode is preferred to perl-mode                                        
(defalias 'perl-mode 'cperl-mode)

(setq cperl-indent-level 4
      cperl-close-paren-offset -4
      cperl-continued-statement-offset 2
      cperl-indent-subs-specially nil
      cperl-indent-parens-as-block t)

;; fix splits on desktop
(let ((fix-split-file  "~/.emacs.d/fix_desktop_splits.el"))
  (when (file-exists-p fix-split-file)
    (load-file fix-split-file)))

;;; lua
(use-package lua-mode)

;;; GLSL
(use-package glsl-mode)
(evil-define-key 'normal glsl-mode-map
  "K" 'glsl-find-man-page)
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(glsl-mode . "glsl"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("glslls" "--stdin"))
                    :activation-fn (lsp-activate-on "glsl")
                    :server-id 'glslls)))


(use-package ron-mode)
(use-package fzf
  ;; :bind
  ;; Don't forget to set keybinds!
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        ;; fzf/grep-command "rg --no-heading --line-number --with-filename --smart-case --color-always"
        fzf/grep-command "rg --no-heading --line-number --with-filename --smart-case"
        ;; fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15))
