; http://www.bookshelf.jp/soft/meadow_16.html
(defvar run-unix
  (or (equal system-type 'gnu/linux)
      (equal system-type 'usg-unix-v)))
(defvar run-cygwin
  (equal system-type 'cygwin))
(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
           (equal system-type 'ms-dos))))
(defvar run-emacs23
  (and (equal emacs-major-version 23)
       (null (featurep 'emacs))))
(defvar run-emacs24
  (and (equal emacs-major-version 24)
       (null (featurep 'emacs))))
(defvar run-meadow (featurep 'meadow))
(defvar run-meadow1 (and run-meadow run-emacs23))
(defvar run-meadow2 (and run-meadow run-emacs24))
(defvar run-emacs (featurep 'emacs))
(defvar run-emacs-no-mule
  (and run-emacs (not (featurep 'mule))))
