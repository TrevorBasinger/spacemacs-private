
;; PEC specific functions
(defun run-sql-cmd (db query)
  "Run a cmd in sql"
  (interactive)
  (require 'sql)
  (sql-ms)
  (set-buffer "*SQL*")
  (insert (concat "USE " db "\n"))
  (insert query)
  (insert "\n\nGO")
  (comint-send-input))


(defun pec-show-properties-basic ()
  "Shows a list of properties in yardi."
  (interactive)
  (run-sql-cmd (concat "Yardi_PROD" "\n\n") "select * from Yardi_PROD.dbo.PROPERTY;"))

(defun sql-describe-table ()
  (interactive)
  (let ((db   (read-from-minibuffer "Enter the database: " ))
        (tbl  (read-from-minibuffer "Enter the table: ")))
    (run-sql-cmd db (concat "exec sp_columns '" tbl "'"))))

(defun sql-show-databases ()
  (interactive)
  (run-sql-cmd "master" "exec sp_databases"))

(defun yardi-move-trans ()
  (interactive)
  (let ((hmy (read-from-minibuffer "hmy: ")))
    (run-sql-cmd "Yardi_PROD" (concat "update Yardi_PROD.dbo.TRANS set smodulecreatedby = 'PM' where hmy = 1100000000 + " hmy))
    (run-sql-cmd "Yardi_PROD" (concat "select smodulecreatedby, * from TRANS where hmy = 1100000000 + " hmy))))
