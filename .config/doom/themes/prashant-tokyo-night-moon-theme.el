
;; doom-tokyo-night-moon-theme.el --- inspired by Folke's Tokyo Night port for Neovim -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: August 19, 2024
;; Author: Foster Hangdaan <https://code.fosterhangdaan.com/foster>
;; Maintainer:
;; Source: https://github.com/folke/tokyonight.nvim
;;
;; Commentary:
;; Code:

(require 'doom-themes)


;;
;; Variables

(defgroup prashant-tokyo-night-moon-theme nil
  "Options for doom-themes."
  :group 'doom-themes)

(defcustom prashant-tokyo-night-moon-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'prashant-tokyo-night-moon-theme
  :type 'boolean)

(defcustom prashant-tokyo-night-moon-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'prashant-tokyo-night-moon-theme
  :type 'boolean)

(defcustom prashant-tokyo-night-moon-comment-bg prashant-tokyo-night-moon-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their legibility."
  :group 'prashant-tokyo-night-moon-theme
  :type 'boolean)

(defcustom prashant-tokyo-night-moon-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to determine the exact padding."
  :group 'prashant-tokyo-night-moon-theme
  :type '(or integer boolean))


;;
;; Theme definition

(def-doom-theme prashant-tokyo-night-moon
    "A variant of Tokyo Night based on Folke's port for Neovim."

  ;; name        default   256       16
  ((bg         '("#222436" nil       nil            ))
   (bg-alt     '("#1e2030" nil       nil            ))
   (base0      '("#444a73" "#444a73" "black"        ))
   (base1      '("#4d5482" "#4d5482" "brightblack"  ))
   (base2      '("#555d91" "#555d91" "brightblack"  ))
   (base3      '("#5e67a0" "#5e67a0" "brightblack"  ))
   (base4      '("#6c74a9" "#6c74a9" "brightblack"  ))
   (base5      '("#7b82b1" "#7b82b1" "brightblack"  ))
   (base6      '("#8990ba" "#8990ba" "brightblack"  ))
   (base7      '("#989ec3" "#989ec3" "brightblack"  ))
   (base8      '("#a7accb" "#a7accb" "brightblack"  ))
   (fg-alt     '("#828bb8" "#828bb8" "brightwhite"  ))
   (fg         '("#c8d3f5" "#c8d3f5" "white"        ))

   (grey       base4)
   (red        '("#ff757f" "#ff757f" "red"          ))
   (orange     '("#ff966c" "#ff966c" "brightred"    ))
   (green      '("#c3e88d" "#c3e88d" "green"        ))
   (teal       '("#4fd6be" "#4fd6be" "brightgreen"  ))
   (yellow     '("#ffc777" "#ffc777" "yellow"       ))
   (blue       '("#82aaff" "#82aaff" "brightblue"   ))
   (dark-blue  '("#3e68d7" "#3e68d7" "blue"         ))
   (light-blue  '("#9BBBFF" "#9BBBFF" "blue"        ))
   (magenta    '("#c099ff" "#c099ff" "magenta"      ))
   (violet     '("#fca7ea" "#fca7ea" "brightmagenta"))
   (cyan       '("#86e1fc" "#86e1fc" "brightcyan"   ))
   (dark-cyan  '("#5D9DB0" "#5D9DB0" "cyan"         ))

   ;; Additional custom colors
   (dark-green '("#41a6b5" "#41a6b5" "green"        ))
   (bg-dark1 "#191B29")
   (bg-highlight "#2f334d")
   (blue1 "#65bcff")
   (blue2 "#0db9d7")
   (blue5 "#89ddff")
   (blue6 "#b4f9f8")
   (blue7 "#394b70")
   (comment "#636da6")
   (dark3 "#545c7e")
   (dark5 "#737aa2")
   (fg-gutter "#3b4261")
   (magenta2 "#ff007c")
   (red1 "#c53b53")

   ;; face categories -- required for all themes
   (highlight      dark-cyan)
   (vertical-bar   (doom-lighten bg 0.05))
   (selection      base0)
   (builtin        (doom-lighten red1 0.5))
   (comments       (if prashant-tokyo-night-moon-brighter-comments (doom-lighten comment 0.25) comment))
   (doc-comments   (doom-lighten comments 0.25))
   (constants      teal)
   (functions      magenta)
   (keywords       violet)
   (methods        blue2)
   (operators      magenta2)
   (type           blue1)
   (strings        green)
   (variables      cyan)
   (numbers        red)
   (region         (doom-lighten bg-highlight 0.15))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    "#7ca1f2")
   (vc-added       "#b8db87")
   (vc-deleted     "#e26a75")

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright prashant-tokyo-night-moon-brighter-modeline)
   (-modeline-pad
    (when prashant-tokyo-night-moon-padded-modeline
      (if (integerp prashant-tokyo-night-moon-padded-modeline) prashant-tokyo-night-moon-padded-modeline 4)))

   (modeline-fg     'unspecified)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        base3
      `(,(doom-darken (car bg) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        base3
      `(,(doom-darken (car bg) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(car bg) ,@(cdr base1))))


  ;; --- Extra Faces ------------------------
  (
   ;; Basic faces
   (hl-line :background bg-highlight)
   (solaire-hl-line-face  :inherit 'hl-line :background bg-highlight :extend t)

   ((line-number-current-line &override) :foreground base8)
   ((line-number &override) :foreground base2 :background (doom-darken bg 0.25))
   (vertical-border :foreground base3)

   ;; Font lock
   ((font-lock-comment-face &override) :foreground comments :slant 'italic
    :background (if prashant-tokyo-night-moon-comment-bg (doom-lighten bg 0.05) 'unspecified))
   ((font-lock-comment-delimiter-face &override) :foreground comments :italic t)
   ((font-lock-doc-face &override) :inherit 'font-lock-comment-face :foreground doc-comments)
   ((font-lock-constant-face &override) :foreground constants :weight 'semi-bold)
   ((font-lock-keyword-face &override) :foreground keywords :weight 'bold :slant 'italic)
   ((font-lock-number-face &override) :foreground numbers :weight 'bold)
   ((font-lock-function-name-face &override) :foreground functions :weight 'medium)
   ((font-lock-type-face &override) :foreground type :weight 'medium)
   ((font-lock-builtin-face &override) :foreground builtin :weight 'bold)
   ((font-lock-warning-face &override) :foreground warning)
   ((font-lock-variable-use-face &override) :foreground blue6)
   ((font-lock-negation-char-face &override) :foreground red)
   ((font-lock-preprocessor-face &override) :foreground (doom-lighten operators 0.5))
   ;; ((font-lock-regexp-grouping-backslash &override) :foreground operators)
   ;; ((font-lock-string-face &override) :foreground strings)
   ;; ((font-lock-variable-name-face &override) :foreground variables)

   ;; Doom Modeline
   (doom-modeline-buffer-path       :foreground blue :weight 'bold)
   (doom-modeline-buffer-major-mode :inherit 'doom-modeline-buffer-path)
   (doom-modeline-buffer-file       :foreground magenta :weight 'bold)
   (doom-modeline-project-dir       :foreground green :weight 'bold)

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))
   (mode-line-buffer-id
    :foreground highlight)

   ;; Doom Dashboard
   (doom-dashboard-banner :foreground comments :slant 'normal)
   (doom-dashboard-loaded :foreground comments :slant 'normal)
   (doom-dashboard-menu-title :foreground keywords :weight 'semi-bold :slant 'normal)

   ;; Indentation
   (whitespace-indentation :background bg)
   (whitespace-tab :background bg)

   ;; Ivy
   (ivy-subdir :foreground blue)
   (ivy-minibuffer-match-face-1 :foreground green :background bg-alt)
   (ivy-minibuffer-match-face-2 :foreground orange :background bg-alt)
   (ivy-minibuffer-match-face-3 :foreground red :background bg-alt)
   (ivy-minibuffer-match-face-4 :foreground yellow :background bg-alt)

   ;; Elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ;; Solaire
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; Telephone
   (telephone-line-accent-active
    :inherit 'mode-line
    :background (doom-lighten bg 0.2))
   (telephone-line-accent-inactive
    :inherit 'mode-line
    :background (doom-lighten bg 0.05))
   (telephone-line-evil-emacs
    :inherit 'mode-line
    :background dark-blue)

   ;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground fg)
   (rainbow-delimiters-depth-2-face :foreground blue)
   (rainbow-delimiters-depth-3-face :foreground orange)
   (rainbow-delimiters-depth-4-face :foreground green)
   (rainbow-delimiters-depth-5-face :foreground cyan)
   (rainbow-delimiters-depth-6-face :foreground yellow)
   (rainbow-delimiters-depth-7-face :foreground teal)

   ;; Treemacs
   (treemacs-root-face :foreground magenta :weight 'bold :height 1.2)
   (doom-themes-treemacs-root-face :foreground magenta :weight 'ultra-bold :height 1.2)
   (doom-themes-treemacs-file-face :foreground fg-alt)
   (treemacs-directory-face :foreground cyan :weight 'semi-bold)
   (treemacs-file-face :foreground fg)
   (treemacs-git-modified-face :foreground green)
   (treemacs-git-renamed-face :foreground yellow)

   ;; Magit
   (magit-section-heading :foreground blue)
   (magit-branch-remote   :foreground orange)
   (magit-diff-our :foreground (doom-darken vc-deleted 0.2) :background (doom-darken vc-deleted 0.7))
   (magit-diff-our-highlight :foreground vc-deleted :background (doom-darken vc-deleted 0.5) :weight 'bold)
   (magit-diff-removed :foreground (doom-darken vc-deleted 0.2) :background (doom-darken vc-deleted 0.7))
   (magit-diff-removed-highlight :foreground vc-deleted :background (doom-darken vc-deleted 0.5) :weight 'bold)
   (magit-diff-hunk-heading :foreground bg :background base1 :weight 'bold)
   (magit-diff-hunk-heading-highlight :foreground bg :background base5 :weight 'bold)

   ;; --- Major-Mode Faces -------------------
   ;; elisp
   (highlight-quoted-symbol :foreground yellow)

   ;; js2-mode
   (js2-function-param :foreground yellow)
   (js2-object-property :foreground dark-green)

   ;; typescript-mode
   (typescript-this-face :foreground red)
   (typescript-access-modifier-face :foreground yellow)

   ;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-text :foreground violet)
   (rjsx-attr :foreground magenta :slant 'italic :weight 'medium)
   (rjsx-tag-bracket-face :foreground (doom-darken red 0.3))

   ;; css-mode / scss-mode
   (css-property             :foreground blue)
   (css-selector             :foreground teal)
   (css-pseudo-class         :foreground orange)

   ;; markdown-mode
   (markdown-markup-face :foreground violet)
   (markdown-header-face :inherit 'bold :foreground dark-cyan)
   (markdown-blockquote-face :foreground violet :background (doom-lighten bg 0.04))
   (markdown-table-face :foreground violet :background (doom-lighten bg 0.04))
   ((markdown-code-face &override) :foreground dark-cyan :background (doom-lighten bg 0.04))

   ;; org-mode
   (org-hide :foreground hidden)
   (org-block :background (doom-darken bg 0.25))
   (org-block-begin-line :background (doom-darken bg 0.25) :foreground comments :extend t)
   (solaire-org-hide-face :foreground hidden)

   ;; cider
   (cider-debug-code-overlay-face :background "grey30")
   (cider-result-overlay-face :background "grey10" :box `(:line-width -1 :color ,base5))

   ;; web-mode
   (web-mode-json-context-face :foreground yellow)
   (web-mode-json-key-face :foreground teal)
   (web-mode-keyword-face :inherit 'font-lock-keyword-face)
   ;; Block
   (web-mode-block-delimiter-face :foreground yellow)
   ;; Code
   (web-mode-constant-face :foreground constants)
   (web-mode-variable-name-face :foreground variables)
   ;; CSS
   (web-mode-css-pseudo-class-face :foreground orange)
   (web-mode-css-property-name-face :foreground blue)
   (web-mode-css-selector-face :foreground teal)
   (web-mode-css-selector-class-face :foreground keywords :slant 'normal)
   (web-mode-css-selector-tag-face :inherit 'web-mode-css-selector-class-face)
   (web-mode-css-function-face :foreground yellow)
   ;; HTML
   (web-mode-html-attr-engine-face :foreground yellow)
   (web-mode-html-attr-equal-face :foreground operators)
   (web-mode-html-attr-name-face :foreground magenta)
   (web-mode-html-tag-bracket-face :foreground (doom-darken red 0.3))
   (web-mode-html-tag-face :foreground red))


  ;; --- extra variables ---------------------
  ;; ()
  )

;; prashant-tokyo-night-moon-theme.el ends here
