(server-start)

(setq load-path (cons "~/.emacs.d/elisp" load-path))
(show-paren-mode t)

(setq tab-width 4)
(setq indent-tabs-mode nil)

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
;(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)



;auto-completeの設定
(require 'auto-complete)
(global-auto-complete-mode t)
;; 辞書保存
(setq ac-comphist-file "~/.emacs.d/elisp/auto-complete-dics/auto-dics")
(setq ac-dictionary-directories "~/.emacs.d/elisp/auto-complete-dics/")



;*.c~\のようなファイルを作らない
;(setq make-backup-files nil)

;文字設定

(set-default-font "ricty-12.5")
(set-face-font 'variable-pitch "ricty-12.5")
;(iset-fontset-font (frame-parameter nil 'font)
;                  'japanese-jisx0208
;                  '("Takaoゴシック" . "unicode-bmp")
;)
(add-to-list 'default-frame-alist '(font . "ricty-12.5"))

;クリップボードをPCと同期
(setq x-select-enable-clipboard t)
(global-set-key "\C-y" 'x-clipboard-yank)

;全角スペース

(setq whitespace-style
      '(tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "LightSlateGray")
(set-face-background 'whitespace-space "DarkSlateGray")
(set-face-foreground 'whitespace-tab "LightSlateGray")
(set-face-background 'whitespace-tab "DarkSlateGray")


;zshrcにて
;alias emacs='XMODIFIERS=@im=none \emacs'
;emacs23.desktopにて
;env XMODIFIERS=@im=none
;をexecに付け足す
(add-hook 'mozc-mode-hook
  (lambda()
    (define-key mozc-mode-map (kbd "<zenkaku-hankaku>") 'toggle-input-method)))

;; Coding system.
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;anything
(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)

(global-set-key (kbd "C-x C-g") 'anything)

; yatex-modeに関する設定
; エンコーディングをutf-8にする。＠yatex
(setq YaTeX-kanji-code 4)
(setq YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)
(setq tex-command "platex")
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


;初期画面いらない
(setq inhibit-startup-message t)

;; savehist
 (setq savehist-file "~/.emacs.d/cache/savehist/history")


;色設定
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

;透過については~/.Xresourcesに記載
;xrdb ~/.Xresources
;; フレームの透明度
;(set-frame-parameter (selected-frame) 'alpha '(85 50))
;(add-to-list 'default-frame-alist '(alpha 85 50))

;; Set transparency of emacs
;(defun transparency (value)
;  "Sets the transparency of the frame window. 0=transparent/100=opaque"
;  (interactive "nTransparency Value 0 - 100 opaque:")
;  (set-frame-parameter (selected-frame) 'alpha value))


(setq-default c-basic-offset 4     ;;基本インデント量4
              tab-width 4          ;;タブ幅4
              indent-tabs-mode nil)  ;;インデントをタブでするかスペースでするか
;;タブは2文字ごとに
;;;;追加　タブの設定は以下のようにしないとだめ
(setq-default tab-stop-list
     '(0 1 2 3 4 6 8 12 16 20))
(setq indent-tabs-mode 4)


;コメントアウト用コマンド
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

; globalなC-zを無効化
(global-unset-key "\C-z")


(autoload 'd-mode "d-mode" "Major mode for editing D code." t)
(add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode))

;; スペルチェッカとしてaspellを指定
(setq-default ispell-program-name "aspell")
; 日本語混じりのTeX文書でスペルチェック
(eval-after-load "ispell"
'(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
; YaTeX起動時に，flyspell-modeも起動する
(add-hook 'yatex-mode-hook 'flyspell-mode)
(custom-set-variables
'(flyspell-auto-correct-binding [(control ?\:)]))

;;csv-modeの設定
;;; 20081206 csv-mode.el
;;; http://d.hatena.ne.jp/amt/20081206/CsvMode4Emacs
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
  "Major mode for editing comma-separated value files." t)

;;haskell-modeの設定
(add-to-list 'load-path "~/.emacs.d/haskell-mode-2.8.0")
(require 'haskell-mode)
(require 'haskell-cabal)
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))


;;muti-termの設定
(require 'multi-term)
(setq multi-term-program shell-file-name)

;;doxymacsの設定
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

;;Window サイズ変更用関数
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


(global-set-key "\C-c\C-r" 'window-resizer)



(define-key global-map "\C-q" (make-sparse-keymap))

;; quoted-insert は C-q C-q へ割り当て
(global-set-key "\C-q\C-q" 'quoted-insert)

;; window-resizer は C-q C-r (resize) で
(global-set-key "\C-q\C-r" 'window-resizer)

;;Window移動
(global-set-key "\C-ql" 'windmove-right)
(global-set-key "\C-qh" 'windmove-left)
(global-set-key "\C-qj" 'windmove-down)
