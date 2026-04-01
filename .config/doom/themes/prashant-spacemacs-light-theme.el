;;; prashant-spacemacs-light-theme.el --- Spacemacs Light ported to Doom -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: April 1, 2026
;; Author: Prashant Vithani (port), Nasser Alshammari (original Spacemacs theme)
;; Maintainer:
;; Source: https://github.com/syl20bnr/spacemacs (spacemacs-theme)
;;
;;; Commentary:
;;
;; A faithful port of the Spacemacs Light theme into the Doom Emacs theme
;; framework, with Prashant's personal customization pattern applied
;; (font-weight overrides, italic keywords, bold numbers, etc.).
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup prashant-spacemacs-light-theme nil
  "Options for the `prashant-spacemacs-light' theme."
  :group 'doom-themes)

(defcustom prashant-spacemacs-light-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'prashant-spacemacs-light-theme
  :type 'boolean)

(defcustom prashant-spacemacs-light-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'prashant-spacemacs-light-theme
  :type 'boolean)

(defcustom prashant-spacemacs-light-comment-bg prashant-spacemacs-light-brighter-comments
  "If non-nil, comments will have a subtle, darker background.
Enhancing their legibility."
  :group 'prashant-spacemacs-light-theme
  :type 'boolean)

(defcustom prashant-spacemacs-light-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'prashant-spacemacs-light-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme prashant-spacemacs-light
    "A light theme based on Spacemacs Light, ported to the Doom framework."
  :family 'prashant-spacemacs
  :background-mode 'light

  ;; name        default   256       16
  ;;
  ;; The Spacemacs light palette, mapped into Doom's base0-base8 ramp.
  ;; bg1 (#fbf8ef) is the main background.
  ;; base (#655370) is the main foreground text.
  ((bg         '("#fbf8ef" "#ffffff" "white"        ))
   (bg-alt     '("#efeae9" "#e4e4e4" "white"        ))
   (base0      '("#fbf8ef" "#ffffff" "white"        ))  ;; bg1 (lightest)
   (base1      '("#efeae9" "#e4e4e4" "brightwhite"  ))  ;; bg2
   (base2      '("#e3dedd" "#d0d0d0" "brightwhite"  ))  ;; bg3
   (base3      '("#d2ceda" "#bcbcbc" "brightwhite"  ))  ;; bg4
   (base4      '("#b3b9be" "#b3b9be" "brightblack"  ))  ;; border
   (base5      '("#a094a2" "#afafd7" "brightblack"  ))  ;; base-dim
   (base6      '("#8c799f" "#5f5f87" "brightblack"  ))  ;; ttip
   (base7      '("#655370" "#5f5f87" "brightblack"  ))  ;; main fg (base)
   (base8      '("#100a14" "#121212" "black"        ))  ;; bg3 dark
   (fg-alt     '("#a094a2" "#afafd7" "brightblack"  ))  ;; base-dim
   (fg         '("#655370" "#5f5f87" "black"        ))  ;; base

   (grey       base5)

   ;; Spacemacs light accent colors
   (red        '("#f2241f" "#d70008" "red"          ))
   (orange     '("#dc752f" "#dc752f" "brightred"    ))  ;; war
   (green      '("#67b11d" "#5faf00" "green"        ))
   (teal       '("#2d9574" "#2aa198" "brightgreen"  ))  ;; str / aqua
   (yellow     '("#b1951d" "#875f00" "yellow"       ))
   (blue       '("#3a81c3" "#268bd2" "brightblue"   ))  ;; keyword / head1
   (dark-blue  '("#edf1ed" "#d7d7ff" "blue"         ))  ;; blue-bg
   (magenta    '("#a31db1" "#800080" "magenta"      ))
   (violet     '("#715ab1" "#af5fd7" "brightmagenta"))  ;; var
   (cyan       '("#21b8c7" "#008080" "brightcyan"   ))
   (dark-cyan  '("#20786b" "#2aa198" "cyan"         ))  ;; aqua (darkened teal)

   ;; Extended Spacemacs light palette
   (act1          '("#e7e5eb"))
   (act2          '("#d3d3e7"))
   (comp          '("#6c4173"))
   (const         '("#4e3163"))
   (func-color    '("#6c3163"))
   (head1         '("#3a81c3"))
   (head1-bg      '("#edf1ed"))
   (head2         '("#2d9574"))
   (head2-bg      '("#edf2e9"))
   (head3         '("#67b11d"))
   (head3-bg      '("#edf2e9"))
   (head4         '("#b1951d"))
   (head4-bg      '("#f6f1e1"))
   (highlight-dim '("#e7e7fc"))
   (lnum          '("#a8a8bf"))
   (mat           '("#ba2f59"))
   (meta          '("#da8b55"))
   (suc           '("#42ae2c"))
   (type-color    '("#ba2f59"))
   (err           '("#e0211d"))
   (war           '("#dc752f"))
   (str           '("#2d9574"))
   (ttip          '("#8c799f"))
   (ttip-bg       '("#e2e0ea"))
   (ttip-sl       '("#c8c6dd"))
   (border        '("#b3b9be"))
   (cblk          '("#655370"))
   (cblk-bg       '("#e8e3f0"))
   (cblk-ln       '("#9380b2"))
   (cblk-ln-bg    '("#ddd8eb"))
   (comment       '("#2aa1ae"))
   (comment-light '("#a49da5"))
   (comment-bg    '("#ecf3ec"))
   (aqua          '("#2d9574"))
   (aqua-bg       '("#edf2e9"))
   (green-bg      '("#edf2e9"))
   (green-bg-s    '("#dae6d0"))
   (red-bg        '("#faede4"))
   (red-bg-s      '("#eed9d2"))
   (blue-bg       '("#edf1ed"))
   (blue-bg-s     '("#d1dcdf"))
   (yellow-bg     '("#f6f1e1"))

   ;; face categories -- required for all themes
   ;; Every face-category must resolve to a unique color.
   (highlight      '("#d3d3e7" "#d7d7ff" "brightwhite" ))
   (vertical-bar   border)
   (selection      '("#d3d3e7" "#d7d7ff" "brightwhite" ))
   (builtin        comp)                                   ;; #6c4173 — spacemacs comp purple
   (comments       (if prashant-spacemacs-light-brighter-comments comment comment-light))
   (doc-comments   meta)
   (constants      const)                                  ;; #4e3163
   (functions      func-color)                             ;; #6c3163
   (keywords       blue)                                   ;; #3a81c3
   (methods        teal)                                   ;; #2d9574
   (operators      orange)                                 ;; #dc752f
   (type           type-color)                             ;; #ba2f59
   (strings        (doom-darken str 0.12))                 ;; darkened #2d9574, distinct from teal
   (variables      violet)                                 ;; #715ab1
   (numbers        magenta)                                ;; #a31db1
   (region         highlight)
   (error          err)
   (warning        war)
   (success        suc)
   (vc-modified    '("#4a6fa5" "#5f87af" "blue"))          ;; shifted blue, distinct from keyword
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "white" "white"))
   (-modeline-bright prashant-spacemacs-light-brighter-modeline)
   (-modeline-pad
    (when prashant-spacemacs-light-padded-modeline
      (if (integerp prashant-spacemacs-light-padded-modeline)
          prashant-spacemacs-light-padded-modeline
        4)))

   (modeline-fg     fg)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        (doom-lighten blue 0.4)
      act1))
   (modeline-bg-l
    (if -modeline-bright
        (doom-lighten blue 0.45)
      `(,(doom-lighten (car act1) 0.05) ,@(cdr base0))))
   (modeline-bg-inactive   `(,(car bg) ,@(cdr base0)))
   (modeline-bg-inactive-l `(,(doom-lighten (car bg) 0.02) ,@(cdr bg-alt))))


  ;; --- Extra Faces ------------------------
  (
   ;; Basic faces
   (cursor :background "#100a14")
   (hl-line :background base1 :extend t)
   (solaire-hl-line-face :inherit 'hl-line :background base0 :extend t)
   (highlight :background highlight :foreground fg)
   (lazy-highlight :background green-bg-s)
   (isearch :foreground bg :background mat)
   (match :background highlight :foreground mat)

   ((line-number &override) :foreground lnum :background base1)
   ((line-number-current-line &override) :foreground fg :background base1)
   (vertical-border :foreground border)
   (fringe :background bg :foreground fg)
   (shadow :foreground base5)

   ;; Font lock — Prashant's signature overrides
   ((font-lock-comment-face &override) :foreground comments :slant 'italic
    :background (if prashant-spacemacs-light-comment-bg comment-bg 'unspecified))
   ((font-lock-comment-delimiter-face &override) :foreground comments :italic t)
   ((font-lock-doc-face &override) :inherit 'font-lock-comment-face :foreground doc-comments)
   ((font-lock-constant-face &override) :foreground constants :weight 'semi-bold)
   ((font-lock-keyword-face &override) :foreground keywords :weight 'bold :slant 'italic)
   ((font-lock-number-face &override) :foreground numbers :weight 'bold)
   ((font-lock-function-name-face &override) :foreground functions :weight 'medium)
   ((font-lock-type-face &override) :foreground type :weight 'medium)
   ((font-lock-builtin-face &override) :foreground builtin :weight 'bold)
   ((font-lock-warning-face &override) :foreground warning :background bg)
   ((font-lock-variable-use-face &override) :foreground (doom-darken violet 0.15))
   ((font-lock-negation-char-face &override) :foreground const)
   ((font-lock-preprocessor-face &override) :foreground func-color)
   ((font-lock-string-face &override) :foreground str)
   ((font-lock-variable-name-face &override) :foreground violet)

   ;;; Doom Dashboard
   (doom-dashboard-banner :foreground comments :slant 'normal)
   (doom-dashboard-loaded :foreground comments :slant 'normal)
   (doom-dashboard-menu-title :foreground keywords :weight 'semi-bold :slant 'normal)

   ;;; Mode-line
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box `(:color ,border :line-width 1))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg
    :box `(:color ,border :line-width 1))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))
   (mode-line-buffer-id :foreground func-color :inherit 'bold)
   (mode-line-highlight :foreground highlight)

   ;;; Doom Modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg blue))
   (doom-modeline-buffer-file :foreground comp :weight 'bold)
   (doom-modeline-buffer-path :foreground blue :weight 'bold)
   (doom-modeline-buffer-major-mode :foreground teal :bold t)
   (doom-modeline-buffer-modified :foreground war :bold t)
   (doom-modeline-project-dir :foreground green :weight 'bold)

   ;;; Indentation
   (whitespace-indentation :background bg)
   (whitespace-tab :background bg)

   ;;; Ivy
   (ivy-current-match :background highlight :inherit 'bold :extend t)
   (ivy-minibuffer-match-face-1 :inherit 'bold)
   (ivy-minibuffer-match-face-2 :foreground head1 :underline t)
   (ivy-minibuffer-match-face-3 :foreground head4 :underline t)
   (ivy-minibuffer-match-face-4 :foreground head3 :underline t)
   (ivy-remote :foreground cyan)
   (ivy-posframe :background base2)

   ;;; Vertico
   (vertico-current :background highlight :foreground fg :bold t)
   (vertico-group-title :background head1-bg :foreground head1 :bold t)
   (vertico-group-separator :background head1-bg :foreground head1 :strike-through t)
   (vertico-posframe-border :background border)
   (vertico-posframe :background base2)

   ;;; Company
   (company-tooltip :background ttip-bg :foreground ttip)
   (company-tooltip-common :background ttip-bg :foreground blue)
   (company-tooltip-search :inherit 'match)
   (company-tooltip-selection :background ttip-sl :foreground fg)
   (company-tooltip-annotation :foreground type-color)
   (company-scrollbar-bg :background base1)
   (company-scrollbar-fg :background act2)

   ;;; Corfu
   (corfu-default :background ttip-bg :foreground ttip)
   (corfu-current :background ttip-sl :foreground fg)
   (corfu-annotations :foreground violet)

   ;;; Elscreen
   (elscreen-tab-other-screen-face :background base2 :foreground base5)

   ;;; Solaire
   (solaire-default-face :inherit 'default :background base1)
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;;; Telephone
   (telephone-line-accent-active
    :inherit 'mode-line
    :background (doom-darken bg 0.1))
   (telephone-line-accent-inactive
    :inherit 'mode-line
    :background (doom-darken bg 0.05))
   (telephone-line-evil-emacs
    :inherit 'mode-line
    :background dark-blue)

   ;;;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground blue)
   (rainbow-delimiters-depth-2-face :foreground func-color)
   (rainbow-delimiters-depth-3-face :foreground teal)
   (rainbow-delimiters-depth-4-face :foreground green)
   (rainbow-delimiters-depth-5-face :foreground yellow)
   (rainbow-delimiters-depth-6-face :foreground blue)
   (rainbow-delimiters-depth-7-face :foreground func-color)
   (rainbow-delimiters-mismatched-face :foreground err :overline t)
   (rainbow-delimiters-unmatched-face :foreground err :overline t)

   ;;; Treemacs
   (treemacs-root-face :foreground func-color :weight 'bold :height 1.2)
   (doom-themes-treemacs-root-face :foreground func-color :weight 'ultra-bold :height 1.2)
   (doom-themes-treemacs-file-face :foreground fg-alt)
   (treemacs-directory-face :foreground blue :weight 'semi-bold)
   (treemacs-file-face :foreground fg)
   (treemacs-git-modified-face :foreground blue)
   (treemacs-git-renamed-face :foreground yellow)
   (treemacs-git-added-face :foreground green)
   (treemacs-git-conflict-face :foreground red)
   (treemacs-git-ignored-face :foreground yellow)
   (treemacs-git-untracked-face :foreground dark-cyan)

   ;;; Magit
   (magit-section-heading :foreground blue :weight 'bold)
   (magit-section-highlight :background base1 :extend t)
   (magit-branch-current :background blue-bg :foreground blue :inherit 'bold :box t)
   (magit-branch-local :background blue-bg :foreground blue :inherit 'bold)
   (magit-branch-remote :background aqua-bg :foreground dark-cyan :inherit 'bold)
   (magit-diff-context-highlight :background base1 :foreground fg :extend t)
   (magit-diff-hunk-heading :background ttip-bg :foreground ttip :extend t)
   (magit-diff-hunk-heading-highlight :background ttip-sl :foreground fg :extend t :weight 'bold)
   (magit-diff-our :foreground (doom-darken red 0.1) :background red-bg)
   (magit-diff-our-highlight :foreground red :background red-bg-s :weight 'bold)
   (magit-diff-removed :foreground (doom-darken red 0.1) :background red-bg :extend t)
   (magit-diff-removed-highlight :foreground red :background red-bg-s :weight 'bold :extend t)
   (magit-hash :foreground violet)
   (magit-log-author :foreground func-color)
   (magit-process-ng :foreground war :inherit 'bold)
   (magit-process-ok :foreground func-color :inherit 'bold)

   ;;; Ediff
   (ediff-current-diff-A :background red-bg :foreground red :extend t)
   (ediff-current-diff-B :background green-bg :foreground green :extend t)
   (ediff-current-diff-C :background blue-bg :foreground blue :extend t)
   (ediff-fine-diff-A :background red :foreground bg :extend t)
   (ediff-fine-diff-B :background green :foreground bg)
   (ediff-fine-diff-C :background blue :foreground bg)

   ;;; Flycheck
   (flycheck-error (:underline `(:style wave :color ,err)))
   (flycheck-warning (:underline `(:style wave :color ,war)))
   (flycheck-info (:underline `(:style wave :color ,blue)))
   (flycheck-fringe-error :foreground err :inherit 'bold)
   (flycheck-fringe-warning :foreground war :inherit 'bold)
   (flycheck-fringe-info :foreground blue :inherit 'bold)

   ;;; Git-gutter
   (git-gutter:added :foreground green :background bg)
   (git-gutter:modified :foreground blue :background bg)
   (git-gutter:deleted :foreground red :background bg)

   ;;; Diff-hl
   (diff-hl-insert :foreground green :background green)
   (diff-hl-delete :foreground red :background red)
   (diff-hl-change :foreground blue :background blue)

   ;;; LSP
   (lsp-face-highlight-read :background yellow-bg)
   (lsp-face-highlight-write :background green-bg-s)
   (lsp-face-highlight-textual :background green-bg)
   (lsp-ui-doc-background :background base1)
   (lsp-ui-doc-header :foreground head1 :background head1-bg :bold t)
   (lsp-ui-sideline-code-action :foreground comp)
   (lsp-ui-sideline-current-symbol :foreground blue)
   (lsp-ui-sideline-symbol :foreground dark-cyan)

   ;;; Show-paren
   (show-paren-match :foreground mat :inherit 'bold :underline t)
   (show-paren-match-expression :background green-bg-s)
   (show-paren-mismatch :foreground err :inherit 'bold :underline t)

   ;; --- Major-Mode Faces -------------------

   ;;; elisp
   (highlight-quoted-symbol :foreground yellow)

   ;;; js2-mode
   (js2-function-param :foreground const)
   (js2-object-property :foreground violet)
   (js2-external-variable :foreground comp)

   ;;; typescript-mode
   (typescript-this-face :foreground type-color)
   (typescript-access-modifier-face :foreground blue)

   ;;; rjsx-mode
   (rjsx-tag :foreground blue)
   (rjsx-text :foreground str)
   (rjsx-attr :foreground func-color :slant 'italic :weight 'medium)
   (rjsx-tag-bracket-face :foreground (doom-darken blue 0.2))

   ;;; css-mode / scss-mode
   (css-property             :foreground blue)
   (css-selector             :foreground teal)
   (css-pseudo-class         :foreground type-color)

   ;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground head1)
   (markdown-header-face-1 :foreground head1 :height 1.3 :bold t)
   (markdown-header-face-2 :foreground head2 :height 1.2 :bold t)
   (markdown-header-face-3 :foreground head3 :height 1.1)
   (markdown-header-face-4 :foreground head4)
   (markdown-header-face-5 :foreground head1)
   (markdown-header-face-6 :foreground head2)
   (markdown-blockquote-face :foreground violet :background (doom-darken bg 0.03))
   (markdown-table-face :foreground fg :background head1-bg)
   ((markdown-code-face &override) :foreground cblk :background cblk-bg)

   ;;; org-mode
   (org-hide :foreground hidden)
   (org-block :background cblk-bg :foreground cblk :extend t)
   (org-block-begin-line :background cblk-ln-bg :foreground cblk-ln :extend t)
   (org-block-end-line :background cblk-ln-bg :foreground cblk-ln :extend t)
   (org-code :foreground cyan)
   (org-date :underline t :foreground violet)
   (org-document-info-keyword :foreground meta)
   (org-document-title :foreground func-color :inherit 'bold :height 1.4 :underline t)
   (org-done :foreground suc :inherit 'bold :background green-bg)
   (org-ellipsis :foreground blue)
   (org-footnote :underline t :foreground fg)
   (org-headline-done :foreground dark-cyan)
   (org-level-1 :foreground head1 :bold t)
   (org-level-2 :foreground head2 :bold t)
   (org-level-3 :foreground head3)
   (org-level-4 :foreground head4)
   (org-level-5 :foreground head1)
   (org-level-6 :foreground head2)
   (org-level-7 :foreground head3)
   (org-level-8 :foreground head4)
   (org-link :foreground blue :underline t)
   (org-meta-line :foreground meta)
   (org-priority :foreground war :inherit 'bold)
   (org-quote :inherit 'org-block :slant 'italic)
   (org-special-keyword :foreground func-color)
   (org-table :foreground fg :background head1-bg)
   (org-tag :foreground meta)
   (org-todo :foreground war :inherit 'bold :background yellow-bg)
   (org-verbatim :foreground blue)
   (solaire-org-hide-face :foreground hidden)

   ;;; web-mode
   (web-mode-html-tag-face :foreground blue)
   (web-mode-html-tag-bracket-face :foreground (doom-darken blue 0.2))
   (web-mode-html-attr-name-face :foreground func-color)
   (web-mode-html-attr-value-face :foreground blue)
   (web-mode-html-attr-equal-face :foreground type-color)
   (web-mode-builtin-face :inherit 'font-lock-builtin-face)
   (web-mode-keyword-face :inherit 'font-lock-keyword-face)
   (web-mode-constant-face :foreground constants)
   (web-mode-variable-name-face :foreground violet)
   (web-mode-string-face :foreground str)
   (web-mode-type-face :inherit 'font-lock-type-face)
   (web-mode-json-context-face :foreground yellow)
   (web-mode-json-key-face :foreground teal)
   ;;;; CSS
   (web-mode-css-pseudo-class-face :foreground type-color)
   (web-mode-css-property-name-face :foreground blue)
   (web-mode-css-selector-face :foreground teal)
   (web-mode-css-selector-class-face :foreground blue :slant 'normal)
   (web-mode-css-selector-tag-face :inherit 'web-mode-css-selector-class-face)
   (web-mode-css-function-face :foreground yellow)

   ;;; which-key
   (which-key-command-description-face :foreground fg)
   (which-key-group-description-face :foreground blue)
   (which-key-key-face :foreground func-color :inherit 'bold)
   (which-key-separator-face :foreground teal)
   (which-key-special-key-face :background func-color :foreground bg))


  ;; --- extra variables ---------------------
  ())

;;; prashant-spacemacs-light-theme.el ends here
