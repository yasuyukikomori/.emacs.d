;;; .emacs --- dot emacs file

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This file is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this file; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.

;;; Commentary:

;;; Code:

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ site-lisp                                                     ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(let ( (default-directory
         (file-name-as-directory (concat user-emacs-directory "site-lisp")))
       )
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path)
  )

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ remote                                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
(require 'tramp)
(setq tramp-default-method "ssh")

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ el-get                                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ language - coding system                                      ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; デフォルトの文字コード
(set-default-coding-systems 'utf-8-unix)

;; テキストファイル／新規バッファの文字コード
(prefer-coding-system 'utf-8-unix)

;; ファイル名の文字コード
(set-file-name-coding-system 'utf-8-unix)

;; キーボード入力の文字コード
(set-keyboard-coding-system 'utf-8-unix)

;; サブプロセスのデフォルト文字コード
(setq default-process-coding-system '(undecided-dos . utf-8-unix))

;; 環境依存文字 文字化け対応
(set-charset-priority 'ascii 'japanese-jisx0208 'latin-jisx0201
                      'katakana-jisx0201 'iso-8859-1 'cp1252 'unicode)
(set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ key binding - keyboard                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; Altキーを使用せずにMetaキーを使用（有効：t、無効：nil）
(setq w32-alt-is-meta t)

;;; C - h バックスペース
(global-set-key (kbd "C-h") 'delete-backward-char)

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ language - input method                                       ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; モードラインの表示文字列
(setq-default w32-ime-mode-line-state-indicator "[Aa] ")
(setq w32-ime-mode-line-state-indicator-list '("[Aa]" "[あ]" "[Aa]"))

;; IME初期化
(w32-ime-initialize)

;; デフォルトIME
(setq default-input-method "W32-IME")

;; IME変更
(global-set-key (kbd "C-\\") 'toggle-input-method)

;; 漢字/変換キー入力時のエラーメッセージ抑止
(global-set-key (kbd "<M-kanji>") 'ignore)
(global-set-key (kbd "<kanji>") 'ignore)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ language - fontset                                            ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; デフォルト フォント
;; (set-face-attribute 'default nil :family "Migu 1M" :height 110)
(set-face-font 'default "Migu 1M-11:antialias=standard")

;; プロポーショナル フォント
;; (set-face-attribute 'variable-pitch nil :family "Migu 1M" :height 110)
(set-face-font 'variable-pitch "Migu 1M-11:antialias=standard")

;; 等幅フォント
;; (set-face-attribute 'fixed-pitch nil :family "Migu 1M" :height 110)
(set-face-font 'fixed-pitch "Migu 1M-11:antialias=standard")

;; ツールチップ表示フォント
;; (set-face-attribute 'tooltip nil :family "Migu 1M" :height 90)
(set-face-font 'tooltip "Migu 1M-9:antialias=standard")

;;; fontset

;; フォントサイズ調整
(global-set-key (kbd "C-<wheel-up>")   '(lambda() (interactive) (text-scale-increase 1)))
(global-set-key (kbd "C-=")            '(lambda() (interactive) (text-scale-increase 1)))
(global-set-key (kbd "C-<wheel-down>") '(lambda() (interactive) (text-scale-decrease 1)))
(global-set-key (kbd "C--")            '(lambda() (interactive) (text-scale-decrease 1)))

;; フォントサイズ リセット
(global-set-key (kbd "M-0") '(lambda() (interactive) (text-scale-set 0)))


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - frame                                                ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(setq default-frame-alist
      (append '((width                . 85)  ; フレーム幅
                (height               . 38 ) ; フレーム高
             ;; (left                 . 70 ) ; 配置左位置
             ;; (top                  . 28 ) ; 配置上位置
                (line-spacing         . 0  ) ; 文字間隔
                (left-fringe          . 10 ) ; 左フリンジ幅
                (right-fringe         . 11 ) ; 右フリンジ幅
                (menu-bar-lines       . 1  ) ; メニューバー
                (tool-bar-lines       . 1  ) ; ツールバー
                (vertical-scroll-bars . 1  ) ; スクロールバー
                (scroll-bar-width     . 17 ) ; スクロールバー幅
                (cursor-type          . box) ; カーソル種別
                (alpha                . 95) ; 透明度
                ) default-frame-alist) )
(setq initial-frame-alist default-frame-alist)

;; フレーム タイトル
(setq display-time-string-forms
      '((format "%s/%s/%s" year month day)
	(format "(%s:%s)" 24-hours minutes)))
(display-time) ;;display-time-stringの有効化
(setq frame-title-format
      '("emacs " emacs-version (buffer-file-name " - %f")))

;; 初期画面の非表示（有効：t、無効：nil）
(setq inhibit-startup-message nil)
(setq inhibit-startup-screen nil)

;; フルスクリーン化
(global-set-key (kbd "<M-return>") 'toggle-frame-fullscreen)

;; ツールバーを非表示
(tool-bar-mode -1)

;; メニューバーを非表示
(menu-bar-mode -1)

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - mode line                                            ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; 行番号の表示（有効：t、無効：nil）
(line-number-mode t)

;; 列番号の表示（有効：t、無効：nil）
(column-number-mode t)

;; モードライン カスタマイズ
(setq-default
 mode-line-format
 `(
   ""
   w32-ime-mode-line-state-indicator
   " "
   mode-line-mule-info
   mode-line-modified
   mode-line-frame-identification
   mode-line-buffer-identification
   " "
   global-mode-string
   " %[("
   mode-name
   mode-line-process
   "%n"
   ")%] "
   (which-func-mode ("" which-func-format " "))
   (line-number-mode
    (:eval
     (format "L%%l/L%d " (count-lines (point-max) 1) )))
   (column-number-mode " C%c ")
   (-3 . "%p")
   )
 )
(setq mode-line-frame-identification " ")

;; cp932エンコードの表記変更
(coding-system-put 'cp932 :mnemonic ?P)
(coding-system-put 'cp932-dos :mnemonic ?P)
(coding-system-put 'cp932-unix :mnemonic ?P)
(coding-system-put 'cp932-mac :mnemonic ?P)

;; UTF-8エンコードの表記変更
(coding-system-put 'utf-8 :mnemonic ?U)
(coding-system-put 'utf-8-with-signature :mnemonic ?u)

;; 改行コードの表記追加
(setq eol-mnemonic-dos       ":Dos ")
(setq eol-mnemonic-mac       ":Mac ")
(setq eol-mnemonic-unix      ":Unx ")
(setq eol-mnemonic-undecided ":??? ") 

;;display line hi-light
(global-hl-line-mode t)


;;display
(setq show-paren-style 'mixed)
;;(set-face-background 'show-paren-match-face "grey")
;;(set-face-foreground 'show-paren-match-face "black")

;;yes or no -> y or n
(fset 'yes-or-no-p 'y-or-n-p)

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - buffer                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; バッファ画面外文字の切り詰め表示（有効：t、無効：nil）
(setq truncate-lines nil)

;; ウィンドウ縦分割時のバッファ画面外文字の切り詰め表示（有効：t、無効：nil）
(setq truncate-partial-width-windows t)

;; 同一バッファ名にディレクトリ付与
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - minibuffer                                           ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; minibufferのアクティブ時、IMEを無効化
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (deactivate-input-method)))
(wrap-function-to-control-ime 'y-or-n-p nil nil)
(wrap-function-to-control-ime 'map-y-or-n-p nil nil)
(wrap-function-to-control-ime 'read-char nil nil)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - cursor                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; カーソルの点滅（有効：1、無効：0）
(blink-cursor-mode 1)

;; 非アクティブウィンドウのカーソル表示（有効：t、無効：nil）
(setq-default cursor-in-non-selected-windows t)

;; IME無効／有効時のカーソルカラー定義
(unless (facep 'cursor-ime-off)
  (make-face 'cursor-ime-off)
  (set-face-attribute 'cursor-ime-off nil
                      :background "DarkRed" :foreground "White")
  )
(unless (facep 'cursor-ime-on)
  (make-face 'cursor-ime-on)
  (set-face-attribute 'cursor-ime-on nil
                      :background "DarkGreen" :foreground "White")
  )

;; IME無効／有効時のカーソルカラー設定
(advice-add 'ime-force-on
            :before (lambda (&rest args)
                      (if (facep 'cursor-ime-on)
                          (let ( (fg (face-attribute 'cursor-ime-on :foreground))
                                 (bg (face-attribute 'cursor-ime-on :background)) )
                            (set-face-attribute 'cursor nil :foreground fg :background bg) )
                        )
                      ))
(advice-add 'ime-force-off
            :before (lambda (&rest args)
                      (if (facep 'cursor-ime-off)
                          (let ( (fg (face-attribute 'cursor-ime-off :foreground))
                                 (bg (face-attribute 'cursor-ime-off :background)) )
                            (set-face-attribute 'cursor nil :foreground fg :background bg) )
                        )
                      ))

;; バッファ切り替え時の状態引継ぎ設定（有効：t、無効：nil）
(setq w32-ime-buffer-switch-p t)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - linum                                                ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'linum)

;; 行移動を契機に描画
(defvar linum-line-number 0)
(declare-function linum-update-current "linum" ())
(defadvice linum-update-current
    (around linum-update-current-around activate compile)
  (unless (= linum-line-number (line-number-at-pos))
    (setq linum-line-number (line-number-at-pos))
    ad-do-it
    ))

;; バッファ中の行番号表示の遅延設定
(defvar linum-delay nil)
(setq linum-delay t)
(defadvice linum-schedule (around linum-schedule-around () activate)
  (run-with-idle-timer 1.0 nil #'linum-update-current))

;; 行番号の書式
(defvar linum-format nil)
(setq linum-format "%5d")

;; バッファ中の行番号表示（有効：t、無効：nil）
(global-linum-mode t)

;; 文字サイズ
(set-face-attribute 'linum nil :height 0.75)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - tabbar                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'tabbar)

;; tabbar有効化（有効：t、無効：nil）
(call-interactively 'tabbar-mode t)

;; ボタン非表示
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil) (cons "" nil)))
  )

;; タブ切替にマウスホイールを使用（有効：0、無効：-1）
(call-interactively 'tabbar-mwheel-mode -1)
(remove-hook 'tabbar-mode-hook      'tabbar-mwheel-follow)
(remove-hook 'mouse-wheel-mode-hook 'tabbar-mwheel-follow)

;; タブグループを使用（有効：t、無効：nil）
(defvar tabbar-buffer-groups-function nil)
(setq tabbar-buffer-groups-function nil)

;; タブの表示間隔
(defvar tabbar-separator nil)
(setq tabbar-separator '(1.0))

;; タブ切り替え
(global-set-key (kbd "<C-tab>") 'tabbar-forward-tab)
(global-set-key (kbd "C-q")     'tabbar-backward-tab)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ search - isearch                                              ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; 大文字・小文字を区別しないでサーチ（有効：t、無効：nil）
(setq-default case-fold-search nil)

;; インクリメント検索時に縦スクロールを有効化（有効：t、無効：nil）
(setq isearch-allow-scroll nil)

;; C-dで検索文字列を一文字削除
(define-key isearch-mode-map (kbd "C-d") 'isearch-delete-char)

;; C-yで検索文字列にヤンク貼り付け
(define-key isearch-mode-map (kbd "C-y") 'isearch-yank-kill)

;; C-eで検索文字列を編集
;;(define-key isearch-mode-map (kbd "C-e") 'isearch-edit-string)

;; Tabで検索文字列を補完
(define-key isearch-mode-map (kbd "TAB") 'isearch-yank-word)

;; C-gで検索を終了
(define-key isearch-mode-map (kbd "C-g")
  '(lambda() (interactive) (isearch-done)))

;; 日本語の検索文字列をミニバッファに表示
(define-key isearch-mode-map (kbd "<compend>")
  '(lambda() (interactive) (isearch-update)))
(define-key isearch-mode-map (kbd "<kanji>")
  'isearch-toggle-input-method)
(add-hook
 'isearch-mode-hook
 '(lambda() (setq w32-ime-composition-window (minibuffer-window)))
 )
(add-hook
 'isearch-mode-end-hook
 '(lambda() (setq w32-ime-composition-window nil))
 )


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - hiwin                                                ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'hiwin)

;; hiwin-modeを有効化
(hiwin-activate)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ search - migemo                                               ;;;
;;;   https://github.com/emacs-jp/migemo                            ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(setq search-default-mode nil)
(setq search-default-regexp-mode nil)

(require 'migemo)

(defvar migemo-command nil)
(setq migemo-command "cmigemo")

(defvar migemo-options nil)
(setq migemo-options '("-q" "--emacs"))

(defvar migemo-dictionary nil)
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")

(defvar migemo-user-dictionary nil)

(defvar migemo-regex-dictionary nil)

(defvar migemo-coding-system nil)
(setq migemo-coding-system 'utf-8-unix)

(load-library "migemo")


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ file - backup                                                 ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; ファイルオープン時のバックアップ（~）（有効：t、無効：nil）
(setq make-backup-files   t)  ;; 自動バックアップの実行有無
(setq version-control     t)  ;; バックアップファイルへの番号付与
(setq kept-new-versions   3)  ;; 最新バックアップファイルの保持数
(setq kept-old-versions   0)  ;; 最古バックアップファイルの保持数
(setq delete-old-versions t)  ;; バックアップファイル削除の実行有無

;; ファイルオープン時のバックアップ（~）の格納ディレクトリ
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "/tmp/emacsbk"))
            backup-directory-alist))

;; 編集中ファイルの自動バックアップ（有効：t、無効：nil）
(setq backup-inhibited nil)

;; 終了時に自動バックアップファイルを削除（有効：t、無効：nil）
(setq delete-auto-save-files nil)

;; 編集中ファイルのバックアップ（有効：t、無効：nil）
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)

;; 編集中ファイルのバックアップ間隔（秒）
(setq auto-save-timeout 3)

;; 編集中ファイルのバックアップ間隔（打鍵）
(setq auto-save-interval 100)

;; 編集中ファイル（##）の格納ディレクトリ
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "/tmp/emacsbk") t)))


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ file - lockfile                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; ロックファイルを生成（有効：t、無効：nil）
(setq create-lockfiles nil)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ scroll                                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; スクロール時のカーソル位置を維持（有効：t、無効：nil）
(setq scroll-preserve-screen-position t)

;; スクロール開始の残り行数
(setq scroll-margin 0)

;; スクロール時の行数
(setq scroll-conservatively 10000)

;; スクロール時の行数（scroll-marginに影響せず）
(setq scroll-step 0)

;; 画面スクロール時の重複表示する行数
(setq next-screen-context-lines 1)

;; キー入力中の画面更新を抑止（有効：t、無効：nil）
(setq redisplay-dont-pause t)

;; recenter-top-bottomのポジション
(setq recenter-positions '(middle top bottom))

;; 横スクロール開始の残り列数
(setq hscroll-margin 1)

;; 横スクロール時の列数
(setq hscroll-step 1)

;; スクロールダウン
(global-set-key (kbd "C-z") 'scroll-down)

;; バッファの最後までスクロールダウン
(defadvice scroll-down (around scroll-down activate compile)
  (interactive)
  (let (
        (bgn-num (+ 1 (count-lines (point-min) (point))))
        )
    (if (< bgn-num (window-height))
        (goto-char (point-min))
      ad-do-it) ))

;; バッファの先頭までスクロールアップ
(defadvice scroll-up (around scroll-up activate compile)
  (interactive)
  (let (
        (bgn-num (+ 1 (count-lines (point-min) (point))))
        (end-num nil)
        )
    (save-excursion
      (goto-char (point-max))
      (setq end-num (+ 1 (count-lines (point-min) (point))))
      )
    (if (< (- (- end-num bgn-num) (window-height)) 0)
        (goto-char (point-max))
      ad-do-it) ))

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; 日付挿入
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
(defun insert-current-time()
  (interactive)
  (insert (format-time-string "%Y-%m-%d(%a) %H:%M:%S" (current-time))))

(define-key global-map "\C-cd" `insert-current-time)

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; 矩形編集 cua-mode
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(cua-mode t)  ; cua-modeをオン
(setq cua-enable-cua-keys nil)  ; CUAキーバインドを無効化

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ howm
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;; howm
;;(setq howm-view-title-header "#") ; this should be evaluated in advance to handle markdown
(add-to-list 'load-path "~/.emacs.d/site-lisp/howm/")
(setq howm-menu-lang 'ja)
;; (require 'howm-mode)

(global-set-key "\C-c,," 'howm-menu)
(autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)

;; file associations
;;(defun markdown-text-mode ()
;;  (markdown-mode)      ;major
;;  (outline-minor-mode) ;minor
;;  )
;;(add-to-list 'auto-mode-alist '("\\.txt$" . markdown-mode))

;; (setq howm-directory "/g/マイドライブ/share/howm/")
(setq howm-directory "~/howm/")
;;(setq howm-home-directory "~/howm/")
;;(setq howm-keyword-file (concat howm-home-directory ".howm-keys"))
;;(setq howm-menu-file (concat howm-home-directory "menu.txt"))
;;(setq howm-history-file (concat howm-home-directory ".howm-history"))

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ mrakdown                                                      ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(setq markdown-command "/c/Pandoc/pandoc.exe -s --self-contained  -t html5 -c /Pandoc/github.css")


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ shell                                                         ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'shell)
(setq explicit-shell-file-name "bash.exe")
(setq shell-command-switch "-c")
(setq shell-file-name "bash.exe")
;; (setq explicit-bash.exe-args '("--login" "-i"))

;; (M-! and M-| and compile.el)
(setq shell-file-name "bash.exe")
(modify-coding-system-alist 'process ".*sh\\.exe" 'utf-8)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ package manager                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ theme                                                         ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; テーマ格納ディレクトリのパス追加
(add-to-list 'custom-theme-load-path
             (file-name-as-directory (concat user-emacs-directory "theme"))
             )

;; テーマ選択
;; (load-theme 'solarized-light t)
;; (load-theme 'solarized-dark t)
;; (load-theme 'gnupack-dark t)
(load-theme 'deeper-blue' t)
;; (load-theme 'wombat' t)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ server                                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; emacs-server起動
(require 'server)
(defun server-ensure-safe-dir (dir) "Noop" t)
(setq server-socket-dir "~/.emacs.d")
(unless (server-running-p)
  (server-start)
)

;;; (provide 'init)
;;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (howm)))
 '(tabbar-mode t nil (tabbar)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-pre-face ((t (:inherit (markdown-code-face font-lock-constant-face))))))
;; Local Variables:
;; coding: utf-8
;; mode: emacs-lisp
;; End:
