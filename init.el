;; emacs-serverの起動
(server-start)

;; load-pathに追加
(setq load-path (cons "~/.emacs.d" load-path))
(setq load-path (cons "~/.emacs.d/elisp" load-path))
(show-paren-mode t)

;*.c~\のようなファイルを作らない;;;;;;;;;;;
;(setq make-backup-files nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; クリップボードをPCと同期;;;;;;;;;;;;;;;;;
(setq x-select-enable-clipboard t)
(global-set-key "\C-y" 'x-clipboard-yank)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Display, Font Setting;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ツールバーを非表示;;;;;;;;;;;;;;;;;;;;;;;
(tool-bar-mode -1)
(scroll-bar-mode -1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 初期画面を非表示;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; savehist;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq savehist-file "~/.emacs.d/cache/savehist/history")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Color Setting;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-faces
  '(default ((t
               (:background "black" :foreground "white")
               )))
  '(cursor ((((class color)
              (background dark))
             (:background "white"))
            ;                  (:background "#00AA00"))
            (((class color)
              (background light))
             (:background "#999999"))
            (t ())
            )))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'wombat t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; transparency;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;透過については~/.Xresourcesに記載
;xrdb ~/.Xresources
;; フレームの透明度
;(set-frame-parameter (selected-frame) 'alpha '(85 50))
;(add-to-list 'default-frame-alist '(alpha 85 50))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;文字設定;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ricty fontの使用
(set-default-font "ricty-12.5")
(set-face-font 'variable-pitch "ricty-12.5")
(add-to-list 'default-frame-alist '(font . "ricty-12.5"))

;; 全角スペース
(setq whitespace-style
      '(tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        ;(tab-mark   ?\t   [?\xBB ?\t])
        ))
(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "LightSlateGray")
(set-face-background 'whitespace-space "DarkSlateGray")
(set-face-foreground 'whitespace-tab "LightSlateGray")
(set-face-background 'whitespace-tab "DarkSlateGray")


;; Tab Setting
(setq tab-width 4)
(setq indent-tabs-mode nil)
(setq-default c-basic-offset 4     ;;基本インデント量4
              tab-width 4          ;;タブ幅4
              indent-tabs-mode nil)  ;;インデントをタブでするかスペースでするか
;;タブは2文字ごとに
;;;;追加　タブの設定は以下のようにしないとだめ
(setq-default tab-stop-list
              '(0 1 2 3 4 6 8 12 16 20))
(setq indent-tabs-mode 4)


;; mozcの使用
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
(global-set-key [zenkaku-hankaku] 'mozc-mode)


;; デフォルトの文字コードと改行コード
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;auto-install, auto-completeの設定;;;;;;;;;;;
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
;(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

(require 'auto-complete)
(global-auto-complete-mode t)
;; 辞書保存
(setq ac-comphist-file "~/.emacs.d/elisp/auto-complete-dics/auto-dics")
(setq ac-dictionary-directories "~/.emacs.d/elisp/auto-complete-dics/")
(add-to-list 'ac-modes 'text-mode)      ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'verilog-mode)      ;; verilog-modeでも自動的に有効にする
(add-to-list 'ac-modes 'd-mode)      ;; d-modeでも自動的に有効にする
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; anything;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)

(global-set-key (kbd "C-x C-g") 'anything)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; muti-term;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'multi-term)
(setq multi-term-program shell-file-name)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; direx;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'direx)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; gtags;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNU GLOBAL(gtags)
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))

(add-hook 'c-mode-common-hook
          '(lambda()
             (gtags-mode 1)
             (gtags-make-complete-list)
             ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Mode Setting;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Yatex mode
; エンコーディングをutf-8にする。＠yatex
(setq YaTeX-kanji-code 4)
(setq YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)
(setq tex-command "platex")
(setq bibtex-command "bibtex")
(setq YaTeX-dvipdf-command "dvipdfmx")
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq load-path (cons (expand-file-name "/usr/local/share/emacs/site-lisp/yatex") load-path))
(setq dvi2-command "open")
(setq dvi2-command "evince")
(setq YaTeX-typeset-auto-rerun nil)
;自動改行無効化
(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))
; C-c tj でpdfまで作成。platex2pdfにスクリプトが入ってる。＠yatex
(setq tex-command "sh ~/.emacs.d/dvipdfmx_output")


;; csv-mode
;;; 20081206 csv-mode.el
;;; http://d.hatena.ne.jp/amt/20081206/CsvMode4Emacs
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
          "Major mode for editing comma-separated value files." t)

;; haskell-mode
(add-to-list 'load-path "~/.emacs.d/haskell-mode-2.8.0")
(require 'haskell-mode)
(require 'haskell-cabal)
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))

;; D-mode
(autoload 'd-mode "d-mode" "Major mode for editing D code." t)
(add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode))

;; doxymacs-mode
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
    (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

(defun my-javadoc-return ()
  "Advanced C-m for Javadoc multiline comments.
  Inserts `*' at the beggining of the new line if
  unless return was pressed outside the comment"
  (interactive)
  (setq last (point))
  (setq is-inside
        (if (search-backward "*/" nil t)
          ;; there are some comment endings - search forward
          (if (search-forward "/*" last t)
            't
            'nil)
          ;; it's the only comment - search backward
          (goto-char last)
          (if (search-backward "/*" nil t)
            't
            'nil
            )
          )
        )
  ;; go to last char position
  (goto-char last)
  ;; the point is inside some comment, insert `*'
  (if is-inside
    (progn
      (insert "\n*")
      (indent-for-tab-command))
    ;; else insert only new-line
    (insert "\n")))
(add-hook 'c++-mode-hook (lambda ()
                           (local-set-key "\r" 'my-javadoc-return)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;コメントアウト用コマンド;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'c++-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'c-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'scheme-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'python-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'java-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'yatex-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))

(define-key global-map (kbd "C-;") 'hs-toggle-hiding)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; globalなC-zを無効化;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-unset-key "\C-z")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; スペルチェッカとしてaspellを指定;;;;;;;;;;;;;;
(setq-default ispell-program-name "aspell")
; 日本語混じりのTeX文書でスペルチェック
(eval-after-load "ispell"
                 '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
; YaTeX起動時に，flyspell-modeも起動する
(add-hook 'yatex-mode-hook 'flyspell-mode)
(custom-set-variables
  '(flyspell-auto-correct-binding [(control ?\:)]))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Control Original Function;;;;;;;;;;;;;;;;;;;;;;;

;; Window サイズ変更用関数
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
           (while t
                  (message "size[%dx%d]"
                           (window-width) (window-height))
                  (setq c (read-char))
                  (cond ((= c ?l)
                         (enlarge-window-horizontally dx))
                        ((= c ?h)
                         (shrink-window-horizontally dx))
                        ((= c ?j)
                         (enlarge-window dy))
                        ((= c ?k)
                         (shrink-window dy))
                        ;; otherwise
                        (t
                          (message "Quit")
                          (throw 'end-flag t)))))))

(global-set-key "\C-cr" 'window-resizer)

; Window 移動
(define-key global-map "\C-q" (make-sparse-keymap))

;; quoted-insert は C-q C-q へ割り当て
(global-set-key "\C-q\C-q" 'quoted-insert)

;; Window移動
(global-set-key "\C-ql" 'windmove-right)
(global-set-key "\C-qh" 'windmove-left)
(global-set-key "\C-qj" 'windmove-down)

;;^M+kによる一行コピー
;;^M+Kによる一行カット
(defun copy-whole-line (&optional arg)
  "Copy current line."
  (interactive "p")
  (or arg (setq arg 1))
  (if (and (> arg 0) (eobp) (save-excursion (forward-visible-line 0) (eobp)))
      (signal 'end-of-buffer nil))
  (if (and (< arg 0) (bobp) (save-excursion (end-of-visible-line) (bobp)))
      (signal 'beginning-of-buffer nil))
  (unless (eq last-command 'copy-region-as-kill)
    (kill-new "")
    (setq last-command 'copy-region-as-kill))
  (cond ((zerop arg)
         (save-excursion
           (copy-region-as-kill (point) (progn (forward-visible-line 0) (point)))
           (copy-region-as-kill (point) (progn (end-of-visible-line) (point)))))
        ((< arg 0)
         (save-excursion
           (copy-region-as-kill (point) (progn (end-of-visible-line) (point)))
           (copy-region-as-kill (point)
                                (progn (forward-visible-line (1+ arg))
                                       (unless (bobp) (backward-char))
                                       (point)))))
        (t
         (save-excursion
           (copy-region-as-kill (point) (progn (forward-visible-line 0) (point)))
           (copy-region-as-kill (point)
                                (progn (forward-visible-line arg) (point))))))
  (message (substring (car kill-ring-yank-pointer) 0 -1)))

(global-set-key (kbd "M-k") 'copy-whole-line)
(global-set-key (kbd "M-K") 'kill-whole-line)


(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-user-dictionary nil)
(setq migemo-coding-system 'utf-8)
(setq migemo-regex-dictionary nil)
(load-library "migemo")
(migemo-init)

