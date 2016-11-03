-- ============================================================
-- ============== CREATION OF THE TABLE TABLE_NAME ============
-- ============================================================

	CREATE TABLE TABLE_NAME(
		id int NOT NULL AUTO_INCREMENT,
		lang int NOT NULL,
		title varchar(250),
		home int DEFAULT 0,
		checked int DEFAULT 0,
		rank int DEFAULT 0,
		add_date int,
		edit_date int,
		PRIMARY KEY(id,lang)
	) ENGINE=INNODB DEFAULT CHARSET=utf8;

	ALTER TABLE TABLE_NAME ADD CONSTRAINT TABLE_NAME_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

-- ============================================================
-- =========== CREATION OF THE TABLE TABLE_NAME_file ==========
-- ============================================================

	CREATE TABLE TABLE_NAME_file (
		id int NOT NULL AUTO_INCREMENT,
		lang int NOT NULL,
		id_item int NOT NULL,
		home int DEFAULT 0,
		checked int DEFAULT 1,
		rank int DEFAULT 0,
		file varchar(250),
		label varchar(250),
		type varchar(20),
		PRIMARY KEY(id,lang)
	) ENGINE=INNODB DEFAULT CHARSET=utf8;

	ALTER TABLE TABLE_NAME_file ADD CONSTRAINT TABLE_NAME_file_fkey FOREIGN KEY (id_item,lang) REFERENCES TABLE_NAME(id,lang) ON UPDATE NO ACTION ON DELETE CASCADE;
	ALTER TABLE TABLE_NAME_file ADD CONSTRAINT TABLE_NAME_file_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;
