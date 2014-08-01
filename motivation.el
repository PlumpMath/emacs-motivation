;;; motivation.el --- Add a real-time counter showing your current age on mode-line.

;; Copyright (C) 2014 Yen-Chin Lee.

;; Author: Yen-Chin Lee <coldnew.tw@gmail.com>
;; Kyewords: converience
;; Version: 0.1
;; X-URL: http://github.com/coldnew/emacs-motivation

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.


;;; Commentary:
;;
;; This a emacs version of Motivation plugin on Google Chrome, which
;; can counting up your real-time age and show it on mode-line.
;;
;; Original Google Chome plugin:
;;      https://chrome.google.com/webstore/detail/motivation/ofdgfpchbidcgncgfpdlpclnpaemakoj
;; GitHub: https://github.com/maccman/motivation

;;; Installation:

;; If you have `melpa` and `emacs24` installed, simply type:
;;
;;      M-x package-install motivation
;;

;; For `cask' user, just add following lines in your `Cask' file
;;
;;      (source melpa)
;;
;;      (depends-on "motivation")
;;

;;; Configuration

;; In your .emacs
;;
;;      (require 'motivation)
;;
;;      ;; Set your birthday
;;      (setq motivation/my-birthday "1990-01-01")
;;
;;      ;; Start motivation
;;      (motivation-start)
;;
;;

;; TODO: clean code

;;; Code:

(defgroup motivation nil
  "Add space between Chinese and English characters automatically."
  :group 'convenience
  :link '(url-link :tag "Github" "https://github.com/coldnew/emacs-motivation"))

;;;; Custom Variables

(defcustom motivation/my-birthday ""
  "String to be display between Chinese and English."
  :group 'motivation
  :type 'string
  :initialize 'custom-initialize-default)

(defcustom motivation/age-format "AGE %2.9f"
  "String format show on modeline"
  :group 'motivation
  :type 'string
  :initialize 'custom-initialize-default)

;;;; Functions

;;(run-with-timer 0.1 0.01 'aa)

;;(add-to-list 'mode-line-misc-info '(aa))

(defun motivation-display ()
  "Show user's current age"
  ;; return empty string if user didn't set birthday
  (if (string= "" motivation/my-birthday)
      ""
    ;; Wikipedia の春分・秋分のページに 1900年～2099年のデータがあって、そ
    ;; こから春分・秋分の周期を求めると 約31556900000ミリ秒 = 約365.2423 日
    ;; でした。この周期を使って春分・秋分を計算する式が上記になります。この
    ;; 式で 少なくともここ２００年くらいの日付が再現できていたと思います。
    ;; ただ今見ると、同じページの 2001～2014年の、時刻まで出ている表を使う
    ;; 方がより正確な式を作れそうですね。１００年以上先のカレンダーが必要に
    ;; なることは少なそうなのであまり気にしなくても良いのでしょうけれど。
    (format motivation/age-format
            (/ (time-to-number-of-days
                (time-subtract (date-to-time  (current-time-string))
                               (date-to-time  (concat motivation/my-birthday " 00:00:00" ))))
               365.2423))))

(provide 'motivation)
;;; motivation.el ends here
