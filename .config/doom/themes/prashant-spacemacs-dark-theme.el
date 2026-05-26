;;; prashant-spacemacs-dark-theme.el --- Spacemacs Dark ported to Doom -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: April 1, 2026
;; Author: Prashant Vithani (port), Nasser Alshammari (original Spacemacs theme)
;; Maintainer:
;; Source: https://github.com/syl20bnr/spacemacs (spacemacs-theme)
;;
;;; Commentary:
;;
;; A faithful port of the Spacemacs Dark theme into the Doom Emacs theme
;; framework, with Prashant's personal customization pattern applied
;; (font-weight overrides, italic keywords, bold numbers, etc.).
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup prashant-spacemacs-dark-theme nil
  "Options for the `prashant-spacemacs-dark' theme."
  :group 'doom-themes)

(defcustom prashant-spacemacs-dark-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'prashant-spacemacs-dark-theme
  :type 'boolean)

(defcustom prashant-spacemacs-dark-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'prashant-spacemacs-dark-theme
  :type 'boolean)

(defcustom prashant-spacemacs-dark-comment-bg prashant-spacemacs-dark-brighter-comments
  "If non-nil, comments will have a subtle, darker background.
Enhancing their legibility."
  :group 'prashant-spacemacs-dark-theme
  :type 'boolean)

(defcustom prashant-spacemacs-dark-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'prashant-spacemacs-dark-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme prashant-spacemacs-dark
    "A dark theme based on Spacemacs Dark, ported to the Doom framework."

  ;; name        default   256       16
  ;;
  ;; The Spacemacs dark palette, mapped into Doom's base0-base8 ramp.
  ;; bg1 (#292b2e) is the main background.
  ;; base (#b2b2b2) is the main foreground text.
  ((bg         '("#292b2e" "#262626" "black"        ))
   (bg-alt     '("#212026" "#1c1c1c" "black"        ))
   (base0      '("#0a0814" "#080808" "black"        ))  ;; bg4 – deepest dark
   (base1      '("#100a14" "#121212" "brightblack"  ))  ;; bg3
   (base2      '("#212026" "#1c1c1c" "brightblack"  ))  ;; bg2
   (base3      '("#292b2e" "#262626" "brightblack"  ))  ;; bg1 (same as bg)
   (base4      '("#42444a" "#353535" "brightblack"  ))  ;; bg-alt (spacemacs)
   (base5      '("#686868" "#585858" "brightblack"  ))  ;; base-dim
   (base6      '("#727272" "#6c6c6c" "brightblack"  ))
   (base7      '("#9a9aba" "#888888" "brightblack"  ))  ;; ttip
   (base8      '("#b2b2b2" "#b2b2b2" "white"        ))  ;; base (spacemacs fg)
   (fg-alt     '("#686868" "#585858" "white"        ))  ;; base-dim
   (fg         '("#b2b2b2" "#b2b2b2" "white"        ))  ;; base

   (grey       base5)

   ;; Spacemacs dark accent colors
   (red        '("#f2241f" "#d70000" "red"          ))
   (orange     '("#dc752f" "#dc752f" "brightred"    ))  ;; war
   (green      '("#67b11d" "#67b11d" "green"        ))
   (teal       '("#2d9574" "#2aa198" "brightgreen"  ))  ;; str / aqua
   (yellow     '("#b1951d" "#875f00" "yellow"       ))
   (blue       '("#4f97d7" "#268bd2" "brightblue"   ))  ;; keyword / head1
   (dark-blue  '("#293239" "#262626" "blue"         ))  ;; blue-bg
   (magenta    '("#a31db1" "#af00df" "magenta"      ))
   (violet     '("#7590db" "#8787d7" "brightmagenta"))  ;; var
   (cyan       '("#28def0" "#00ffff" "brightcyan"   ))
   (dark-cyan  '("#20786b" "#2aa198" "cyan"         ))  ;; aqua (darkened teal)

   ;; Extended Spacemacs palette
   (act1          '("#222226"))
   (act2          '("#5d4d7a"))
   (comp          '("#c56ec3"))
   (const         '("#a45bad"))
   (func-color    '("#bc6ec5"))
   (head1         '("#4f97d7"))
   (head1-bg      '("#293239"))
   (head2         '("#2d9574"))
   (head2-bg      '("#293235"))
   (head3         '("#67b11d"))
   (head3-bg      '("#293235"))
   (head4         '("#b1951d"))
   (head4-bg      '("#32322c"))
   (highlight-dim '("#3b314d"))
   (lnum          '("#44505c"))
   (mat           '("#86dc2f"))
   (meta          '("#9f8766"))
   (suc           '("#86dc2f"))
   (type-color    '("#ce537a"))
   (err           '("#e0211d"))
   (war           '("#dc752f"))
   (str           '("#2d9574"))
   (ttip          '("#9a9aba"))
   (ttip-bg       '("#34323e"))
   (ttip-sl       '("#5e5079"))
   (border        '("#5d4d7a"))
   (cblk          '("#cbc1d5"))
   (cblk-bg       '("#2f2b33"))
   (cblk-ln       '("#827591"))
   (cblk-ln-bg    '("#373040"))
   (comment       '("#2aa1ae"))
   (comment-bg    '("#292e34"))
   (aqua          '("#2d9574"))
   (aqua-bg       '("#293235"))
   (green-bg      '("#293235"))
   (green-bg-s    '("#29422d"))
   (red-bg        '("#3c2a2c"))
   (red-bg-s      '("#512e31"))
   (blue-bg       '("#293239"))
   (blue-bg-s     '("#2d4252"))
   (yellow-bg     '("#32322c"))

   ;; face categories -- required for all themes
   ;; Every face-category must resolve to a unique color.
   (highlight      '("#ABC155" "#ABC444" "brightblack" ))
   (vertical-bar   border)
   (selection      '("#444155" "#444444" "brightblack" ))
   (builtin        comp)                                   ;; #c56ec3 — spacemacs comp purple
   (comments       (if prashant-spacemacs-dark-brighter-comments (doom-lighten comment 0.25) comment))
   (doc-comments   meta)
   (constants      const)                                  ;; #a45bad
   (functions      func-color)                             ;; #bc6ec5
   (keywords       blue)                                   ;; #4f97d7
   (methods        teal)                                   ;; #2d9574
   (operators      orange)                                 ;; #dc752f
   (type           type-color)                             ;; #ce537a
   (strings        (doom-lighten str 0.15))               ;; lightened #2d9574, distinct from teal
   (variables      violet)                                 ;; #7590db
   (numbers        magenta)                                ;; #a31db1
   (region         selection)
   (error          err)
   (warning        war)
   (success        suc)
   (vc-modified    '("#6b8ec2" "#5f87af" "blue"))          ;; shifted blue, distinct from keyword
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright prashant-spacemacs-dark-brighter-modeline)
   (-modeline-pad
    (when prashant-spacemacs-dark-padded-modeline
      (if (integerp prashant-spacemacs-dark-padded-modeline)
          prashant-spacemacs-dark-padded-modeline
        4)))

   (modeline-fg     fg)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        (doom-darken blue 0.45)
      act1))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken blue 0.475)
      `(,(doom-darken (car act1) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   `(,(car bg) ,@(cdr base1)))
   (modeline-bg-inactive-l `(,(doom-darken (car bg) 0.05) ,@(cdr bg-alt))))


  ;; --- Extra Faces ------------------------
  (
   ;; Basic faces
   (cursor :background "#e3dedd")
   (hl-line :background base2 :extend t)
   (solaire-hl-line-face :inherit 'hl-line :background base3 :extend t)
   (highlight :background base4 :foreground highlight)
   (lazy-highlight :background (doom-lighten green-bg 0.2) :inverse-video t)
   (isearch :foreground bg :background mat)
   (match :background mat :foreground base3)

   ((line-number &override) :foreground lnum :background base2)
   ((line-number-current-line &override) :foreground base8 :background base3)
   (vertical-border :foreground border)
   (fringe :background bg :foreground base8)
   (shadow :foreground base5)

   ;; Font lock — Prashant's signature overrides
   ((font-lock-comment-face &override) :foreground comments :slant 'italic
    :background (if prashant-spacemacs-dark-comment-bg comment-bg 'unspecified))
   ((font-lock-comment-delimiter-face &override) :foreground comments :italic t)
   ((font-lock-doc-face &override) :inherit 'font-lock-comment-face :foreground doc-comments)
   ((font-lock-constant-face &override) :foreground constants :weight 'semi-bold)
   ((font-lock-keyword-face &override) :foreground keywords :weight 'bold :slant 'italic)
   ((font-lock-number-face &override) :foreground numbers :weight 'bold)
   ((font-lock-function-name-face &override) :foreground functions :weight 'medium)
   ((font-lock-type-face &override) :foreground type :weight 'medium)
   ((font-lock-builtin-face &override) :foreground builtin :weight 'bold)
   ((font-lock-warning-face &override) :foreground warning)
   ((font-lock-variable-use-face &override) :foreground (doom-lighten violet 0.3))
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
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))
   (mode-line-buffer-id :foreground func-color :inherit 'bold)
   (mode-line-highlight :foreground base2 :background highlight)

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
   (ivy-current-match :background selection :inherit 'bold :extend t)
   (ivy-minibuffer-match-face-1 :inherit 'bold)
   (ivy-minibuffer-match-face-2 :foreground head1 :underline t)
   (ivy-minibuffer-match-face-3 :foreground head4 :underline t)
   (ivy-minibuffer-match-face-4 :foreground head3 :underline t)
   (ivy-remote :foreground cyan)
   (ivy-posframe :background base1)

   ;;; Vertico
   (vertico-current :background selection :foreground base8 :bold t)
   (vertico-group-title :background head1-bg :foreground head1 :bold t)
   (vertico-group-separator :background head1-bg :foreground head1 :strike-through t)
   (vertico-posframe-border :background border)
   (vertico-posframe :background base1)

   ;;; Company
   (company-tooltip :background ttip-bg :foreground ttip)
   (company-tooltip-common :background ttip-bg :foreground blue)
   (company-tooltip-search :inherit 'match)
   (company-tooltip-selection :background ttip-sl :foreground base8)
   (company-tooltip-annotation :foreground type-color)
   (company-scrollbar-bg :background base2)
   (company-scrollbar-fg :background act2)

   ;;; Corfu
   (corfu-default :background ttip-bg :foreground ttip)
   (corfu-current :background ttip-sl :foreground base8)
   (corfu-annotations :foreground violet)

   ;;; Elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ;;; Solaire
   (solaire-default-face :inherit 'default :background bg-alt)
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
    :background (doom-lighten bg 0.2))
   (telephone-line-accent-inactive
    :inherit 'mode-line
    :background (doom-lighten bg 0.05))
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
   (magit-section-highlight :background base2 :extend t)
   (magit-branch-current :background blue-bg :foreground blue :inherit 'bold :box t)
   (magit-branch-local :background blue-bg :foreground blue :inherit 'bold)
   (magit-branch-remote :background aqua-bg :foreground dark-cyan :inherit 'bold)
   (magit-diff-context-highlight :background base2 :foreground fg :extend t)
   (magit-diff-hunk-heading :background ttip-bg :foreground ttip :extend t)
   (magit-diff-hunk-heading-highlight :background ttip-sl :foreground base8 :extend t :weight 'bold)
   (magit-diff-our :foreground (doom-darken red 0.2) :background red-bg)
   (magit-diff-our-highlight :foreground red :background red-bg-s :weight 'bold)
   (magit-diff-removed :foreground (doom-darken red 0.2) :background red-bg :extend t)
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
   ((flycheck-error &override) :underline `(:style line :color ,err))
   ((flycheck-warning &override) :underline `(:style dashes :color ,war))
   ((flycheck-info &override) :underline `(:style dots :color ,blue))
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
   (lsp-ui-doc-background :background base2)
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
   (rjsx-tag-bracket-face :foreground (doom-darken blue 0.3))

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
   (markdown-blockquote-face :foreground violet :background (doom-lighten bg 0.04))
   (markdown-table-face :foreground base8 :background head1-bg)
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
   (org-footnote :underline t :foreground base8)
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
   (org-table :foreground base8 :background head1-bg)
   (org-tag :foreground meta)
   (org-todo :foreground war :inherit 'bold :background yellow-bg)
   (org-verbatim :foreground blue)
   (solaire-org-hide-face :foreground hidden)

   ;;; web-mode
   (web-mode-html-tag-face :foreground blue)
   (web-mode-html-tag-bracket-face :foreground (doom-darken blue 0.3))
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
   (which-key-command-description-face :foreground base8)
   (which-key-group-description-face :foreground blue)
   (which-key-key-face :foreground func-color :inherit 'bold)
   (which-key-separator-face :foreground teal)
   (which-key-special-key-face :background func-color :foreground bg))


  ;; --- extra variables ---------------------
  ())

;;; prashant-spacemacs-dark-theme.el ends here
