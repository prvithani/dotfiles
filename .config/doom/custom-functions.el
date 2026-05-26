;;; $DOOMDIR/custom-functions.el -*- lexical-binding: t; -*-

;; ----- Paste with indent -----
(evil-define-command evil-paste-before-and-indent
  (count &optional register yank-handler)
  "Pastes the latest yanked text before point
and gives it the same indentation as the surrounding code.
The return value is the yanked text."
  (interactive "P<x>")
  (evil-with-single-undo
    (let ((text (evil-paste-before count register yank-handler)))
      (evil-indent (evil-get-marker ?\[) (evil-get-marker ?\]))
      text)))

(evil-define-command evil-paste-after-and-indent
  (count &optional register yank-handler)
  "Pastes the latest yanked text behind point
and gives it the same indentation as the surrounding code.
The return value is the yanked text."
  (interactive "P<x>")
  (evil-with-single-undo
    (let ((text (evil-paste-after count register yank-handler)))
      (evil-indent (evil-get-marker ?\[) (evil-get-marker ?\]))
      text)))

;; ----- Treemacs (temporary fix for 6c431174dd933f87c32f283740ad2078e1c4fcb8) -----
(defun fix-treemacs ()
  (interactive)
  (setf treemacs--file-name-handler-alist
        (with-no-warnings
          (list
           (cons tramp-file-name-regexp #'tramp-file-name-handler)))))

;; ----- HideShow functions -----
;; not used
(defun +data-hideshow-forward-sexp (arg)
  (let ((start (current-indentation)))
    (forward-line)
    (unless (= start (current-indentation))
      (require 'evil-indent-plus)
      (let ((range (evil-indent-plus--same-indent-range)))
        (goto-char (cadr range))
        (end-of-line)))))

;; ----- ORG Functions -----
(defun +org*update-cookies ()
  (when (and buffer-file-name (file-exists-p buffer-file-name))
    (let (org-hierarchical-todo-statistics)
      (org-update-parent-todo-statistics))))

;; ----- Custom User functions -----
(defun user/fill-column-indicator-hooks ()
  (add-hook 'prog-mode-hook (lambda () (display-fill-column-indicator-mode t))))

(defmacro user/disable-flycheck-eglot-exclusive (modes)
  `(add-hook! ,modes (setq-local flycheck-eglot-exclusive nil)))

(defun user/dictionary ()
  "All settings related to dictionary"
  ;;;; Dictionary
  (require 'dictionary)

  ;; Customize
  (setq dictionary-default-dictionary "wn")

  ;; key bindings - history go back
  (evil-define-key 'motion dictionary-mode-map
    (kbd "C-o") 'dictionary-previous)

  ;; Invoke
  ;; (spacemacs/set-leader-keys "xwf" 'dictionary-lookup-definition)
  ;; (spacemacs/set-leader-keys "xwD" 'dictionary-search)

  ;; Font face -- make dictionary beautiful
  (set-face-font 'dictionary-word-definition-face "Cascadia Code")
  (set-face-attribute 'dictionary-button-face nil :foreground "magenta")
  (set-face-attribute 'dictionary-reference-face nil :foreground "cyan")
  (set-face-attribute 'dictionary-word-entry-face nil :foreground "yellow")
  )

(defun font-size-thinkpad ()
  (interactive)
  (doom-adjust-font-size 13 t))

(defun font-size-125-hidpi ()
  (interactive)
  (doom-adjust-font-size 15 t))

(defun font-size-150-hidpi ()
  (interactive)
  (doom-adjust-font-size 17 t))

(dolist (fn '(definition references))
  (fset (intern (format "+lookup/%s-other-window" fn))
        (lambda (identifier &optional arg)
          "TODO"
          (interactive (list (doom-thing-at-point-or-region)
                             current-prefix-arg))
          (let ((pt (point)))
            (switch-to-buffer-other-window (current-buffer))
            (goto-char pt)
            (funcall (intern (format "+lookup/%s" fn)) identifier arg)))))

