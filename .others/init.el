;; パッケージ読み込み
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)

(package-initialize)

;; フォントの行間を指定 (変更したい場合)
;; (setq-default line-spacing 0.2)

;;
;; Mac OS のクリップボードと同期する
;;

(defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
            (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
            (process-send-string proc text)
            (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;; 時間も表示
(display-time)

;; emacs テーマ選択
(load-theme 'manoj-dark t)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

;; alpha
(if window-system
        (progn
            (set-frame-parameter nil 'alpha 95)))

;; font
(add-to-list 'default-frame-alist '(font . "ricty-12"))

;; line number の表示
(require 'linum)
(global-linum-mode 1)

;; line number を分かりやすくする
(set-face-attribute 'linum nil
                        :foreground "#a9a9a9"
                        :background "#404040"
                        :height 0.9)

;; メニューバーを非表示
(menu-bar-mode 0)

;; 現在ポイントがある関数名をモードラインに表示
(which-function-mode 1)

;; 対応する括弧をハイライト
(show-paren-mode 1)

;; リージョンのハイライト
(transient-mark-mode 1)

;; current directory 表示
(let ((ls (member 'mode-line-buffer-identification
    mode-line-format)))
    (setcdr ls
        (cons '(:eval (concat " ("
                        (abbreviate-file-name default-directory)
                        ")"))
                    (cdr ls))))

;; ターミナルで起動したときにメニューを表示しない
(if (eq window-system 'x)
        (menu-bar-mode 1) (menu-bar-mode 0))
(menu-bar-mode nil)

;; buffer の最後でカーソルを動かそうとしても音をならなくする
(defun next-line (arg)
    (interactive "p")
    (condition-case nil
            (line-move arg)
        (end-of-buffer)))

;; active window move
(global-set-key (kbd "<c-left>")  'windmove-left)
(global-set-key (kbd "<c-down>")  'windmove-down)
(global-set-key (kbd "<c-up>")    'windmove-up)
(global-set-key (kbd "<c-right>") 'windmove-right)

;; rgrep の header message を消去
(defun delete-grep-header ()
    (save-excursion
        (with-current-buffer grep-last-buffer
            (goto-line 5)
            (narrow-to-region (point) (point-max)))))
(defadvice grep (after delete-grep-header activate) (delete-grep-header))
(defadvice rgrep (after delete-grep-header activate) (delete-grep-header))

;; "grep バッファに切り替える"
(defun my-switch-grep-buffer()
    (interactive)
        (if (get-buffer "*grep*")
                        (pop-to-buffer "*grep*")
            (message "No grep buffer")))
(global-set-key (kbd "s-e") 'my-switch-grep-buffer)

;; 履歴参照
(defmacro with-suppressed-message (&rest body)
    "Suppress new messages temporarily in the echo area and the `*Messages*' buffer while BODY is evaluated."
    (declare (indent 0))
    (let ((message-log-max nil))
        `(with-temp-message (or (current-message) "") ,@body)))

;; Terminal 化
(setq shell-pop-shell-type '("eshell" "*eshell*" (lambda () (eshell))))
(global-set-key (kbd "C-c o") 'shell-pop)

;;
;; setq
;;

;; ⌘  キーを super として割り当てる
(setq mac-command-modifier 'super)

;; クリップボードへのコピー
(setq x-select-enable-clipboard t)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;; *.~  バックアップファイルを作らない
(setq make-backup-files nil)

;; .#*  バックアップファイルを作らない
(setq auto-save-default nil)

;; tabサイズ
(setq default-tab-width 4)

;; タイトルにフルパス表示
(setq frame-title-format "%f")

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message 1)

;; scratch の初期メッセージ消去
(setq initial-scratch-message "")

;; スクロールは 1 行ごと
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5)))

;; スクロールの加速をやめる
(setq mouse-wheel-progressive-speed nil)

;; 大文字・小文字を区別しない
(setq case-fold-search t)

;; rgrep 時などに新規に window を立ち上げる
(setq special-display-buffer-names '("*Help*" "*compilation*" "*interpretation*" "*grep*" ))

;;
;; define-key
;;

;; Contol H で 1 文字削除
;; (define-key global-map "\C-h" 'delete-backward-char)

;; 上記定義では Mini Buffer 内では削除できない可能性があるので以下を再定義
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

;; ヘルプの表示を M-? 変更
(define-key global-map "\M-?" 'help-for-help)

;; ファイル名検索
(define-key global-map [(super i)] 'find-name-dired)

;; ファイル内検索
(define-key global-map [(super f)] 'rgrep)

;;
;; put
;;

;; リージョンの大文字小文字変換
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(helm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)
