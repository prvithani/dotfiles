;;; prashant-catppuccin-macchiato-theme.el --- inspired by catppuccin/emacs (macchiato) -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: September 4 2026
;; Author: Catppuccin <https://github.com/catppuccin>
;; Maintainer:
;; Source: https://github.com/catppuccin/emacs
;; Palette: https://github.com/catppuccin/catppuccin
;;
;;; Commentary:
;;
;; Catppuccin Macchiato - the medium-contrast Catppuccin flavor, with gentle
;; pastel accents on a deep blue-grey base.
;;
;; Face structure follows prashant-kanagawa-wave-vibrant: one hue per syntax
;; class, bold italic keywords, bold builtins and numbers.
;;
;; All derived colors use `doom-blend' between palette colors, so the same
;; face list serves the dark and light flavors; only the palette block differs.
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup prashant-catppuccin-macchiato-theme nil
  "Options for the `prashant-catppuccin-macchiato' theme."
  :group 'doom-themes)

(defcustom prashant-catppuccin-macchiato-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'prashant-catppuccin-macchiato-theme
  :type 'boolean)

(defcustom prashant-catppuccin-macchiato-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'prashant-catppuccin-macchiato-theme
  :type 'boolean)

(defcustom prashant-catppuccin-macchiato-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'prashant-catppuccin-macchiato-theme
  :type '(choice integer boolean))

(defcustom prashant-catppuccin-macchiato-red-cursor nil
  "If non-nil, cursor will be red instead of rosewater."
  :group 'prashant-catppuccin-macchiato-theme
  :type 'boolean)

(defcustom prashant-catppuccin-macchiato-match-org-blocks nil
  "If non-nil, org block delimiters use the same colors."
  :group 'prashant-catppuccin-macchiato-theme
  :type 'boolean)

;;
;;; Theme definition

(def-doom-theme prashant-catppuccin-macchiato
    "A dark theme based on Catppuccin Macchiato."
  :family 'prashant-catppuccin
  :background-mode 'dark

  ;; name          default   256       16
  ;; Catppuccin palette
  ((ctp-rosewater '("#f4dbd6" "#ffd7d7" "brightred"))
   (ctp-flamingo  '("#f0c6c6" "#ffd7d7" "brightred"))
   (ctp-pink      '("#f5bde6" "#ffafd7" "brightmagenta"))
   (ctp-mauve     '("#c6a0f6" "#d7afff" "magenta"))
   (ctp-red       '("#ed8796" "#ff8787" "red"))
   (ctp-maroon    '("#ee99a0" "#ff87af" "brightred"))
   (ctp-peach     '("#f5a97f" "#ffaf87" "brightred"))
   (ctp-yellow    '("#eed49f" "#ffd7af" "yellow"))
   (ctp-green     '("#a6da95" "#afd787" "green"))
   (ctp-teal      '("#8bd5ca" "#87d7d7" "brightgreen"))
   (ctp-sky       '("#91d7e3" "#87d7d7" "brightcyan"))
   (ctp-sapphire  '("#7dc4e4" "#87d7d7" "cyan"))
   (ctp-blue      '("#8aadf4" "#87afff" "blue"))
   (ctp-lavender  '("#b7bdf8" "#afafff" "brightblue"))
   (ctp-text      '("#cad3f5" "#d7d7ff" "white"))
   (ctp-subtext1  '("#b8c0e0" "#afafd7" "brightwhite"))
   (ctp-subtext0  '("#a5adcb" "#afafd7" "brightwhite"))
   (ctp-overlay2  '("#939ab7" "#8787af" "brightblack"))
   (ctp-overlay1  '("#8087a2" "#8787af" "brightblack"))
   (ctp-overlay0  '("#6e738d" "#767676" "brightblack"))
   (ctp-surface2  '("#5b6078" "#5f5f87" "brightblack"))
   (ctp-surface1  '("#494d64" "#585858" "brightblack"))
   (ctp-surface0  '("#363a4f" "#444444" "brightblack"))
   (ctp-base      '("#24273a" "#303030" "black"))
   (ctp-mantle    '("#1e2030" "#262626" "black"))
   (ctp-crust     '("#181926" "#1c1c1c" "black"))

   ;; Doom grey ladder: crust -> text
   (bg         ctp-base)
   (bg-alt     ctp-mantle)
   (base0      ctp-crust)
   (base1      ctp-mantle)
   (base2      ctp-surface0)
   (base3      ctp-surface1)
   (base4      ctp-surface2)
   (base5      ctp-overlay0)
   (base6      ctp-overlay1)
   (base7      ctp-overlay2)
   (base8      ctp-subtext0)
   (fg         ctp-text)
   (fg-alt     ctp-subtext1)
   (grey       base5)

   ;; Doom universal hues
   (red        ctp-red)
   (orange     ctp-peach)
   (green      ctp-green)
   (teal       ctp-teal)
   (yellow     ctp-yellow)
   (blue       ctp-blue)
   (dark-blue  ctp-sapphire)
   (magenta    ctp-pink)
   (violet     ctp-mauve)
   (cyan       ctp-sky)
   (dark-cyan  ctp-sapphire)

   ;; Face categories
   (highlight      ctp-blue)
   (vertical-bar   ctp-crust)
   (selection      ctp-surface1)
   (builtin        ctp-red)
   (comments       (if prashant-catppuccin-macchiato-brighter-comments ctp-overlay2 ctp-overlay0))
   (doc-comments   (if prashant-catppuccin-macchiato-brighter-comments ctp-subtext0 ctp-overlay2))
   (constants      ctp-peach)
   (functions      ctp-blue)
   (keywords       ctp-mauve)
   (methods        ctp-sapphire)
   (operators      ctp-sky)
   (type           ctp-yellow)
   (strings        ctp-green)
   (variables      ctp-flamingo)
   (numbers        ctp-maroon)
   (region         ctp-surface1)
   (error          ctp-red)
   (warning        ctp-yellow)
   (success        ctp-green)
   (vc-modified    ctp-peach)
   (vc-added       ctp-green)
   (vc-deleted     ctp-red)

   ;; Mode-line configuration
   (modeline-fg              fg)
   (modeline-fg-alt          ctp-subtext0)
   (modeline-bg              (if prashant-catppuccin-macchiato-brighter-modeline
                                 (doom-blend ctp-blue ctp-base 0.3)
                               ctp-mantle))
   (modeline-bg-alt          (if prashant-catppuccin-macchiato-brighter-modeline
                                 (doom-blend ctp-blue ctp-base 0.25)
                               ctp-crust))
   (modeline-bg-inactive     ctp-crust)
   (modeline-bg-inactive-alt ctp-crust)

   (-modeline-pad
    (when prashant-catppuccin-macchiato-padded-modeline
      (if (integerp prashant-catppuccin-macchiato-padded-modeline)
          prashant-catppuccin-macchiato-padded-modeline
        4))))

  ;;;; Base theme face overrides
  (
   ;; Basic faces
   (default :background bg :foreground fg)
   (cursor :background (if prashant-catppuccin-macchiato-red-cursor ctp-red ctp-rosewater) :foreground base0)
   (hl-line :background ctp-surface0)
   (region :background region :distant-foreground fg)
   ((line-number &override) :foreground ctp-surface1 :background bg)
   ((line-number-current-line &override) :foreground ctp-lavender :background ctp-surface0 :bold t)
   (fringe :background bg :foreground ctp-surface1)
   (vertical-border :foreground ctp-surface1)
   ((link &override) :foreground ctp-lavender)

   ;; Font lock
   ((font-lock-comment-face &override) :foreground comments :italic t
    :background (if prashant-catppuccin-macchiato-brighter-comments (doom-blend ctp-surface0 bg 0.5)))
   ((font-lock-comment-delimiter-face &override) :foreground comments :italic t)
   ((font-lock-doc-face &override) :foreground doc-comments :italic t)
   ((font-lock-constant-face &override) :weight 'semi-bold)
   ((font-lock-keyword-face &override) :weight 'bold :italic t)
   ((font-lock-number-face &override) :weight 'bold)
   ((font-lock-function-name-face &override) :weight 'medium)
   ((font-lock-type-face &override) :weight 'medium)
   ((font-lock-builtin-face &override) :weight 'bold)
   ((font-lock-warning-face &override) :foreground ctp-peach)
   ((font-lock-variable-use-face &override) :foreground ctp-rosewater)
   ((font-lock-property-name-face &override) :foreground ctp-lavender)
   ((font-lock-negation-char-face &override) :foreground ctp-red)
   ((font-lock-preprocessor-face &override) :foreground ctp-pink)
   ((font-lock-regexp-grouping-backslash &override) :foreground ctp-pink)
   ((font-lock-regexp-grouping-construct &override) :foreground ctp-pink)
   ;; ((font-lock-string-face &override) :foreground strings)
   ;; ((font-lock-variable-name-face &override) :foreground variables)

   ;; Mode-line
   (mode-line
    :background modeline-bg :foreground modeline-fg :bold t
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if prashant-catppuccin-macchiato-brighter-modeline base8 highlight))
   (mode-line-buffer-id :foreground ctp-lavender :bold t)
   (mode-line-highlight :foreground ctp-yellow)

   ;; Highlighting
   (highlight :background ctp-surface1 :foreground ctp-lavender)
   (match :background ctp-yellow :foreground base0 :bold t)
   (trailing-whitespace :background ctp-surface2)
   (lazy-highlight :background (doom-blend ctp-sapphire bg 0.35) :foreground fg :bold t)
   ((isearch &override) :background ctp-peach :foreground base0 :bold t)
   ((isearch-fail &override) :background ctp-red :foreground bg)
   (show-paren-match :background ctp-teal :foreground base0 :bold t)
   (show-paren-mismatch :background ctp-red :foreground fg-alt)

   ;;;; centaur-tabs
   (centaur-tabs-active-bar-face :background ctp-blue :foreground fg)
   (centaur-tabs-selected :background bg :foreground fg :bold t)
   (centaur-tabs-selected-modified :background bg :foreground fg)
   (centaur-tabs-modified-marker-selected :background bg :foreground vc-modified)
   (centaur-tabs-close-selected :inherit 'centaur-tabs-selected)
   (centaur-tabs-unselected :background ctp-crust :foreground ctp-overlay0)
   (centaur-tabs-default :background ctp-crust :foreground ctp-overlay0)
   (centaur-tabs-unselected-modified :background ctp-crust :foreground ctp-red)
   (centaur-tabs-modified-marker-unselected :background ctp-crust :foreground ctp-overlay0)
   (centaur-tabs-close-unselected :background ctp-crust :foreground ctp-overlay0)
   (centaur-tabs-close-mouse-face :background nil :foreground ctp-red)

   ;;;; company
   (company-tooltip :background ctp-surface0 :foreground fg)
   (company-tooltip-common :foreground ctp-yellow :bold t)
   (company-tooltip-quick-access :foreground ctp-lavender)
   (company-tooltip-scrollbar-thumb :background ctp-surface2)
   (company-tooltip-scrollbar-track :background ctp-surface0)
   (company-tooltip-search :background ctp-yellow :foreground base0 :distant-foreground fg)
   (company-tooltip-selection :background (doom-blend ctp-sapphire bg 0.35) :foreground fg :bold t)
   (company-tooltip-mouse :background ctp-surface1 :foreground base0 :distant-foreground fg)
   (company-tooltip-annotation :foreground ctp-maroon :distant-foreground base1)
   (company-scrollbar-bg :inherit 'tooltip)
   (company-scrollbar-fg :background ctp-surface2)
   (company-preview :foreground ctp-yellow)
   (company-preview-common :foreground ctp-yellow :bold t)
   (company-preview-search :inherit 'company-tooltip-search)
   (company-template-field :inherit 'match)

   ;;;; css-mode / scss-mode
   (css-proprietary-property :foreground ctp-peach)
   (css-property :foreground ctp-green)
   (css-selector :foreground ctp-blue)

   ;;;; dashboard
   (dashboard-heading :foreground ctp-lavender :bold t)
   (dashboard-items-face :foreground fg)
   (dashboard-banner-logo-title :bold t :height 200)
   (dashboard-no-items-face :foreground ctp-overlay0)

   ;;; Doom Dashboard
   (doom-dashboard-banner :foreground comments :slant 'normal)
   (doom-dashboard-loaded :foreground comments :slant 'normal)
   (doom-dashboard-menu-title :foreground keywords :weight 'semi-bold :slant 'normal)

   ;;;; diff-mode
   (diff-indicator-added   :foreground vc-added)
   (diff-added
    :foreground 'unspecified
    :distant-foreground fg
    :background (doom-blend vc-added bg 0.15))
   (diff-refine-added
    :foreground 'unspecified
    :distant-foreground fg
    :background (doom-blend vc-added bg 0.4))
   (diff-indicator-changed :foreground vc-modified)
   (diff-changed
    :foreground 'unspecified
    :distant-foreground fg
    :background (doom-blend vc-modified bg 0.15))
   (diff-refine-changed
    :foreground 'unspecified
    :distant-foreground fg
    :background (doom-blend vc-modified bg 0.4))
   (diff-indicator-removed :foreground vc-deleted)
   (diff-removed
    :foreground 'unspecified
    :distant-foreground fg
    :background (doom-blend vc-deleted bg 0.15))
   (diff-refine-removed
    :foreground 'unspecified
    :distant-foreground fg
    :background (doom-blend vc-deleted bg 0.4))

   ;;;; doom-modeline
   (doom-modeline-bar :background (if prashant-catppuccin-macchiato-brighter-modeline modeline-bg ctp-lavender) :bold t)
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold :foreground ctp-teal)
   (doom-modeline-buffer-project-root :foreground ctp-peach :weight 'bold)
   (doom-modeline-buffer-modified :foreground ctp-yellow :bold t)
   (doom-modeline-buffer-major-mode :foreground ctp-teal :bold t)
   (doom-modeline-panel :inherit 'bold :background ctp-peach :foreground base0)
   (doom-modeline-info :bold t :foreground ctp-green)
   (doom-modeline-warning :foreground ctp-yellow :bold t)
   (doom-modeline-urgent :foreground ctp-red :bold t)
   (doom-modeline-evil-normal-state :foreground ctp-blue)
   (doom-modeline-evil-insert-state :foreground ctp-green)
   (doom-modeline-evil-visual-state :foreground ctp-mauve)
   (doom-modeline-evil-replace-state :foreground ctp-red)
   (doom-modeline-evil-motion-state :foreground ctp-sky)
   (doom-modeline-evil-emacs-state :foreground ctp-peach)

   ;;;; ediff
   (ediff-current-diff-A :background (doom-blend ctp-red bg 0.2) :foreground fg)
   (ediff-current-diff-B :background (doom-blend ctp-green bg 0.2) :foreground fg)
   (ediff-current-diff-C :background (doom-blend ctp-blue bg 0.2) :foreground fg)
   (ediff-fine-diff-A :background ctp-red :foreground bg :bold t)
   (ediff-fine-diff-B :background ctp-green :foreground bg :bold t)
   (ediff-fine-diff-C :background ctp-yellow :foreground bg :bold t)

   ;;;; evil
   (evil-ex-lazy-highlight :background ctp-green :foreground base0 :bold t)
   (evil-ex-substitute-matches :background ctp-red :foreground base0 :bold t)
   (evil-ex-substitute-replacement :foreground ctp-peach :strike-through nil)
   (evil-search-highlight-persist-highlight-face :background ctp-yellow :foreground base0)

   ;;;; flycheck
   (flycheck-error (:underline `(:style wave :color ,ctp-red)))
   (flycheck-warning (:underline `(:style wave :color ,ctp-yellow)))
   (flycheck-info (:underline `(:style wave :color ,ctp-sky)))
   (flycheck-fringe-error :foreground ctp-red)
   (flycheck-fringe-warning :foreground ctp-yellow)
   (flycheck-fringe-info :foreground ctp-sky)

   ;;;; git-gutter
   (git-gutter:added :foreground vc-added :background bg)
   (git-gutter:modified :foreground vc-modified :background bg)
   (git-gutter:deleted :foreground vc-deleted :background bg)

   ;;;; indent-guides
   (highlight-indent-guides-character-face :foreground ctp-surface2)
   (highlight-indent-guides-stack-character-face :foreground ctp-surface2)
   (highlight-indent-guides-stack-odd-face :foreground ctp-surface2)
   (highlight-indent-guides-stack-even-face :foreground ctp-surface1)
   (highlight-indent-guides-even-face :foreground ctp-surface0)
   (highlight-indent-guides-odd-face :foreground ctp-surface1)

   ;;;; ivy
   (ivy-current-match :background ctp-blue :foreground base0 :bold t)
   (ivy-action :background nil :foreground fg)
   (ivy-grep-line-number :background nil :foreground ctp-green)
   (ivy-minibuffer-match-face-1 :background nil :foreground ctp-red)
   (ivy-minibuffer-match-face-2 :background nil :foreground ctp-green)
   (ivy-minibuffer-match-face-3 :background nil :foreground ctp-sky)
   (ivy-minibuffer-match-face-4 :background nil :foreground ctp-yellow)
   (ivy-minibuffer-match-highlight :foreground ctp-sky)
   (ivy-grep-info :foreground ctp-sky)
   (ivy-confirm-face :foreground ctp-teal)
   (ivy-posframe :background ctp-surface0)
   (ivy-posframe-border :background ctp-surface1)

   ;;;; LaTeX-mode
   (font-latex-math-face :foreground ctp-green)
   (font-latex-script-char-face :foreground ctp-sky)

   ;;;; lsp-mode and lsp-ui
   (lsp-face-highlight-textual :background (doom-blend ctp-sapphire bg 0.35))
   (lsp-face-highlight-read :background (doom-blend ctp-sapphire bg 0.35))
   (lsp-face-highlight-write :background (doom-blend ctp-sapphire bg 0.35))
   (lsp-headerline-breadcrumb-path-error-face (:underline (:color ctp-red :style wave) :foreground ctp-overlay0 :background ctp-mantle))
   (lsp-headerline-breadcrumb-path-face :background ctp-mantle :foreground fg)
   (lsp-headerline-breadcrumb-symbols-error-face :foreground ctp-red)
   (lsp-ui-doc-background :background ctp-mantle :foreground fg)
   (lsp-ui-doc-header :background ctp-mantle :foreground fg :bold t)
   (lsp-ui-doc-border :foreground ctp-surface1)
   (lsp-ui-sideline-code-action :foreground ctp-yellow)
   (lsp-ui-sideline-current-symbol :foreground ctp-blue)
   (lsp-ui-sideline-symbol :foreground ctp-sapphire)
   (lsp-ui-peek-filename :foreground ctp-sky)

   ;;;; markdown-mode
   (markdown-markup-face :foreground ctp-overlay0)
   (markdown-header-face :inherit 'bold :foreground ctp-red)
   (markdown-header-face-1 :foreground ctp-red :height 1.3 :bold t)
   (markdown-header-face-2 :foreground ctp-peach :height 1.15 :bold t)
   (markdown-header-face-3 :foreground ctp-yellow :height 1.05)
   (markdown-header-face-4 :foreground ctp-green)
   (markdown-header-face-5 :foreground ctp-sapphire)
   (markdown-header-face-6 :foreground ctp-lavender)
   ((markdown-code-face &override) :background ctp-mantle :foreground ctp-green)
   (markdown-inline-code-face :background ctp-mantle :foreground ctp-green)
   (markdown-blockquote-face :foreground ctp-lavender)

   ;;;; org-mode
   (org-block :background ctp-mantle)
   (org-block-begin-line
    :background (if prashant-catppuccin-macchiato-match-org-blocks ctp-mantle (doom-blend ctp-blue bg 0.2))
    :foreground (if prashant-catppuccin-macchiato-match-org-blocks ctp-overlay0 ctp-blue))
   (org-block-end-line
    :background (if prashant-catppuccin-macchiato-match-org-blocks ctp-mantle (doom-blend ctp-red bg 0.2))
    :foreground (if prashant-catppuccin-macchiato-match-org-blocks ctp-overlay0 ctp-red))
   (org-code :background ctp-mantle :foreground ctp-green)
   (org-meta-line :background (doom-blend ctp-green bg 0.2) :foreground ctp-green)
   (org-level-1 :foreground ctp-red :bold t)
   (org-level-2 :foreground ctp-peach :bold t)
   (org-level-3 :foreground ctp-yellow)
   (org-level-4 :foreground ctp-green)
   (org-level-5 :foreground ctp-sapphire)
   (org-level-6 :foreground ctp-lavender)
   (org-level-7 :foreground ctp-mauve)
   (org-level-8 :foreground ctp-maroon)
   (org-todo :foreground ctp-peach :bold t)
   (org-done :foreground ctp-sapphire :strike-through t)
   (org-headline-done :foreground ctp-sapphire :strike-through t)
   (org-ellipsis :foreground ctp-surface2 :bold t)
   (org-date :foreground ctp-sapphire)
   (org-footnote :foreground ctp-teal)

   ;;;; rainbow-delimiters
   (rainbow-delimiters-mismatched-face :foreground ctp-red)
   (rainbow-delimiters-unmatched-face :foreground ctp-red)
   (rainbow-delimiters-base-error-face :foreground ctp-red)
   (rainbow-delimiters-base-face :foreground ctp-overlay0)
   (rainbow-delimiters-depth-1-face :foreground ctp-red)
   (rainbow-delimiters-depth-2-face :foreground ctp-yellow)
   (rainbow-delimiters-depth-3-face :foreground ctp-blue)
   (rainbow-delimiters-depth-4-face :foreground ctp-peach)
   (rainbow-delimiters-depth-5-face :foreground ctp-green)
   (rainbow-delimiters-depth-6-face :foreground ctp-mauve)
   (rainbow-delimiters-depth-7-face :foreground ctp-teal)
   (rainbow-delimiters-depth-8-face :foreground ctp-pink)
   (rainbow-delimiters-depth-9-face :foreground ctp-sapphire)

   ;;;; solaire-mode
   (solaire-default-face :background ctp-mantle)
   (solaire-hl-line-face :background ctp-surface0)
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt)))

   ;;;; treemacs
   (treemacs-root-face :foreground fg :bold t :height 1.2)
   (treemacs-directory-face :foreground fg)
   (treemacs-directory-collapsed-face :foreground fg)
   (treemacs-file-face :foreground fg)
   (treemacs-git-added-face :foreground vc-added)
   (treemacs-git-modified-face :foreground vc-modified)
   (treemacs-git-renamed-face :foreground ctp-sky)
   (treemacs-git-conflict-face :foreground ctp-red)
   (treemacs-git-untracked-face :foreground ctp-teal)
   (treemacs-git-ignored-face :foreground ctp-overlay0)
   (treemacs-git-unmodified-face :foreground fg)

   ;;;; vertico
   (vertico-current :background (doom-blend ctp-blue bg 0.2) :foreground ctp-yellow :bold t)
   (vertico-multiline :background ctp-red)
   (vertico-group-title :background (doom-blend ctp-blue bg 0.2) :foreground ctp-sky :bold t)
   (vertico-group-separator :background (doom-blend ctp-blue bg 0.2) :foreground ctp-sky :strike-through t)
   (vertico-posframe-border :background ctp-surface1)
   (vertico-posframe :background ctp-surface0)

   ;;;; which-key
   (which-key-command-description-face :foreground ctp-blue)
   (which-key-group-description-face :foreground ctp-red)
   (which-key-local-map-description-face :foreground ctp-yellow)
   (which-key-key-face :foreground ctp-teal)
   (which-key-posframe :background ctp-mantle)
   (which-key-posframe-border :background ctp-mantle)

   ;;;; whitespace-mode
   (whitespace-space :foreground ctp-surface2)
   (whitespace-tab :foreground ctp-surface2)
   (whitespace-newline :foreground ctp-surface2)
   (whitespace-trailing :background ctp-surface2)
   (whitespace-line :background (doom-blend ctp-red bg 0.2) :foreground ctp-red))


  ;;;; Base theme variable overrides
  ())

;;; prashant-catppuccin-macchiato-theme.el ends here
