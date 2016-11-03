-- SQL SCRIPT FOR THE DATABASE OF PANDAO CMS / PANDA MULTI RESORTS

-- **** Values to replace ****
-- MY_DATABASE
-- MY_DB_USER
-- MY_DB_PASS
-- USER_EMAIL
-- USER_LOGIN
-- USER_PASS
-- INSTALL_DATE

-- **** Tables ****
-- pm_user
-- pm_lang
-- pm_lang_file
-- pm_page
-- pm_page_file
-- pm_media
-- pm_media_file
-- pm_text
-- pm_widget
-- pm_article
-- pm_article_file
-- pm_comment
-- pm_tag
-- pm_slide
-- pm_slide_file
-- pm_location
-- pm_message
-- pm_currency
-- pm_country
-- pm_booking
-- pm_hotel
-- pm_room
-- pm_facility
-- pm_service

-- **** Edit with the name of your database ****
CREATE DATABASE IF NOT EXISTS MY_DATABASE;
USE MY_DATABASE;

-- **** Uncomment the following line if you are allowed to create users ****
-- GRANT SELECT, INSERT, UPDATE, DELETE ON MY_DATABASE.* TO 'MY_DB_USER'@'localhost' IDENTIFIED BY 'MY_DB_PASS' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;

-- ================= CREATION OF THE TABLE pm_user ===============

CREATE TABLE IF NOT EXISTS pm_user(
    id int NOT NULL AUTO_INCREMENT,
    name varchar(100),
    email varchar(100),
    login varchar(50),
    pass varchar(100),
    type varchar(20),
    add_date int,
    edit_date int,
    checked int DEFAULT 0,
    fb_id varchar(50),
    address varchar(250),
    postcode varchar(10),
    city varchar(100),
    company varchar(100),
    country varchar(100),
    mobile varchar(50),
    phone varchar(50),
    token varchar(50),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- **** Edit with the informations of the admin user ****
INSERT INTO pm_user (id, name, email, login, pass, type, add_date, edit_date, checked, fb_id, address, postcode, city, company, country, mobile, phone, token) VALUES
(1, 'Administrator', 'USER_EMAIL', 'USER_LOGIN', 'USER_PASS', 'administrator', INSTALL_DATE, INSTALL_DATE, 1, '', '', '', '', '', '', '', '', '');

-- ================= CREATION OF THE TABLE pm_lang ===============

CREATE TABLE IF NOT EXISTS pm_lang(
    id int NOT NULL AUTO_INCREMENT,
    title varchar(20),
    locale varchar(20),
    main int DEFAULT 0,
    checked int DEFAULT 0,
    rank int DEFAULT 0,
    tag varchar(20),
    rtl int DEFAULT 0,
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

--
-- Content of the table pm_lang
--

INSERT INTO pm_lang (id, title, locale, main, checked, rank, tag, rtl) VALUES
(1, 'Français', 'fr_FR', 0, 1, 2, 'fr', 0),
(2, 'English', 'en_GB', 1, 1, 1, 'en', 0),
(3, 'عربي', 'ar_MA', 0, 1, 3, 'ar', 1);

-- ============== CREATION OF THE TABLE pm_lang_file =============

CREATE TABLE IF NOT EXISTS pm_lang_file (
    id int NOT NULL AUTO_INCREMENT,
    id_item int NOT NULL,
    home int DEFAULT 0,
    checked int DEFAULT 1,
    rank int DEFAULT 0,
    file varchar(250),
    label varchar(250),
    type varchar(20),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE pm_lang_file ADD CONSTRAINT lang_file_fkey FOREIGN KEY (id_item) REFERENCES pm_lang(id) ON UPDATE NO ACTION ON DELETE CASCADE;

--
-- Content of the table pm_lang_file
--

INSERT INTO pm_lang_file (id, id_item, home, checked, rank, file, label, type) VALUES
(1, 1, 0, 1, 2, 'fr.png', '', 'image'),
(2, 2, 0, 1, 1, 'gb.png', '', 'image'),
(3, 3, 0, 1, 3, 'ar.png', '', 'image');

-- ================= CREATION OF THE TABLE pm_page ===============

CREATE TABLE IF NOT EXISTS pm_page(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    name varchar(50),
    title varchar(250),
    subtitle varchar(250),
    title_tag varchar(250),
    alias varchar(100),
    descr longtext,
    robots varchar(20),
    keywords varchar(250),
    intro longtext,
    text longtext,
    text2 longtext,
    id_parent int,
    page_model varchar(50),
    article_model varchar(50),
    main int DEFAULT 1,
    footer int DEFAULT 0,
    home int DEFAULT 0,
    checked int DEFAULT 0,
    rank int DEFAULT 0,
    add_date int,
    edit_date int,
    comment int DEFAULT 0,
    rating int DEFAULT 0,
    system int DEFAULT 0,
    PRIMARY KEY(id, lang)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE pm_page ADD CONSTRAINT page_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_page
--

INSERT INTO pm_page (id, lang, name, title, subtitle, title_tag, alias, descr, robots, keywords, intro, text, text2, id_parent, page_model, article_model, main, footer, home, checked, rank, add_date, edit_date, comment, rating, system) VALUES
(1, 1, 'Accueil', 'Lorem ipsum dolor sit amet', 'Consectetur adipiscing elit', 'Accueil', '', '', 'index,follow', '', '', '', '', null, 'home', '', 1, 0, 1, 1, 1, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(1, 2, 'Home', 'Panda Multi Resorts, Luxury Hotels', '', 'Panda Multi Resorts, web software to create and manage multi hotels platforms', '', '', 'index,follow', '', '', '<blockquote class="text-center">\r\n<p>A man travels the world over in search of what he needs and returns home to find it.</p>\r\n</blockquote>\r\n\r\n<p class="text-muted" style="text-align: center;">- George A. Moore -</p>\r\n', '', null, 'home', '', 1, 0, 1, 1, 1, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(1, 3, 'ترحيب', 'هو سقطت الساحلية ذات, أن.', 'غير بمعارضة وهولندا، الإقتصادية قد, فقد الفرنسي المعاهدات قد من.', 'ترحيب', '', '', 'index,follow', '', '', '', '', null, 'home', '', 1, 0, 1, 1, 1, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(2, 1, 'Contact', 'Contact', '', 'Contact', 'contact', '', 'index,follow', '', '', '', '', null, 'contact', '', 1, 1, 0, 1, 11, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(2, 2, 'Contact', 'Contact', '', 'Contact', 'contact', '', 'index,follow', '', '', '', '', null, 'contact', '', 1, 1, 0, 1, 11, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(2, 3, 'جهة الاتصال', 'جهة الاتصال', '', 'جهة الاتصال', 'contact', '', 'index,follow', '', '', '', '', null, 'contact', '', 1, 1, 0, 1, 11, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(3, 1, 'Mentions légales', 'Mentions légales', '', 'Mentions légales', 'mentions-legales', '', 'index,follow', '', '', '', '', null, 'page', '', 0, 1, 0, 1, 12, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(3, 2, 'Legal notices', 'Legal notices', '', 'Legal notices', 'legal-notices', '', 'index,follow', '', '', '', '', null, 'page', '', 0, 1, 0, 1, 12, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(3, 3, 'يذكر القانونية', 'يذكر القانونية', '', 'يذكر القانونية', 'legal-notices', '', 'index,follow', '', '', '', '', null, 'page', '', 0, 1, 0, 1, 12, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(4, 1, 'Plan du site', 'Plan du site', '', 'Plan du site', 'plan-site', '', 'index,follow', '', '', '', '', null, 'sitemap', '', 0, 1, 0, 1, 13, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(4, 2, 'Sitemap', 'Sitemap', '', 'Sitemap', 'sitemap', '', 'index,follow', '', '', '', '', null, 'sitemap', '', 0, 1, 0, 1, 13, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(4, 3, 'خريطة الموقع', 'خريطة الموقع', '', 'خريطة الموقع', 'sitemap', '', 'index,follow', '', '', '', '', null, 'sitemap', '', 0, 1, 0, 1, 13, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(5, 1, 'Qui sommes-nous ?', 'Qui sommes-nous ?', '', 'Qui sommes-nous ?', 'qui-sommes-nous', '', 'index,follow', '', '', '', '', null, 'page', 'article', 1, 0, 0, 1, 2, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(5, 2, 'About us', 'About us', '', 'About us', 'about-us', '', 'index,follow', '', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque fringilla vel est at rhoncus. Cras porttitor ligula vel magna vehicula accumsan. Mauris eget elit et sem commodo interdum. Aenean dolor sem, tincidunt ac neque tempus, hendrerit blandit lacus. Vivamus placerat nulla in mi tristique, fringilla fermentum nisl vehicula. Nullam quis eros non magna tincidunt interdum ac eu eros. Morbi malesuada pulvinar ultrices. Etiam bibendum efficitur risus, sit amet venenatis urna ullamcorper non. Proin fermentum malesuada tortor, vitae mattis sem scelerisque in. Curabitur rutrum leo at mi efficitur suscipit. Vivamus tristique lorem eros, sit amet malesuada augue sodales sed.</p>\r\n', '<p>Etiam bibendum efficitur risus, sit amet venenatis urna ullamcorper non. Proin fermentum malesuada tortor, vitae mattis sem scelerisque in. Curabitur rutrum leo at mi efficitur.</p>\r\n', null, 'page', 'article', 1, 0, 0, 1, 2, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(5, 3, 'معلومات عنا', 'معلومات عنا', '', 'معلومات عنا', 'about us', '', 'index,follow', '', '', '', '', null, 'page', 'article', 1, 0, 0, 1, 2, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(6, 1, 'Recherche', 'Recherche', '', 'Recherche', 'search', '', 'noindex,nofollow', '', '', '', '', null, 'search', '', 0, 0, 0, 1, 14, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(6, 2, 'Search', 'Search', '', 'Search', 'search', '', 'noindex,nofollow', '', '', '', '', null, 'search', '', 0, 0, 0, 1, 14, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(6, 3, 'بحث', 'بحث', '', 'بحث', 'search', '', 'noindex,nofollow', '', '', '', '', null, 'search', '', 0, 0, 0, 1, 14, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(7, 1, 'Galerie', 'Galerie', '', 'Galerie', 'galerie', '', 'index,follow', '', '', '', '', null, 'page', 'gallery', 1, 0, 0, 1, 5, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(7, 2, 'Gallery', 'Gallery', '', 'Gallery', 'gallery', '', 'index,follow', '', '', '', '', null, 'page', 'gallery', 1, 0, 0, 1, 5, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(7, 3, 'صور معرض', 'صور معرض', '', 'صور معرض', 'gallery', '', 'index,follow', '', '', '', '', null, 'page', 'gallery', 1, 0, 0, 1, 5, INSTALL_DATE, INSTALL_DATE, 0, 0, 0),
(8, 1, '404', 'Erreur 404 : Page introuvable !', '', '404 Page introuvable', '404', '', 'noindex,nofollow', '', '', '<p>L''URL demandée n''a pas été trouvée sur ce serveur.<br />\r\nLa page que vous voulez afficher n''existe pas, ou est temporairement indisponible.</p>\r\n\r\n<p>Merci d''essayer les actions suivantes :</p>\r\n\r\n<ul>\r\n	<li>Assurez-vous que l''URL dans la barre d''adresse de votre navigateur est correctement orthographiée et formatée.</li>\r\n	<li>Si vous avez atteint cette page en cliquant sur un lien ou si vous pensez que cela concerne une erreur du serveur, contactez l''administrateur pour l''alerter.</li>\r\n</ul>\r\n', '', null, '404', '', 0, 0, 0, 1, 15, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(8, 2, '404', '404 Error: Page not found!', '', '404 Not Found', '404', '', 'noindex,nofollow', '', '', '<p>The wanted URL was not found on this server.<br />\r\nThe page you wish to display does not exist, or is temporarily unavailable.</p>\r\n\r\n<p>Thank you for trying the following actions :</p>\r\n\r\n<ul>\r\n	<li>Be sure the URL in the address bar of your browser is correctly spelt and formated.</li>\r\n	<li>If you reached this page by clicking a link or if you think that it is about an error of the server, contact the administrator to alert him.</li>\r\n</ul>\r\n', '', null, '404', '', 0, 0, 0, 1, 15, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(8, 3, '404', '404 Error: Page not found!', '', '404 Not Found', '404', '', 'noindex,nofollow', '', '', '', '', null, '404', '', 0, 0, 0, 1, 15, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(9, 1, 'Hôtels', 'Hôtels', '', 'Hôtels', 'hotels', '', 'index,follow', '', '', '', '', null, 'hotels', 'hotel', 1, 0, 0, 1, 3, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(9, 2, 'Hotels', 'Hotels', '', 'Hotels', 'hotels', '', 'index,follow', '', '', '', '', null, 'hotels', 'hotel', 1, 0, 0, 1, 3, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(9, 3, 'الفنادق', 'الفنادق', '', 'الفنادق', 'hotels', '', 'index,follow', '', '', '', '', null, 'hotels', 'hotel', 1, 0, 0, 1, 3, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(10, 1, 'Réserver', 'Réserver', '', 'Réserver', 'reserver', '', 'noindex,nofollow', '', '', '', '', null, 'booking', '', 1, 0, 0, 1, 6, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(10, 2, 'Booking', 'Booking', '', 'Booking', 'booking', '', 'noindex,nofollow', '', '', '', '', null, 'booking', '', 1, 0, 0, 1, 6, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(10, 3, 'الحجز', 'الحجز', '', 'الحجز', 'booking', '', 'noindex,nofollow', '', '', '', '', null, 'booking', '', 1, 0, 0, 1, 6, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(11, 1, 'Coordonnées', 'Coordonnées', '', 'Coordonnées', 'coordonnees', '', 'noindex,nofollow', '', '', '', '', 10, 'details', '', 0, 0, 0, 1, 8, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(11, 2, 'Details', 'Booking details', '', 'Booking details', 'booking-details', '', 'noindex,nofollow', '', '', '', '', 10, 'details', '', 0, 0, 0, 1, 8, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(11, 3, 'تفاصيل الحجز', 'تفاصيل الحجز', '', 'تفاصيل الحجز', 'booking-details', '', 'noindex,nofollow', '', '', '', '', 10, 'details', '', 0, 0, 0, 1, 8, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(12, 1, 'Paiement', 'Paiement', '', 'Paiement', 'paiement', '', 'noindex,nofollow', '', '', '', '', 13, 'payment', '', 0, 0, 0, 1, 10, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(12, 2, 'Payment', 'Payment', '', 'Payment', 'payment', '', 'noindex,nofollow', '', '', '', '', 13, 'payment', '', 0, 0, 0, 1, 10, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(12, 3, 'دفع', 'دفع', '', 'دفع', 'payment', '', 'noindex,nofollow', '', '', '', '', 13, 'payment', '', 0, 0, 0, 1, 10, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(13, 1, 'Résumé de la réservation', 'Résumé de la réservation', '', 'Résumé de la réservation', 'resume-reservation', '', 'noindex,nofollow', '', '', '', '', 11, 'summary', '', 0, 0, 0, 1, 9, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(13, 2, 'Summary', 'Booking summary', '', 'Booking summary', 'booking-summary', '', 'noindex,nofollow', '', '', '', '', 11, 'summary', '', 0, 0, 0, 1, 9, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(13, 3, 'ملخص الحجز', 'ملخص الحجز', '', 'ملخص الحجز', 'booking-summary', '', 'noindex,nofollow', '', '', '', '', 11, 'summary', '', 0, 0, 0, 1, 9, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(14, 1, 'Espace client', 'Espace client', '', 'Espace client', 'espace-client', '', 'noindex,nofollow', '', '', '', '', null, 'account', '', 0, 0, 0, 1, 16, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(14, 2, 'Account', 'Account', '', 'Account', 'account', '', 'noindex,nofollow', '', '', '', '', null, 'account', '', 0, 0, 0, 1, 16, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(14, 3, 'Account', 'Account', '', 'Account', 'account', '', 'noindex,nofollow', '', '', '', '', null, 'account', '', 0, 0, 0, 1, 16, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(15, 1, 'Activités', 'Activités', '', 'Activités', 'reservation-activitees', '', 'noindex,nofollow', '', '', '', '', 10, 'booking-activities', '', 1, 0, 0, 1, 7, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(15, 2, 'Activities', 'Activities', '', 'Activities', 'booking-activities', '', 'noindex,nofollow', '', '', '', '', 10, 'booking-activities', '', 1, 0, 0, 1, 7, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(15, 3, 'Activities', 'Activities', '', 'Activities', 'booking-activities', '', 'noindex,nofollow', '', '', '', '', 10, 'booking-activities', '', 1, 0, 0, 1, 7, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(16, 1, 'Activités', 'Activités', '', 'Activités', 'activitees', '', 'noindex,nofollow', '', '', '', '', null, 'activities', 'activity', 1, 0, 0, 1, 4, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(16, 2, 'Activities', 'Activities', '', 'Activities', 'activities', '', 'noindex,nofollow', '', '', '', '', null, 'activities', 'activity', 1, 0, 0, 1, 4, INSTALL_DATE, INSTALL_DATE, 0, 0, 1),
(16, 3, 'Activities', 'Activities', '', 'Activities', 'activities', '', 'noindex,nofollow', '', '', '', '', null, 'activities', 'activity', 1, 0, 0, 1, 4, INSTALL_DATE, INSTALL_DATE, 0, 0, 1);

-- ============== CREATION OF THE TABLE pm_page_file =============

CREATE TABLE IF NOT EXISTS pm_page_file (
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

ALTER TABLE pm_page_file ADD CONSTRAINT page_file_fkey FOREIGN KEY (id_item, lang) REFERENCES pm_page(id, lang) ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE pm_page_file ADD CONSTRAINT page_file_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

-- ================ CREATION OF THE TABLE pm_media ===============

CREATE TABLE IF NOT EXISTS pm_media(
    id int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- ============== CREATION OF THE TABLE pm_media_file ============

CREATE TABLE IF NOT EXISTS pm_media_file (
    id int NOT NULL AUTO_INCREMENT,
    id_item int NOT NULL,
    home int DEFAULT 0,
    checked int DEFAULT 1,
    rank int DEFAULT 0,
    file varchar(250),
    label varchar(250),
    type varchar(20),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE pm_media_file ADD CONSTRAINT media_file_fkey FOREIGN KEY (id_item) REFERENCES pm_media(id) ON UPDATE NO ACTION ON DELETE CASCADE;

-- ================ CREATION OF THE TABLE pm_text ================

CREATE TABLE IF NOT EXISTS pm_text(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    name varchar(50),
    value text,
    PRIMARY KEY(id, lang)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE pm_text ADD CONSTRAINT text_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_text
--

INSERT INTO pm_text (id, lang, name, value) VALUES
(1, 1, 'CREATION', 'Création'),
(1, 2, 'CREATION', 'Creation'),
(1, 3, 'CREATION', 'إنشاء'),
(2, 1, 'MESSAGE', 'Message'),
(2, 2, 'MESSAGE', 'Message'),
(2, 3, 'MESSAGE', 'رسالة'),
(3, 1, 'EMAIL', 'E-mail'),
(3, 2, 'EMAIL', 'E-mail'),
(3, 3, 'EMAIL', 'بَرِيدٌ إلِكْترونيّ'),
(4, 1, 'PHONE', 'Tél.'),
(4, 2, 'PHONE', 'Phone'),
(4, 3, 'PHONE', 'رقم هاتف'),
(5, 1, 'FAX', 'Fax'),
(5, 2, 'FAX', 'Fax'),
(5, 3, 'FAX', 'فاكس'),
(6, 1, 'COMPANY', 'Société'),
(6, 2, 'COMPANY', 'Company'),
(6, 3, 'COMPANY', 'مشروع'),
(7, 1, 'COPY_CODE', 'Recopiez le code'),
(7, 2, 'COPY_CODE', 'Copy the code'),
(7, 3, 'COPY_CODE', 'رمز الأمان'),
(8, 1, 'SUBJECT', 'Sujet'),
(8, 2, 'SUBJECT', 'Subject'),
(8, 3, 'SUBJECT', 'موضوع'),
(9, 1, 'REQUIRED_FIELD', 'Champ requis'),
(9, 2, 'REQUIRED_FIELD', 'Required field'),
(9, 3, 'REQUIRED_FIELD', 'الحقل المطلوب'),
(10, 1, 'INVALID_CAPTCHA_CODE', 'Le code de sécurité saisi est incorrect'),
(10, 2, 'INVALID_CAPTCHA_CODE', 'Invalid security code'),
(10, 3, 'INVALID_CAPTCHA_CODE', 'رمز الحماية أدخلته غير صحيح'),
(11, 1, 'INVALID_EMAIL', 'Adresse e-mail invalide'),
(11, 2, 'INVALID_EMAIL', 'Invalid email address'),
(11, 3, 'INVALID_EMAIL', 'بريد إلكتروني خاطئ'),
(12, 1, 'FIRSTNAME', 'Prénom'),
(12, 2, 'FIRSTNAME', 'Firstname'),
(12, 3, 'FIRSTNAME', 'الاسم الأول'),
(13, 1, 'LASTNAME', 'Nom'),
(13, 2, 'LASTNAME', 'Lastname'),
(13, 3, 'LASTNAME', 'اسم العائلة'),
(14, 1, 'ADDRESS', 'Adresse'),
(14, 2, 'ADDRESS', 'Address'),
(14, 3, 'ADDRESS', 'عنوان الشارع'),
(15, 1, 'POSTCODE', 'Code postal'),
(15, 2, 'POSTCODE', 'Post code'),
(15, 3, 'POSTCODE', 'الرمز البريدي'),
(16, 1, 'CITY', 'Ville'),
(16, 2, 'CITY', 'City'),
(16, 3, 'CITY', 'مدينة'),
(17, 1, 'MOBILE', 'Portable'),
(17, 2, 'MOBILE', 'Mobile'),
(17, 3, 'MOBILE', 'هاتف'),
(18, 1, 'ADD', 'Ajouter'),
(18, 2, 'ADD', 'Add'),
(18, 3, 'ADD', 'إضافة على'),
(19, 1, 'EDIT', 'Modifier'),
(19, 2, 'EDIT', 'Edit'),
(19, 3, 'EDIT', 'تغيير'),
(20, 1, 'INVALID_INPUT', 'Saisie invalide'),
(20, 2, 'INVALID_INPUT', 'Invalid input'),
(20, 3, 'INVALID_INPUT', 'إدخال غير صالح'),
(21, 1, 'MAIL_DELIVERY_FAILURE', 'Echec lors de l''envoi du message.'),
(21, 2, 'MAIL_DELIVERY_FAILURE', 'A failure occurred during the delivery of this message.'),
(21, 3, 'MAIL_DELIVERY_FAILURE', 'حدث فشل أثناء تسليم هذه الرسالة.'),
(22, 1, 'MAIL_DELIVERY_SUCCESS', 'Merci de votre intérêt, votre message a bien été envoyé.\nNous vous contacterons dans les plus brefs délais.'),
(22, 2, 'MAIL_DELIVERY_SUCCESS', 'Thank you for your interest, your message has been sent.\nWe will contact you as soon as possible.'),
(22, 3, 'MAIL_DELIVERY_SUCCESS', 'خزان لاهتمامك ، تم إرسال رسالتك . سوف نتصل بك في أقرب وقت ممكن .'),
(23, 1, 'SEND', 'Envoyer'),
(23, 2, 'SEND', 'Send'),
(23, 3, 'SEND', 'ارسل انت'),
(24, 1, 'FORM_ERRORS', 'Le formulaire comporte des erreurs.'),
(24, 2, 'FORM_ERRORS', 'The following form contains some errors.'),
(24, 3, 'FORM_ERRORS', 'النموذج التالي يحتوي على بعض الأخطاء.'),
(25, 1, 'FROM_DATE', 'Du'),
(25, 2, 'FROM_DATE', 'From'),
(25, 3, 'FROM_DATE', 'من'),
(26, 1, 'TO_DATE', 'au'),
(26, 2, 'TO_DATE', 'till'),
(26, 3, 'TO_DATE', 'حتى'),
(27, 1, 'FROM', 'De'),
(27, 2, 'FROM', 'From'),
(27, 3, 'FROM', 'من'),
(28, 1, 'TO', 'à'),
(28, 2, 'TO', 'to'),
(28, 3, 'TO', 'إلى'),
(29, 1, 'BOOK', 'Réserver'),
(29, 2, 'BOOK', 'Book'),
(29, 3, 'BOOK', 'للحجز'),
(30, 1, 'READMORE', 'Lire la suite'),
(30, 2, 'READMORE', 'Read more'),
(30, 3, 'READMORE', 'اقرأ المزيد'),
(31, 1, 'BACK', 'Retour'),
(31, 2, 'BACK', 'Back'),
(31, 3, 'BACK', 'عودة'),
(32, 1, 'DISCOVER', 'Découvrir'),
(32, 2, 'DISCOVER', 'Discover'),
(32, 3, 'DISCOVER', 'اكتشف'),
(33, 1, 'ALL', 'Tous'),
(33, 2, 'ALL', 'All'),
(33, 3, 'ALL', 'كل'),
(34, 1, 'ALL_RIGHTS_RESERVED', 'Tous droits réservés'),
(34, 2, 'ALL_RIGHTS_RESERVED', 'All rights reserved'),
(34, 3, 'ALL_RIGHTS_RESERVED', 'جميع الحقوق محفوظه'),
(35, 1, 'FORGOTTEN_PASSWORD', 'Mot de passe oublié ?'),
(35, 2, 'FORGOTTEN_PASSWORD', 'Forgotten password?'),
(35, 3, 'FORGOTTEN_PASSWORD', 'هل نسيت كلمة المرور؟'),
(36, 1, 'LOG_IN', 'Connexion'),
(36, 2, 'LOG_IN', 'Log in'),
(36, 3, 'LOG_IN', 'تسجيل الدخول'),
(37, 1, 'SIGN_UP', 'Inscription'),
(37, 2, 'SIGN_UP', 'Sign up'),
(37, 3, 'SIGN_UP', 'تسجيل'),
(38, 1, 'LOG_OUT', 'Déconnexion'),
(38, 2, 'LOG_OUT', 'Log out'),
(38, 3, 'LOG_OUT', 'تسجيل الخروج'),
(39, 1, 'SEARCH', 'Rechercher'),
(39, 2, 'SEARCH', 'Search'),
(39, 3, 'SEARCH', 'ابحث عن'),
(40, 1, 'RESET_PASS_SUCCESS', 'Votre nouveau mot de passe vous a été envoyé sur votre adresse e-mail.'),
(40, 2, 'RESET_PASS_SUCCESS', 'Your new password was sent to you on your e-mail.'),
(40, 3, 'RESET_PASS_SUCCESS', 'تم إرسال كلمة المرور الجديدة إلى عنوان البريد الإلكتروني الخاص بك'),
(41, 1, 'PASS_TOO_SHORT', 'Le mot de passe doit contenir 6 caractères au minimum'),
(41, 2, 'PASS_TOO_SHORT', 'The password must contain 6 characters at least'),
(41, 3, 'PASS_TOO_SHORT', 'يجب أن يحتوي على كلمة المرور ستة أحرف على الأقل'),
(42, 1, 'PASS_DONT_MATCH', 'Les mots de passe doivent correspondre'),
(42, 2, 'PASS_DONT_MATCH', 'The passwords don''t match'),
(42, 3, 'PASS_DONT_MATCH', 'يجب أن تتطابق كلمات المرور'),
(43, 1, 'ACCOUNT_EXISTS', 'Un compte existe déjà avec cette adresse e-mail'),
(43, 2, 'ACCOUNT_EXISTS', 'An account already exists with this e-mail'),
(43, 3, 'ACCOUNT_EXISTS', 'حساب موجود بالفعل مع هذا عنوان البريد الإلكتروني'),
(44, 1, 'ACCOUNT_CREATED', 'Votre compte a bien été créé. Vous allez recevoir un email pour valider votre compte.'),
(44, 2, 'ACCOUNT_CREATED', 'Your account has been created. You will receive an email to confirm your account.'),
(44, 3, 'ACCOUNT_CREATED', 'لقد تم إنشاء حسابك. سوف تتلقى رسالة بريد إلكتروني لتأكيد حسابك.'),
(45, 1, 'INCORRECT_LOGIN', 'Les informations de connexion sont incorrectes.'),
(45, 2, 'INCORRECT_LOGIN', 'Incorrect login information.'),
(45, 3, 'INCORRECT_LOGIN', 'معلومات تسجيل الدخول غير صحيحة.'),
(46, 1, 'I_SIGN_UP', 'Je m''inscris'),
(46, 2, 'I_SIGN_UP', 'I sign up'),
(46, 3, 'I_SIGN_UP', 'يمكنني الاشتراك'),
(47, 1, 'ALREADY_HAVE_ACCOUNT', 'J''ai déjà un compte'),
(47, 2, 'ALREADY_HAVE_ACCOUNT', 'I already have an account'),
(47, 3, 'ALREADY_HAVE_ACCOUNT', 'لدي بالفعل حساب'),
(48, 1, 'MY_ACCOUNT', 'Mon compte'),
(48, 2, 'MY_ACCOUNT', 'My account'),
(48, 3, 'MY_ACCOUNT', 'حسابي'),
(49, 1, 'COMMENTS', 'Commentaires'),
(49, 2, 'COMMENTS', 'Comments'),
(49, 3, 'COMMENTS', 'تعليقات'),
(50, 1, 'LET_US_KNOW', 'Faîtes-nous savoir ce que vous pensez'),
(50, 2, 'LET_US_KNOW', 'Let us know what you think'),
(50, 3, 'LET_US_KNOW', 'ماذا عن رايك؟'),
(51, 1, 'COMMENT_SUCCESS', 'Merci de votre intérêt, votre commentaire va être soumis à validation.'),
(51, 2, 'COMMENT_SUCCESS', 'Thank you for your interest, your comment will be checked.'),
(51, 3, 'COMMENT_SUCCESS', 'شكرا ل اهتمامك، و سيتم التحقق من صحة للتعليق.'),
(52, 1, 'NO_SEARCH_RESULT', 'Aucun résultat. Vérifiez l''orthographe des termes de recherche (> 3 caractères) ou essayez d''autres mots.'),
(52, 2, 'NO_SEARCH_RESULT', 'No result. Check the spelling terms of search (> 3 characters) or try other words.'),
(52, 3, 'NO_SEARCH_RESULT', 'لا نتيجة. التدقيق الإملائي للكلمات (أكثر من ثلاثة أحرف ) أو محاولة بعبارة أخرى .'),
(53, 1, 'SEARCH_EXCEEDED', 'Nombre de recherches dépassé.'),
(53, 2, 'SEARCH_EXCEEDED', 'Number of researches exceeded.'),
(53, 3, 'SEARCH_EXCEEDED', 'عدد من الأبحاث السابقة .'),
(54, 1, 'SECONDS', 'secondes'),
(54, 2, 'SECONDS', 'seconds'),
(54, 3, 'SECONDS', 'ثواني'),
(55, 1, 'FOR_A_TOTAL_OF', 'sur un total de'),
(55, 2, 'FOR_A_TOTAL_OF', 'for a total of'),
(55, 3, 'FOR_A_TOTAL_OF', 'من الكل'),
(56, 1, 'COMMENT', 'Commentaire'),
(56, 2, 'COMMENT', 'Comment'),
(56, 3, 'COMMENT', 'تعقيب'),
(57, 1, 'VIEW', 'Visionner'),
(57, 2, 'VIEW', 'View'),
(57, 3, 'VIEW', 'ل عرض'),
(58, 1, 'RECENT_ARTICLES', 'Articles récents'),
(58, 2, 'RECENT_ARTICLES', 'Recent articles'),
(58, 3, 'RECENT_ARTICLES', 'المقالات الأخيرة'),
(59, 1, 'RSS_FEED', 'Flux RSS'),
(59, 2, 'RSS_FEED', 'RSS feed'),
(59, 3, 'RSS_FEED', 'تغذية RSS'),
(128, 1, 'COOKIES_NOTICE', 'Les cookies nous aident à fournir une meilleure expérience utilisateur. En utilisant notre site, vous acceptez l''utilisation de cookies.'),
(128, 2, 'COOKIES_NOTICE', 'Cookies help us provide better user experience. By using our website, you agree to the use of cookies.'),
(128, 3, 'COOKIES_NOTICE', 'Cookies help us provide better user experience. By using our website, you agree to the use of cookies.');

-- =============== CREATION OF THE TABLE pm_widget ===============

CREATE TABLE IF NOT EXISTS pm_widget(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    title varchar(250),
    showtitle int,
    pos varchar(20),
    allpages int,
    pages varchar(250),
    type varchar(20),
    content longtext,
    class varchar(200),
    checked int DEFAULT 0,
    rank int DEFAULT 0,
    PRIMARY KEY(id, lang)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE pm_widget ADD CONSTRAINT widget_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_widget
--

INSERT INTO pm_widget (id, lang, title, showtitle, pos, allpages, pages, type, content, class, checked, rank) VALUES
(1, 1, 'Qui sommes-nous ?', 1, 'footer', 1, '', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eget auctor ipsum. Mauris pharetra neque a mauris commodo, at aliquam leo malesuada. Maecenas eget elit eu ligula rhoncus dapibus at non erat. In sed velit eget eros gravida consectetur varius imperdiet lectus.</p>\r\n', NULL, 1, 1),
(1, 2, 'About us', 1, 'footer', 1, '', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eget auctor ipsum. Mauris pharetra neque a mauris commodo, at aliquam leo malesuada. Maecenas eget elit eu ligula rhoncus dapibus at non erat. In sed velit eget eros gravida consectetur varius imperdiet lectus.</p>\r\n', NULL, 1, 1),
(1, 3, 'عنا', 1, 'footer', 1, '', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eget auctor ipsum. Mauris pharetra neque a mauris commodo, at aliquam leo malesuada. Maecenas eget elit eu ligula rhoncus dapibus at non erat. In sed velit eget eros gravida consectetur varius imperdiet lectus.</p>\r\n', NULL, 1, 1),
(3, 1, 'Derniers articles', 1, 'footer', 1, '', 'latest_articles', '', '', 1, 2),
(3, 2, 'Latest articles', 1, 'footer', 1, '', 'latest_articles', '', '', 1, 2),
(3, 3, 'المقالات الأخيرة', 1, 'footer', 1, '', 'latest_articles', '', '', 1, 2),
(4, 1, 'Contactez-nous', 0, 'footer', 1, '', 'contact_informations', '', '', 1, 3),
(4, 2, 'Contact us', 0, 'footer', 1, '', 'contact_informations', '', '', 1, 3),
(4, 3, 'اتصل بنا', 0, 'footer', 1, '', 'contact_informations', '', '', 1, 3),
(5, 1, 'Footer form', 0, 'footer', 1, '', 'footer_form', '', 'footer-form mt10', 2, 4),
(5, 2, 'Footer form', 0, 'footer', 1, '', 'footer_form', '', 'footer-form mt10', 2, 4),
(5, 3, 'Footer form', 0, 'footer', 1, '', 'footer_form', '', 'footer-form mt10', 2, 4);

-- ================ CREATION OF THE TABLE pm_article =============

CREATE TABLE IF NOT EXISTS pm_article(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    title varchar(250),
    subtitle varchar(250),
    alias varchar(100),
    text longtext,
    url varchar(250),
    tags varchar(250),
    id_page int,
    id_user int,
    home int DEFAULT 0,
    checked int DEFAULT 0,
    rank int DEFAULT 0,
    add_date int,
    edit_date int,
    publish_date int,
    unpublish_date int,
    comment int DEFAULT 0,
    rating int DEFAULT 0,
    PRIMARY KEY(id, lang)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE pm_article ADD CONSTRAINT article_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE pm_article ADD CONSTRAINT article_page_fkey FOREIGN KEY (id_page, lang) REFERENCES pm_page(id, lang) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_article
--

INSERT INTO pm_article (id, lang, title, subtitle, alias, text, url, tags, id_page, id_user, home, checked, rank, add_date, edit_date, publish_date, unpublish_date, comment, rating) VALUES
(1, 1, 'Plongez dans des eaux inconnues !', '', 'plongee', '', '', '', 5, 1, 1, 1, 1, INSTALL_DATE, INSTALL_DATE, null, null, 1, 0),
(1, 2, 'Dive into unknown waters!', '', 'scuba-diving', '<p>Lorem ipsum dolor sit amet consectetur adipiscing elit. Nullam molestie, nunc eu consequat varius, nisi metus iaculis nulla, nec ornare odio leo quis eros. Donec gravida eget velit eget pulvinar. Phasellus eget est quis est faucibus condimentum. Morbi tellus turpis, posuere vel tincidunt non, varius ac ante. Suspendisse in sem neque. Donec et faucibus justo. Nulla vitae nisl lacus. Fusce tincidunt quam nec vestibulum vestibulum. Vivamus vulputate, nunc non ullamcorper mattis, nunc orci imperdiet nulla, at laoreet ipsum nisl non leo. Aenean dapibus aliquet sem, ut lacinia magna mattis in.</p>\r\n\r\n<p>Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempor arcu eu sapien ullamcorper sodales. Aenean eu massa in ante commodo scelerisque vitae sed sapien. Aenean eu dictum arcu. Mauris ultricies dolor eu molestie egestas.<br />\r\nProin feugiat, nunc at pellentesque fringilla, ex purus efficitur dolor, ac pretium odio lacus id leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse eu ipsum viverra dolor tempus vehicula eu eu risus. Praesent rutrum dapibus odio, nec accumsan justo fermentum in. Ut quis neque a ante facilisis bibendum.</p>\r\n', '', '', 5, 1, 1, 1, 1, INSTALL_DATE, INSTALL_DATE, null, null, 1, 0),
(1, 3, 'Dive into unknown waters!', '', 'scuba-diving', '', '', '', 5, 1, 1, 1, 1, INSTALL_DATE, INSTALL_DATE, null, null, 1, 0),
(4, 1, 'Première gallery', '', 'premiere-gallery', '', '', '', 7, 1, 0, 1, 4, INSTALL_DATE, INSTALL_DATE, null, null, 0, 0),
(4, 2, 'First gallery', '', 'first-gallery', '', '', '', 7, 1, 0, 1, 4, INSTALL_DATE, INSTALL_DATE, null, null, 0, 0),
(4, 3, 'First gallery', '', 'first-gallery', '', '', '', 7, 1, 0, 1, 4, INSTALL_DATE, INSTALL_DATE, null, null, 0, 0);

-- ============= CREATION OF THE TABLE pm_article_file ===========

CREATE TABLE IF NOT EXISTS pm_article_file (
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    id_item int NOT NULL,
    home int DEFAULT 0,
    checked int DEFAULT 1,
    rank int DEFAULT 0,
    file varchar(250),
    label varchar(250),
    type varchar(20),
    PRIMARY KEY(id, lang)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE pm_article_file ADD CONSTRAINT article_file_fkey FOREIGN KEY (id_item, lang) REFERENCES pm_article(id, lang) ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE pm_article_file ADD CONSTRAINT article_file_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_article_file
--

INSERT INTO pm_article_file (id, lang, id_item, home, checked, rank, file, label, type) VALUES
(4, 1, 4, 0, 1, 4, 'sample4.jpg', '', 'image'),
(4, 2, 4, 0, 1, 4, 'sample4.jpg', '', 'image'),
(4, 3, 4, 0, 1, 4, 'sample4.jpg', '', 'image'),
(5, 1, 1, 0, 1, 5, 'diving.jpg', '', 'image'),
(5, 2, 1, 0, 1, 5, 'diving.jpg', '', 'image'),
(5, 3, 1, 0, 1, 5, 'diving.jpg', '', 'image');

-- ================ CREATION OF THE TABLE pm_comment =============

CREATE TABLE IF NOT EXISTS pm_comment (
    id int NOT NULL AUTO_INCREMENT,
    item_type varchar(30),
    id_item int,
    rating int,
    checked int DEFAULT 0,
    add_date int,
    edit_date int,
    name varchar(100),
    email varchar(100),
    msg longtext,
    ip varchar(50),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- ================= CREATION OF THE TABLE pm_tag ================

CREATE TABLE IF NOT EXISTS pm_tag(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    value varchar(250),
    pages varchar(250),
    checked int DEFAULT 0,
    rank int DEFAULT 0,
    PRIMARY KEY(id, lang)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE pm_tag ADD CONSTRAINT tag_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

-- ================= CREATION OF THE TABLE pm_slide ==============

CREATE TABLE IF NOT EXISTS pm_slide(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    legend text,
    url varchar(250),
    id_page int,
    checked int DEFAULT 0,
    rank int DEFAULT 0,
    PRIMARY KEY(id, lang)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE pm_slide ADD CONSTRAINT slide_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE pm_slide ADD CONSTRAINT slide_page_fkey FOREIGN KEY (id_page, lang) REFERENCES pm_page(id, lang) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_slide
--

INSERT INTO pm_slide (id, lang, legend, url, id_page, checked, rank) VALUES
(1, 1, '', '', 1, 1, 2),
(1, 2, '<h1>Book your holydays with Panda Multi Resorts</h1>\r\n\r\n<h2>Fast, Easy and Powerfull</h2>\r\n', '', 1, 1, 2),
(1, 3, '', '', 1, 1, 2),
(2, 1, '', '', 1, 1, 3),
(2, 2, '<h1>A dream stay at the best price</h1>\r\n\r\n<h2>Best price guarantee</h2>\r\n', '', 1, 1, 3),
(2, 3, '', '', 1, 1, 3),
(3, 1, '', '', 1, 1, 1),
(3, 2, '<h1>Find Hotels, Activities and Tours</h1>\r\n\r\n<h2>Your whole vacation starts here</h2>\r\n', '', 1, 1, 1),
(3, 3, '', '', 1, 1, 1);

-- ============== CREATION OF THE TABLE pm_slide_file ============

CREATE TABLE IF NOT EXISTS pm_slide_file (
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    id_item int NOT NULL,
    home int DEFAULT 0,
    checked int DEFAULT 1,
    rank int DEFAULT 0,
    file varchar(250),
    label varchar(250),
    type varchar(20),
    PRIMARY KEY(id, lang)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE pm_slide_file ADD CONSTRAINT slide_file_fkey FOREIGN KEY (id_item, lang) REFERENCES pm_slide(id, lang) ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE pm_slide_file ADD CONSTRAINT slide_file_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_slide_file
--

INSERT INTO pm_slide_file (id, lang, id_item, home, checked, rank, file, label, type) VALUES
(3, 1, 1, 0, 1, 2, 'slide1.jpg', '', 'image'),
(3, 2, 1, 0, 1, 2, 'slide1.jpg', '', 'image'),
(3, 3, 1, 0, 1, 2, 'slide1.jpg', '', 'image'),
(4, 1, 2, 0, 1, 3, 'slide2.jpg', '', 'image'),
(4, 2, 2, 0, 1, 3, 'slide2.jpg', '', 'image'),
(4, 3, 2, 0, 1, 3, 'slide2.jpg', '', 'image'),
(6, 1, 3, 0, 1, 4, 'slide3.jpg', '', 'image'),
(6, 2, 3, 0, 1, 4, 'slide3.jpg', '', 'image'),
(6, 3, 3, 0, 1, 4, 'slide3.jpg', '', 'image');

-- =============== CREATION OF THE TABLE pm_location =============

CREATE TABLE IF NOT EXISTS pm_location(
    id int NOT NULL AUTO_INCREMENT,
    name varchar(100),
    address varchar(250),
    lat double,
    lng double,
    checked int DEFAULT 0,
    pages text,
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

--
-- Content of the table pm_location
--

INSERT INTO pm_location (id, name, address, lat, lng, checked, pages) VALUES
(1, 'Panda Multi Resorts', 'Maldives Mint, Neeloafaru Magu 20014, Maldives', 4.174411, 73.517851, 1, '2');

-- ================ CREATION OF THE TABLE pm_message =============

CREATE TABLE IF NOT EXISTS pm_message (
    id int NOT NULL AUTO_INCREMENT,
    add_date int,
    edit_date int,
    name varchar(100),
    email varchar(100),
    address longtext,
    phone varchar(100),
    subject varchar(250),
    msg longtext,
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- =============== CREATION OF THE TABLE pm_booking ==============

CREATE TABLE pm_booking(
    id int NOT NULL AUTO_INCREMENT,
    id_room int NOT NULL,
    room varchar(100),
    add_date int,
    edit_date int,
    from_date int,
    to_date int,
    nights int DEFAULT 1,
    adults int DEFAULT 1,
    children int DEFAULT 1,
    amount float,
    tourist_tax float,
    total float,
    down_payment float,
    extra_services text,
    firstname varchar(50),
    lastname varchar(50),
    email varchar(100),
    company varchar(50),
    address varchar(250),
    postcode varchar(10),
    city varchar(100),
    phone varchar(50),
    mobile varchar(50),
    country varchar(100) NOT NULL,
    comments text,
    status int DEFAULT 1,
    trans varchar(50),
    payment_date int,
    payment_method varchar(250),
    PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============= CREATION OF THE TABLE pm_destination ============

CREATE TABLE IF NOT EXISTS pm_destination(
    id int NOT NULL AUTO_INCREMENT,
    name varchar(100),
    checked int DEFAULT 0,
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- ================ CREATION OF THE TABLE pm_hotel ===============

CREATE TABLE pm_hotel(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    id_user int,
    title varchar(250),
    subtitle varchar(250),
    alias varchar(100),
    address varchar(250),
    lat double,
    lng double,
    email varchar(100),
    phone varchar(50),
    web varchar(250),
    descr longtext,
    facilities varchar(250),
    id_destination int,
    home int DEFAULT 0,
    checked int DEFAULT 0,
    rank int DEFAULT 0,
    PRIMARY KEY(id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE pm_hotel ADD CONSTRAINT hotel_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_hotel
--

INSERT INTO pm_hotel (id, lang, id_user, title, subtitle, alias, address, lat, lng, email, phone, web, descr, facilities, home, checked, rank) VALUES
(1, 1, 1, 'Royal Hotel', 'Hôtel luxueux avec vue sur la mer', 'royal-hotel', '', 4.455734, 73.718185, 'contact@pandao.eu', '+30 1 0xxx xxxx', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean aliquet felis massa, sed condimentum ligula feugiat et. Etiam facilisis euismod dignissim. Vivamus facilisis lorem ut purus pellentesque, nec sollicitudin lorem suscipit. Fusce sed enim ultricies, venenatis nunc ut, pharetra nunc. Quisque sollicitudin egestas varius. Nulla aliquet magna sapien, id malesuada felis lobortis id. Vivamus vulputate sed enim sit amet eleifend. Vivamus sit amet felis id urna vulputate maximus. Nullam fringilla sed turpis non volutpat. Cras ultrices diam velit, ac volutpat odio semper at. Sed pulvinar turpis imperdiet sapien hendrerit pulvinar.</p>\r\n', '1,11,20,37,32', 1, 1, 1),
(1, 2, 1, 'Royal Hotel', 'Luxury hotel overlooking the sea', 'royal-hotel', '', 4.455734, 73.718185, 'contact@pandao.eu', '+30 1 0xxx xxxx', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean aliquet felis massa, sed condimentum ligula feugiat et. Etiam facilisis euismod dignissim. Vivamus facilisis lorem ut purus pellentesque, nec sollicitudin lorem suscipit. Fusce sed enim ultricies, venenatis nunc ut, pharetra nunc. Quisque sollicitudin egestas varius. Nulla aliquet magna sapien, id malesuada felis lobortis id. Vivamus vulputate sed enim sit amet eleifend. Vivamus sit amet felis id urna vulputate maximus. Nullam fringilla sed turpis non volutpat. Cras ultrices diam velit, ac volutpat odio semper at. Sed pulvinar turpis imperdiet sapien hendrerit pulvinar.</p>\r\n', '1,11,20,37,32', 1, 1, 1),
(1, 3, 1, 'Royal Hotel', 'فندق فخم يطل على البحر', 'royal-hotel', '', 4.455734, 73.718185, 'contact@pandao.eu', '+30 1 0xxx xxxx', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean aliquet felis massa, sed condimentum ligula feugiat et. Etiam facilisis euismod dignissim. Vivamus facilisis lorem ut purus pellentesque, nec sollicitudin lorem suscipit. Fusce sed enim ultricies, venenatis nunc ut, pharetra nunc. Quisque sollicitudin egestas varius. Nulla aliquet magna sapien, id malesuada felis lobortis id. Vivamus vulputate sed enim sit amet eleifend. Vivamus sit amet felis id urna vulputate maximus. Nullam fringilla sed turpis non volutpat. Cras ultrices diam velit, ac volutpat odio semper at. Sed pulvinar turpis imperdiet sapien hendrerit pulvinar.</p>\r\n', '1,11,20,37,32', 1, 1, 1);

-- ============== CREATION OF THE TABLE pm_hotel_file =============

CREATE TABLE pm_hotel_file(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    id_item int NOT NULL,
    home int DEFAULT 0,
    checked int DEFAULT 1,
    rank int DEFAULT 0,
    file varchar(250),
    label varchar(250),
    type varchar(20),
    PRIMARY KEY(id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE pm_hotel_file ADD CONSTRAINT hotel_file_fkey FOREIGN KEY (id_item, lang) REFERENCES pm_hotel(id, lang) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE pm_hotel_file ADD CONSTRAINT hotel_file_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_hotel_file
--

INSERT INTO pm_hotel_file (id, lang, id_item, home, checked, rank, file, label, type) VALUES
(1, 1, 1, 0, 1, 1, '5555048217-1389b680d6-o.jpg', '', 'image'),
(1, 2, 1, 0, 1, 1, '5555048217-1389b680d6-o.jpg', '', 'image'),
(1, 3, 1, 0, 1, 1, '5555048217-1389b680d6-o.jpg', '', 'image');

-- ================= CREATION OF THE TABLE pm_room ===============

CREATE TABLE pm_room(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    id_hotel int NOT NULL,
    id_user int,
    max_children int DEFAULT 1,
    max_adults int DEFAULT 1,
    max_people int,
    min_people int,
    title varchar(250),
    subtitle varchar(250),
    alias varchar(100),
    descr longtext,
    facilities text,
    stock int DEFAULT 1,
    price double DEFAULT 0,
    home int DEFAULT 0,
    checked int DEFAULT 0,
    rank int DEFAULT 0,
    start_lock int,
    end_lock int,
    PRIMARY KEY(id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE pm_room ADD CONSTRAINT room_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE pm_room ADD CONSTRAINT room_hotel_fkey FOREIGN KEY (id_hotel, lang) REFERENCES pm_hotel(id, lang) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_room
--

INSERT INTO pm_room (id, lang, id_hotel, id_user, max_children, max_adults, max_people, min_people, title, subtitle, alias, descr, facilities, stock, price, home, checked, rank, start_lock, end_lock) VALUES
(1, 1, 1, 1, 2, 2, 2, 1, 'Chambre Double Deluxe', 'Petit-déjeuner inclus', 'chambre-double-deluxe', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ut eleifend diam. Etiam molestie quam at nunc tempus, ac porttitor ante rutrum. Donec ipsum orci, molestie sit amet nibh a, accumsan varius nisl. Suspendisse blandit efficitur interdum. Nulla auctor tortor eu volutpat imperdiet. Nam at tempus sapien, sit amet porttitor neque. Nam lacinia ex libero, vel egestas ante vehicula nec.</p>\r\n\r\n<p>Sed sed dignissim est. Donec egestas nisl eu congue rhoncus. Nulla finibus malesuada mauris, et pellentesque diam scelerisque non. Duis auctor dapibus augue sed malesuada. Nam placerat at libero quis aliquam. Phasellus quam orci, dapibus sit amet finibus a, convallis volutpat arcu. Nullam condimentum quam id urna scelerisque varius. Duis a metus metus.</p>\r\n', '1,5,11,13,17,18,21,23,24,25,27,28,29,32', 4, 145, 1, 1, 1, NULL, NULL),
(1, 2, 1, 1, 2, 2, 2, 1, 'Deluxe Double Bedroom', 'Breakfast included', 'deluxe-double-bedroom', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ut eleifend diam. Etiam molestie quam at nunc tempus, ac porttitor ante rutrum. Donec ipsum orci, molestie sit amet nibh a, accumsan varius nisl. Suspendisse blandit efficitur interdum. Nulla auctor tortor eu volutpat imperdiet. Nam at tempus sapien, sit amet porttitor neque. Nam lacinia ex libero, vel egestas ante vehicula nec.</p>\r\n\r\n<p>Sed sed dignissim est. Donec egestas nisl eu congue rhoncus. Nulla finibus malesuada mauris, et pellentesque diam scelerisque non. Duis auctor dapibus augue sed malesuada. Nam placerat at libero quis aliquam. Phasellus quam orci, dapibus sit amet finibus a, convallis volutpat arcu. Nullam condimentum quam id urna scelerisque varius. Duis a metus metus.</p>\r\n', '1,5,11,13,17,18,21,23,24,25,27,28,29,32', 4, 145, 1, 1, 1, NULL, NULL),
(1, 3, 1, 1, 2, 2, 2, 1, 'Deluxe Double Bedroom', 'Breakfast included', 'deluxe-double-bedroom', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ut eleifend diam. Etiam molestie quam at nunc tempus, ac porttitor ante rutrum. Donec ipsum orci, molestie sit amet nibh a, accumsan varius nisl. Suspendisse blandit efficitur interdum. Nulla auctor tortor eu volutpat imperdiet. Nam at tempus sapien, sit amet porttitor neque. Nam lacinia ex libero, vel egestas ante vehicula nec.</p>\r\n\r\n<p>Sed sed dignissim est. Donec egestas nisl eu congue rhoncus. Nulla finibus malesuada mauris, et pellentesque diam scelerisque non. Duis auctor dapibus augue sed malesuada. Nam placerat at libero quis aliquam. Phasellus quam orci, dapibus sit amet finibus a, convallis volutpat arcu. Nullam condimentum quam id urna scelerisque varius. Duis a metus metus.</p>\r\n', '1,5,11,13,17,18,21,23,24,25,27,28,29,32', 4, 145, 1, 1, 1, NULL, NULL);

-- ============== CREATION OF THE TABLE pm_room_file =============

CREATE TABLE pm_room_file(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    id_item int NOT NULL,
    home int DEFAULT 0,
    checked int DEFAULT 1,
    rank int DEFAULT 0,
    file varchar(250),
    label varchar(250),
    type varchar(20),
    PRIMARY KEY(id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE pm_room_file ADD CONSTRAINT room_file_fkey FOREIGN KEY (id_item, lang) REFERENCES pm_room(id, lang) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE pm_room_file ADD CONSTRAINT room_file_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_room_file
--

INSERT INTO pm_room_file (id, lang, id_item, home, checked, rank, file, label, type) VALUES
(1, 1, 1, 0, 1, 1, 'deluxe-double-room.jpg', '', 'image'),
(1, 2, 1, 0, 1, 1, 'deluxe-double-room.jpg', '', 'image'),
(1, 3, 1, 0, 1, 1, 'deluxe-double-room.jpg', '', 'image');

-- =============== CREATION OF THE TABLE pm_facility =============

CREATE TABLE pm_facility(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    name varchar(250),
    rank int DEFAULT 0,
    PRIMARY KEY(id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

ALTER TABLE pm_facility ADD CONSTRAINT facility_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_facility
--

INSERT INTO pm_facility (id, lang, name, rank) VALUES
(1, 1, 'Climatisation', 1),
(1, 2, 'Air conditioning', 1),
(2, 1, 'Lit bébé', 2),
(2, 2, 'Baby cot', 2),
(3, 1, 'Balcon', 3),
(3, 2, 'Balcony', 3),
(4, 1, 'Barbecue', 4),
(4, 2, 'Barbecue', 4),
(5, 1, 'Salle de bain', 5),
(5, 2, 'Bathroom', 5),
(6, 1, 'Cafetière', 6),
(6, 2, 'Coffeemaker', 6),
(7, 1, 'Plaque de cuisson', 7),
(7, 2, 'Cooktop', 7),
(8, 1, 'Bureau', 8),
(8, 2, 'Desk', 8),
(9, 1, 'Lave vaisselle', 9),
(9, 2, 'Dishwasher', 9),
(10, 1, 'Ventilateur', 10),
(10, 2, 'Fan', 10),
(11, 1, 'Parking gratuit', 11),
(11, 2, 'Free parking', 11),
(12, 1, 'Réfrigérateur', 12),
(12, 2, 'Fridge', 12),
(13, 1, 'Sèche-cheveux', 13),
(13, 2, 'Hairdryer', 13),
(14, 1, 'Internet', 14),
(14, 2, 'Internet', 14),
(15, 1, 'Fer à repasser', 15),
(15, 2, 'Iron', 15),
(16, 1, 'Micro-ondes', 16),
(16, 2, 'Microwave', 16),
(17, 1, 'Mini-bar', 17),
(17, 2, 'Mini-bar', 17),
(18, 1, 'Non-fumeurs', 18),
(18, 2, 'Non-smoking', 18),
(19, 1, 'Parking payant', 19),
(19, 2, 'Paid parking', 19),
(20, 1, 'Animaux acceptés', 20),
(20, 2, 'Pets allowed', 20),
(21, 1, 'Animaux interdits', 21),
(21, 2, 'Pets not allowed', 21),
(22, 1, 'Radio', 22),
(22, 2, 'Radio', 22),
(23, 1, 'Coffre-fort', 23),
(23, 2, 'Safe', 23),
(24, 1, 'Chaines satellite', 24),
(24, 2, 'Satellite chanels', 24),
(25, 1, 'Salle d''eau', 25),
(25, 2, 'Shower-room', 25),
(26, 1, 'Coin salon', 26),
(26, 2, 'Small lounge', 26),
(27, 1, 'Telephone', 27),
(27, 2, 'Telephone', 27),
(28, 1, 'Téléviseur', 28),
(28, 2, 'Television', 28),
(29, 1, 'Terrasse', 29),
(29, 2, 'Terrasse', 29),
(30, 1, 'Machine à laver', 30),
(30, 2, 'Washing machine', 30),
(31, 1, 'Accès handicapés', 31),
(31, 2, 'Wheelchair accessible', 31),
(32, 1, 'Wi-Fi', 31),
(32, 2, 'WiFi', 31),
(33, 1, 'Chaine hifi', 32),
(33, 2, 'Hi-fi system', 32),
(34, 1, 'Lecteur DVD', 33),
(34, 2, 'DVD player', 33),
(35, 1, 'Ascenceur', 34),
(35, 2, 'Elevator', 34),
(36, 1, 'Coin salon', 35),
(36, 2, 'Lounge', 35),
(37, 1, 'Restaurant', 36),
(37, 2, 'Restaurant', 36),
(38, 1, 'Service de chambre', 37),
(38, 2, 'Room service', 37),
(39, 1, 'Vestiaire', 38),
(39, 2, 'Cloakroom', 38);

-- ============ CREATION OF THE TABLE pm_facility_file ===========

CREATE TABLE pm_facility_file(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    id_item int NOT NULL,
    home int DEFAULT 0,
    checked int DEFAULT 1,
    rank int DEFAULT 0,
    file varchar(250),
    label varchar(250),
    type varchar(20),
    PRIMARY KEY(id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=35;

ALTER TABLE pm_facility_file ADD CONSTRAINT facility_file_fkey FOREIGN KEY (id_item, lang) REFERENCES pm_facility(id, lang) ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE pm_facility_file ADD CONSTRAINT facility_file_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_facility_file
--

INSERT INTO pm_facility_file (id, lang, id_item, home, checked, rank, file, label, type) VALUES
(1, 2, 31, 0, 1, 1, 'wheelchair.png', '', 'image'),
(2, 2, 20, 0, 1, 2, 'pet-allowed.png', '', 'image'),
(3, 2, 21, 0, 1, 3, 'pet-not-allowed.png', '', 'image'),
(4, 2, 3, 0, 1, 4, 'balcony.png', '', 'image'),
(5, 2, 4, 0, 1, 5, 'barbecue.png', '', 'image'),
(6, 2, 8, 0, 1, 6, 'desk.png', '', 'image'),
(7, 2, 6, 0, 1, 7, 'coffee.png', '', 'image'),
(8, 2, 24, 0, 1, 8, 'satellite.png', '', 'image'),
(9, 2, 1, 0, 1, 9, 'air-conditioning.png', '', 'image'),
(10, 2, 23, 0, 1, 10, 'safe.png', '', 'image'),
(11, 2, 26, 0, 1, 11, 'lounge.png', '', 'image'),
(12, 2, 15, 0, 1, 12, 'iron.png', '', 'image'),
(13, 2, 14, 0, 1, 13, 'adsl.png', '', 'image'),
(14, 2, 9, 0, 1, 14, 'dishwasher.png', '', 'image'),
(15, 2, 2, 0, 1, 15, 'baby-cot.png', '', 'image'),
(16, 2, 30, 0, 1, 16, 'washing-machine.png', '', 'image'),
(17, 2, 16, 0, 1, 17, 'microwaves.png', '', 'image'),
(18, 2, 17, 0, 1, 18, 'mini-bar.png', '', 'image'),
(19, 2, 18, 0, 1, 19, 'non-smoking.png', '', 'image'),
(20, 2, 11, 0, 1, 20, 'free-parking.png', '', 'image'),
(21, 2, 19, 0, 1, 21, 'paid-parking.png', '', 'image'),
(22, 2, 7, 0, 1, 22, 'cooktop.png', '', 'image'),
(23, 2, 22, 0, 1, 23, 'radio.png', '', 'image'),
(24, 2, 12, 0, 1, 24, 'fridge.png', '', 'image'),
(25, 2, 25, 0, 1, 25, 'shower.png', '', 'image'),
(26, 2, 5, 0, 1, 26, 'bath.png', '', 'image'),
(27, 2, 13, 0, 1, 27, 'hairdryer.png', '', 'image'),
(28, 2, 27, 0, 1, 28, 'phone.png', '', 'image'),
(29, 2, 28, 0, 1, 29, 'tv.png', '', 'image'),
(30, 2, 29, 0, 1, 30, 'terrasse.png', '', 'image'),
(31, 2, 10, 0, 1, 31, 'fan.png', '', 'image'),
(32, 2, 32, 0, 1, 32, 'wifi.png', '', 'image'),
(33, 2, 33, 0, 1, 33, 'hifi.png', '', 'image'),
(34, 2, 34, 0, 1, 34, 'dvd.png', '', 'image'),
(35, 2, 33, 0, 1, 33, 'elevator.png', '', 'image'),
(36, 2, 33, 0, 1, 33, 'lounge.png', '', 'image'),
(37, 2, 33, 0, 1, 33, 'restaurant.png', '', 'image'),
(38, 2, 33, 0, 1, 33, 'room-service.png', '', 'image'),
(39, 2, 33, 0, 1, 33, 'cloakroom.png', '', 'image');

-- ================= CREATION OF THE TABLE pm_rate ===============

CREATE TABLE pm_rate(
    id int NOT NULL AUTO_INCREMENT,
    id_room int NOT NULL,
    id_user int,
    start_date int,
    end_date int,
    type varchar(50),
    price double DEFAULT 0,
    child_price double DEFAULT 0,
    discount double DEFAULT 0,
    people int,
    price_sup double,
    fixed_sup double,
    min_stay int,
    vat_rate double,
    day_start int,
    day_end int,
    PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE pm_rate ADD CONSTRAINT rate_room_fkey FOREIGN KEY (id_room) REFERENCES pm_room(id) ON DELETE CASCADE ON UPDATE NO ACTION;

-- =============== CREATION OF THE TABLE pm_service ==============

CREATE TABLE pm_service(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    id_user int,
    title varchar(250),
    descr text,
    long_descr text,
    type varchar(50),
    rooms varchar(250),
    price double,
    vat_rate double,
    checked int DEFAULT 0,
    rank int DEFAULT 0,
    PRIMARY KEY(id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=5;

ALTER TABLE pm_service ADD CONSTRAINT service_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_service
--

INSERT INTO pm_service (id, lang, id_user, title, descr, long_descr, type, rooms, price, vat_rate, checked, rank) VALUES
(1, 1, 1, 'Set de toilette', '1 serviette de toilette, 1 drap de douche, 1 tapis', '', 'qty-night', '4,1,3,2', 7, 10, 1, 1),
(1, 2, 1, 'Rent of towel (kit)', '1 hand towel, 1 bath towel, 1 bath mat', '', 'qty-night', '4,1,3,2', 7, 10, 1, 1),
(1, 3, 1, 'Rent of towel (kit)', '1 hand towel, 1 bath towel, 1 bath mat', '', 'qty-night', '4,1,3,2', 7, 10, 1, 1),
(2, 1, 1, 'Ménage', '', '', 'package', '1,3,2', 50, 10, 1, 2),
(2, 2, 1, 'Housework', '', '', 'package', '1,3,2', 50, 10, 1, 2),
(2, 3, 1, 'Housework', '', '', 'package', '1,3,2', 50, 10, 1, 2),
(3, 1, 1, 'Chauffage', '', '', 'night', '1,3,2', 8, 10, 1, 3),
(3, 2, 1, 'Heating', '', '', 'night', '1,3,2', 8, 10, 1, 3),
(3, 3, 1, 'Heating', '', '', 'night', '1,3,2', 8, 10, 1, 3),
(4, 1, 1, 'Animal domestique', 'Précisez la race ci-dessous', '', 'qty-night', '4,1,3,2', 5, 10, 1, 4),
(4, 2, 1, 'Pet', 'Specify the breed below', '', 'qty-night', '4,1,3,2', 5, 10, 1, 4),
(4, 3, 1, 'Pet', 'Specify the breed below', '', 'qty-night', '4,1,3,2', 5, 10, 1, 4);

-- =============== CREATION OF THE TABLE pm_activity =============

CREATE TABLE pm_activity(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    hotels varchar(250),
    id_user int,
    max_children int DEFAULT 1,
    max_adults int DEFAULT 1,
    max_people int,
    title varchar(250),
    subtitle varchar(250),
    alias varchar(100),
    descr longtext,
    duration float DEFAULT 0,
    duration_unit varchar(50),
    price double DEFAULT 0,
    lat double,
    lng double,
    home int DEFAULT 0,
    checked int DEFAULT 0,
    rank int DEFAULT 0,
    PRIMARY KEY(id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE pm_activity ADD CONSTRAINT activity_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

-- ============ CREATION OF THE TABLE pm_activity_file ===========

CREATE TABLE pm_activity_file(
    id int NOT NULL AUTO_INCREMENT,
    lang int NOT NULL,
    id_item int NOT NULL,
    home int DEFAULT 0,
    checked int DEFAULT 1,
    rank int DEFAULT 0,
    file varchar(250),
    label varchar(250),
    type varchar(20),
    PRIMARY KEY(id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE pm_activity_file ADD CONSTRAINT activity_file_fkey FOREIGN KEY (id_item, lang) REFERENCES pm_activity(id, lang) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE pm_activity_file ADD CONSTRAINT activity_file_lang_fkey FOREIGN KEY (lang) REFERENCES pm_lang(id) ON DELETE CASCADE ON UPDATE NO ACTION;

-- ========== CREATION OF THE TABLE pm_activity_session ==========

CREATE TABLE pm_activity_session(
    id int NOT NULL AUTO_INCREMENT,
    id_activity int NOT NULL,
    days varchar(20),
    start_date int,
    end_date int,
    id_user int,
    price double DEFAULT 0,
    price_child double DEFAULT 0,
    discount double DEFAULT 0,
    vat_rate double,
    PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE pm_activity_session ADD CONSTRAINT activity_session_fkey FOREIGN KEY (id_activity) REFERENCES pm_activity(id) ON DELETE CASCADE ON UPDATE NO ACTION;

-- ======= CREATION OF THE TABLE pm_activity_session_hour ========

CREATE TABLE pm_activity_session_hour(
    id int NOT NULL AUTO_INCREMENT,
    id_activity_session int NOT NULL,
    start_h int,
    start_m int,
    PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE pm_activity_session_hour ADD CONSTRAINT activity_session_hour_fkey FOREIGN KEY (id_activity_session) REFERENCES pm_activity_session(id) ON DELETE CASCADE ON UPDATE NO ACTION;

-- ========== CREATION OF THE TABLE pm_booking_activity ==========

CREATE TABLE pm_booking_activity(
    id int NOT NULL AUTO_INCREMENT,
    id_booking int NOT NULL,
    id_activity int NOT NULL,
    title varchar(250),
    children int DEFAULT 0,
    adults int DEFAULT 0,
    duration varchar(50),
    amount double DEFAULT 0,
    date int,
    PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE pm_booking_activity ADD CONSTRAINT booking_activity_fkey FOREIGN KEY (id_booking) REFERENCES pm_booking(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Content of the table pm_text
--

INSERT INTO pm_text (id, lang, name, value) VALUES
(60, 1, 'COUNTRY', 'Pays'),
(60, 2, 'COUNTRY', 'Country'),
(60, 3, 'COUNTRY', 'Country'),
(61, 1, 'ROOM', 'Chambre'),
(61, 2, 'ROOM', 'Room'),
(61, 3, 'ROOM', 'Room'),
(62, 1, 'INCL_VAT', 'TTC'),
(62, 2, 'INCL_VAT', 'incl. VAT'),
(62, 3, 'INCL_VAT', 'incl. VAT'),
(63, 1, 'NIGHTS', 'nuit(s)'),
(63, 2, 'NIGHTS', 'night(s)'),
(63, 3, 'NIGHTS', 'night(s)'),
(64, 1, 'ADULTS', 'Adultes'),
(64, 2, 'ADULTS', 'Adults'),
(64, 3, 'ADULTS', 'Adults'),
(65, 1, 'CHILDREN', 'Enfants'),
(65, 2, 'CHILDREN', 'Children'),
(65, 3, 'CHILDREN', 'Children'),
(66, 1, 'PERSONS', 'personne(s)'),
(66, 2, 'PERSONS', 'person(s)'),
(66, 3, 'PERSONS', 'person(s)'),
(67, 1, 'CONTACT_DETAILS', 'Coordonnées'),
(67, 2, 'CONTACT_DETAILS', 'Contact details'),
(67, 3, 'CONTACT_DETAILS', 'Contact details'),
(68, 1, 'NO_AVAILABILITY', 'Aucune disponibilité'),
(68, 2, 'NO_AVAILABILITY', 'No availability'),
(68, 3, 'NO_AVAILABILITY', 'No availability'),
(69, 1, 'AVAILABILITIES', 'Disponibilités'),
(69, 2, 'AVAILABILITIES', 'Availabilities'),
(69, 3, 'AVAILABILITIES', 'Availabilities'),
(70, 1, 'CHECK', 'Vérifier'),
(70, 2, 'CHECK', 'Check'),
(70, 3, 'CHECK', 'Check'),
(71, 1, 'BOOKING_DETAILS', 'Détails de la réservation'),
(71, 2, 'BOOKING_DETAILS', 'Booking details'),
(71, 3, 'BOOKING_DETAILS', 'Booking details'),
(72, 1, 'SPECIAL_REQUESTS', 'Demandes spéciales'),
(72, 2, 'SPECIAL_REQUESTS', 'Special requests'),
(72, 3, 'SPECIAL_REQUESTS', 'Special requests'),
(73, 1, 'PREVIOUS_STEP', 'Étape précédente'),
(73, 2, 'PREVIOUS_STEP', 'Previous step'),
(73, 3, 'PREVIOUS_STEP', 'Previous step'),
(74, 1, 'CONFIRM_BOOKING', 'Confirmer la réservation'),
(74, 2, 'CONFIRM_BOOKING', 'Confirm the booking'),
(74, 3, 'CONFIRM_BOOKING', 'Confirm the booking'),
(75, 1, 'ALSO_DISCOVER', 'Découvrez aussi'),
(75, 2, 'ALSO_DISCOVER', 'Also discover'),
(75, 3, 'ALSO_DISCOVER', 'Also discover'),
(76, 1, 'CHECK_PEOPLE', 'Merci de vérifier le nombre de personnes pour l''hébergement choisi.'),
(76, 2, 'CHECK_PEOPLE', 'Please verify the number of people for the chosen accommodation'),
(76, 3, 'CHECK_PEOPLE', 'Please verify the number of people for the chosen accommodation'),
(77, 1, 'BOOKING', 'Réservation'),
(77, 2, 'BOOKING', 'Booking'),
(77, 3, 'BOOKING', 'Booking'),
(78, 1, 'NIGHT', 'nuit'),
(78, 2, 'NIGHT', 'night'),
(78, 3, 'NIGHT', 'night'),
(79, 1, 'WEEK', 'semaine'),
(79, 2, 'WEEK', 'week'),
(79, 3, 'WEEK', 'week'),
(80, 1, 'EXTRA_SERVICES', 'Services supplémentaires'),
(80, 2, 'EXTRA_SERVICES', 'Extra services'),
(80, 3, 'EXTRA_SERVICES', 'Extra services'),
(81, 1, 'BOOKING_TERMS', ''),
(81, 2, 'BOOKING_TERMS', ''),
(81, 3, 'BOOKING_TERMS', ''),
(82, 1, 'NEXT_STEP', 'Étape suivante'),
(82, 2, 'NEXT_STEP', 'Next step'),
(82, 3, 'NEXT_STEP', 'Next step'),
(83, 1, 'TOURIST_TAX', 'Taxe de séjour'),
(83, 2, 'TOURIST_TAX', 'Tourist tax'),
(83, 3, 'TOURIST_TAX', 'Tourist tax'),
(84, 1, 'CHECK_IN', 'Arrivée'),
(84, 2, 'CHECK_IN', 'Check in'),
(84, 3, 'CHECK_IN', 'Check in'),
(85, 1, 'CHECK_OUT', 'Départ'),
(85, 2, 'CHECK_OUT', 'Check out'),
(85, 3, 'CHECK_OUT', 'Check out'),
(86, 1, 'TOTAL', 'Total'),
(86, 2, 'TOTAL', 'Total'),
(86, 3, 'TOTAL', 'Total'),
(87, 1, 'CAPACITY', 'Capacité'),
(87, 2, 'CAPACITY', 'Capacity'),
(87, 3, 'CAPACITY', 'Capacity'),
(88, 1, 'FACILITIES', 'Équipements'),
(88, 2, 'FACILITIES', 'Facilities'),
(88, 3, 'FACILITIES', 'Facilities'),
(89, 1, 'PRICE', 'Prix'),
(89, 2, 'PRICE', 'Price'),
(89, 3, 'PRICE', 'Price'),
(90, 1, 'MORE_DETAILS', 'Plus d''infos'),
(90, 2, 'MORE_DETAILS', 'More details'),
(90, 3, 'MORE_DETAILS', 'More details'),
(91, 1, 'FROM_PRICE', 'À partir de'),
(91, 2, 'FROM_PRICE', 'From'),
(91, 3, 'FROM_PRICE', 'From'),
(92, 1, 'AMOUNT', 'Montant'),
(92, 2, 'AMOUNT', 'Amount'),
(92, 3, 'AMOUNT', 'Amount'),
(93, 1, 'PAY', 'Payer'),
(93, 2, 'PAY', 'Check out'),
(93, 3, 'PAY', 'Check out'),
(94, 1, 'PAYMENT_PAYPAL_NOTICE', 'Cliquez sur "Payer" ci-dessous, vous allez être redirigé vers le site sécurisé de PayPal'),
(94, 2, 'PAYMENT_PAYPAL_NOTICE', 'Click on "Check Out" below, you will be redirected towards the secure site of PayPal'),
(94, 3, 'PAYMENT_PAYPAL_NOTICE', 'Click on "Check Out" below, you will be redirected towards the secure site of PayPal'),
(95, 1, 'PAYMENT_CANCEL_NOTICE', 'Le paiement a été annulé.<br>Merci de votre visite et à bientôt.'),
(95, 2, 'PAYMENT_CANCEL_NOTICE', 'The payment has been cancelled.<br>Thank you for your visit and see you soon.'),
(95, 3, 'PAYMENT_CANCEL_NOTICE', 'The payment has been cancelled.<br>Thank you for your visit and see you soon.'),
(96, 1, 'PAYMENT_SUCCESS_NOTICE', 'Le paiement a été réalisé avec succès.<br>Merci de votre visite et à bientôt !'),
(96, 2, 'PAYMENT_SUCCESS_NOTICE', 'Your payment has been successfully processed.<br>Thank you for your visit and see you soon!'),
(96, 3, 'PAYMENT_SUCCESS_NOTICE', 'Your payment has been successfully processed.<br>Thank you for your visit and see you soon!'),
(97, 1, 'BILLING_ADDRESS', 'Adresse de facturation'),
(97, 2, 'BILLING_ADDRESS', 'Billing address'),
(97, 3, 'BILLING_ADDRESS', 'Billing address'),
(98, 1, 'DOWN_PAYMENT', 'Acompte'),
(98, 2, 'DOWN_PAYMENT', 'Down payment'),
(98, 3, 'DOWN_PAYMENT', 'Down payment'),
(99, 1, 'PAYMENT_CHECK_NOTICE', 'Merci d''envoyer un chèque à "Panda Multi Resorts, Neeloafaru Magu, Maldives" d''un montant de {amount}.<br>Votre réservation sera validée à réception du paiement.<br>Merci de votre visite et à bientôt !'),
(99, 2, 'PAYMENT_CHECK_NOTICE', 'Thank you for sending a check of {amount} to "Panda Multi Resorts, Neeloafaru Magu, Maldives".<br>Your reservation will be confirmed upon receipt of the payment.<br>Thank you for your visit and see you soon!'),
(99, 3, 'PAYMENT_CHECK_NOTICE', 'Thank you for sending a check of {amount} to "Panda Multi Resorts, Neeloafaru Magu, Maldives".<br>Your reservation will be confirmed upon receipt of the payment.<br>Thank you for your visit and see you soon!'),
(100, 1, 'PAYMENT_ARRIVAL_NOTICE', 'Veuillez régler le solde de votre réservation d''un montant de {amount} à votre arrivée.<br>Merci de votre visite et à bientôt !'),
(100, 2, 'PAYMENT_ARRIVAL_NOTICE', 'Thank you for paying the balance of {amount} for your booking on your arrival.<br>Thank you for your visit and see you soon!'),
(100, 3, 'PAYMENT_ARRIVAL_NOTICE', 'Thank you for paying the balance of {amount} for your booking on your arrival.<br>Thank you for your visit and see you soon!'),
(101, 1, 'MAX_PEOPLE', 'Pers. max'),
(101, 2, 'MAX_PEOPLE', 'Max people'),
(101, 3, 'MAX_PEOPLE', 'Max people'),
(102, 1, 'VAT_AMOUNT', 'Dont TVA'),
(102, 2, 'VAT_AMOUNT', 'VAT amount'),
(102, 3, 'VAT_AMOUNT', 'VAT amount'),
(103, 1, 'MIN_NIGHTS', 'Nuits min'),
(103, 2, 'MIN_NIGHTS', 'Min nights'),
(103, 3, 'MIN_NIGHTS', 'Min nights'),
(104, 1, 'ROOMS', 'Chambres'),
(104, 2, 'ROOMS', 'Rooms'),
(104, 3, 'ROOMS', 'Rooms'),
(105, 1, 'RATINGS', 'Note(s)'),
(105, 2, 'RATINGS', 'Rating(s)'),
(105, 3, 'RATINGS', 'Rating(s)'),
(106, 1, 'MIN_PEOPLE', 'Pers. min'),
(106, 2, 'MIN_PEOPLE', 'Min people'),
(106, 3, 'MIN_PEOPLE', 'Min people'),
(107, 1, 'HOTEL', 'Hôtel'),
(107, 2, 'HOTEL', 'Hotel'),
(107, 3, 'HOTEL', 'Hotel'),
(108, 1, 'MAKE_A_REQUEST', 'Faire une demande'),
(108, 2, 'MAKE_A_REQUEST', 'Make a request'),
(108, 3, 'MAKE_A_REQUEST', 'Make a request'),
(109, 1, 'FULLNAME', 'Nom complet'),
(109, 2, 'FULLNAME', 'Full Name'),
(109, 3, 'FULLNAME', 'Full Name'),
(110, 1, 'PASSWORD', 'Mot de passe'),
(110, 2, 'PASSWORD', 'Password'),
(110, 3, 'PASSWORD', 'Password'),
(111, 1, 'LOG_IN_WITH_FACEBOOK', 'Enregistrez-vous avec Facebook'),
(111, 2, 'LOG_IN_WITH_FACEBOOK', 'Log in with Facebook'),
(111, 3, 'LOG_IN_WITH_FACEBOOK', 'Log in with Facebook'),
(112, 1, 'OR', 'Ou'),
(112, 2, 'OR', 'Or'),
(112, 3, 'OR', 'Or'),
(113, 1, 'NEW_PASSWORD', 'Nouveau mot de passe'),
(113, 2, 'NEW_PASSWORD', 'New password'),
(113, 3, 'NEW_PASSWORD', 'New password'),
(114, 1, 'NEW_PASSWORD_NOTICE', 'Merci d''entrer l''adresse e-mail correspondant à votre compte. Un nouveau mot de passe vous sera envoyé par e-mail.'),
(114, 2, 'NEW_PASSWORD_NOTICE', 'Please enter your e-mail address corresponding to your account. A new password will be sent to you by e-mail.'),
(114, 3, 'NEW_PASSWORD_NOTICE', 'Please enter your e-mail address corresponding to your account. A new password will be sent to you by e-mail.'),
(115, 1, 'USERNAME', 'Utilisateur'),
(115, 2, 'USERNAME', 'Username'),
(115, 3, 'USERNAME', 'Username'),
(116, 1, 'PASSWORD_CONFIRM', 'Confirmer mot de passe'),
(116, 2, 'PASSWORD_CONFIRM', 'Confirm password'),
(116, 3, 'PASSWORD_CONFIRM', 'Confirm password'),
(117, 1, 'USERNAME_EXISTS', 'Un compte existe déjà avec ce nom d''utilisateur'),
(117, 2, 'USERNAME_EXISTS', 'An account already exists with this username'),
(117, 3, 'USERNAME_EXISTS', 'An account already exists with this username'),
(118, 1, 'ACCOUNT_EDIT_SUCCESS', 'Les informations de votre compte ont bien été modifiées.'),
(118, 2, 'ACCOUNT_EDIT_SUCCESS', 'Your account information have been changed.'),
(118, 3, 'ACCOUNT_EDIT_SUCCESS', 'Your account information have been changed.'),
(119, 1, 'ACCOUNT_EDIT_FAILURE', 'Echec de la modification des informations de compte.'),
(119, 2, 'ACCOUNT_EDIT_FAILURE', 'An error occured during the modification of the account information.'),
(119, 3, 'ACCOUNT_EDIT_FAILURE', 'An error occured during the modification of the account information.'),
(120, 1, 'ACCOUNT_CREATE_FAILURE', 'Echec de la création du compte.'),
(120, 2, 'ACCOUNT_CREATE_FAILURE', 'Failed to create account.'),
(120, 3, 'ACCOUNT_CREATE_FAILURE', 'Failed to create account.'),
(121, 1, 'PAYMENT_CHECK', 'Par chèque'),
(121, 2, 'PAYMENT_CHECK', 'By check'),
(121, 3, 'PAYMENT_CHECK', 'By check'),
(122, 1, 'PAYMENT_ARRIVAL', 'A l''arrivée'),
(122, 2, 'PAYMENT_ARRIVAL', 'On arrival'),
(122, 3, 'PAYMENT_ARRIVAL', 'On arrival'),
(123, 1, 'CHOOSE_PAYMENT', 'Choisissez un moyen de paiement'),
(123, 2, 'CHOOSE_PAYMENT', 'Choose a method of payment'),
(123, 3, 'CHOOSE_PAYMENT', 'Choose a method of payment'),
(124, 1, 'PAYMENT_CREDIT_CARDS', 'Cartes de credit'),
(124, 2, 'PAYMENT_CREDIT_CARDS', 'Credit cards'),
(124, 3, 'PAYMENT_CREDIT_CARDS', 'Credit cards'),
(125, 1, 'MAX_ADULTS', 'Adultes max'),
(125, 2, 'MAX_ADULTS', 'Max adults'),
(125, 3, 'MAX_ADULTS', 'Max adults'),
(126, 1, 'MAX_CHILDREN', 'Enfants max'),
(126, 2, 'MAX_CHILDREN', 'Max children'),
(126, 3, 'MAX_CHILDREN', 'Max children'),
(127, 1, 'PAYMENT_CARDS_NOTICE', 'Cliquez sur "Payer" ci-dessous, vous allez être redirigé vers le site sécurisé de 2Checkout.com'),
(127, 2, 'PAYMENT_CARDS_NOTICE', 'Click on "Check Out" below, you will be redirected towards the secure site of 2Checkout.com'),
(127, 3, 'PAYMENT_CARDS_NOTICE', 'Click on "Check Out" below, you will be redirected towards the secure site of 2Checkout.com'),
(129, 1, 'DURATION', 'Durée'),
(129, 2, 'DURATION', 'Duration'),
(129, 3, 'DURATION', 'Duration'),
(130, 1, 'PERSON', 'Personne'),
(130, 2, 'PERSON', 'Person'),
(130, 3, 'PERSON', 'Person'),
(131, 1, 'CHOOSE_A_DATE', 'Choisissez une date'),
(131, 2, 'CHOOSE_A_DATE', 'Choose a date'),
(131, 3, 'CHOOSE_A_DATE', 'Choose a date'),
(132, 1, 'TIMESLOT', 'Horaire'),
(132, 2, 'TIMESLOT', 'Time slot'),
(132, 3, 'TIMESLOT', 'Time slot'),
(133, 1, 'ACTIVITIES', 'Activités'),
(133, 2, 'ACTIVITIES', 'Activities'),
(133, 3, 'ACTIVITIES', 'Activities'),
(134, 1, 'DESTINATION', 'Destination'),
(134, 2, 'DESTINATION', 'Destination'),
(134, 3, 'DESTINATION', 'Destination'),
(135, 1, 'NO_HOTEL_FOUND', 'Aucun hotel trouvé'),
(135, 2, 'NO_HOTEL_FOUND', 'No hotel found'),
(135, 3, 'NO_HOTEL_FOUND', 'No hotel found'),
(136, 1, 'FOR', 'pour'),
(136, 2, 'FOR', 'for'),
(136, 3, 'FOR', 'for'),
(137, 1, 'FIND_ACTIVITIES_AND_TOURS', 'Découvrez nos activités et excursions'),
(137, 2, 'FIND_ACTIVITIES_AND_TOURS', 'Find out our activities and tours'),
(137, 3, 'FIND_ACTIVITIES_AND_TOURS', 'Find out our activities and tours');

-- =============== CREATION OF THE TABLE pm_currency =============

CREATE TABLE IF NOT EXISTS pm_currency(
    id int NOT NULL AUTO_INCREMENT,
    code varchar(5),
    sign varchar(5),
    main int DEFAULT 0,
    rank int DEFAULT 0,
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

--
-- Content of the table pm_currency
--

INSERT INTO pm_currency (id, code, sign, main, rank) VALUES
(1, 'MNT', '₮', 1, 1),
(2, 'USD', '$', 0, 2),
(3, 'EUR', '€', 0, 3),
(4, 'GBP', '£', 0, 4),
(5, 'INR', '₹', 0, 5),
(6, 'AUD', 'A$', 0, 6),
(7, 'CAD', 'C$', 0, 7),
(8, 'CNY', '¥', 0, 8),
(9, 'TRY', '₺', 0, 9);

-- =============== CREATION OF THE TABLE pm_country ==============

CREATE TABLE IF NOT EXISTS pm_country(
    id int NOT NULL AUTO_INCREMENT,
    name varchar(100),
    code varchar(3),
    PRIMARY KEY(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

--
-- Content of the table pm_country
--

INSERT INTO pm_country VALUES
('', 'Afghanistan', 'AF'),
('', 'Åland', 'AX'),
('', 'Albania', 'AL'),
('', 'Algeria', 'DZ'),
('', 'American Samoa', 'AS'),
('', 'Andorra', 'AD'),
('', 'Angola', 'AO'),
('', 'Anguilla', 'AI'),
('', 'Antarctica', 'AQ'),
('', 'Antigua and Barbuda', 'AG'),
('', 'Argentina', 'AR'),
('', 'Armenia', 'AM'),
('', 'Aruba', 'AW'),
('', 'Australia', 'AU'),
('', 'Austria', 'AT'),
('', 'Azerbaijan', 'AZ'),
('', 'Bahamas', 'BS'),
('', 'Bahrain', 'BH'),
('', 'Bangladesh', 'BD'),
('', 'Barbados', 'BB'),
('', 'Belarus', 'BY'),
('', 'Belgium', 'BE'),
('', 'Belize', 'BZ'),
('', 'Benin', 'BJ'),
('', 'Bermuda', 'BM'),
('', 'Bhutan', 'BT'),
('', 'Bolivia', 'BO'),
('', 'Bonaire', 'BQ'),
('', 'Bosnia and Herzegovina', 'BA'),
('', 'Botswana', 'BW'),
('', 'Bouvet Island', 'BV'),
('', 'Brazil', 'BR'),
('', 'British Indian Ocean Territory', 'IO'),
('', 'British Virgin Islands', 'VG'),
('', 'Brunei', 'BN'),
('', 'Bulgaria', 'BG'),
('', 'Burkina Faso', 'BF'),
('', 'Burundi', 'BI'),
('', 'Cambodia', 'KH'),
('', 'Cameroon', 'CM'),
('', 'Canada', 'CA'),
('', 'Cape Verde', 'CV'),
('', 'Cayman Islands', 'KY'),
('', 'Central African Republic', 'CF'),
('', 'Chad', 'TD'),
('', 'Chile', 'CL'),
('', 'China', 'CN'),
('', 'Christmas Island', 'CX'),
('', 'Cocos [Keeling] Islands', 'CC'),
('', 'Colombia', 'CO'),
('', 'Comoros', 'KM'),
('', 'Cook Islands', 'CK'),
('', 'Costa Rica', 'CR'),
('', 'Croatia', 'HR'),
('', 'Cuba', 'CU'),
('', 'Curacao', 'CW'),
('', 'Cyprus', 'CY'),
('', 'Czech Republic', 'CZ'),
('', 'Democratic Republic of the Congo', 'CD'),
('', 'Denmark', 'DK'),
('', 'Djibouti', 'DJ'),
('', 'Dominica', 'DM'),
('', 'Dominican Republic', 'DO'),
('', 'East Timor', 'TL'),
('', 'Ecuador', 'EC'),
('', 'Egypt', 'EG'),
('', 'El Salvador', 'SV'),
('', 'Equatorial Guinea', 'GQ'),
('', 'Eritrea', 'ER'),
('', 'Estonia', 'EE'),
('', 'Ethiopia', 'ET'),
('', 'Falkland Islands', 'FK'),
('', 'Faroe Islands', 'FO'),
('', 'Fiji', 'FJ'),
('', 'Finland', 'FI'),
('', 'France', 'FR'),
('', 'French Guiana', 'GF'),
('', 'French Polynesia', 'PF'),
('', 'French Southern Territories', 'TF'),
('', 'Gabon', 'GA'),
('', 'Gambia', 'GM'),
('', 'Georgia', 'GE'),
('', 'Germany', 'DE'),
('', 'Ghana', 'GH'),
('', 'Gibraltar', 'GI'),
('', 'Greece', 'GR'),
('', 'Greenland', 'GL'),
('', 'Grenada', 'GD'),
('', 'Guadeloupe', 'GP'),
('', 'Guam', 'GU'),
('', 'Guatemala', 'GT'),
('', 'Guernsey', 'GG'),
('', 'Guinea', 'GN'),
('', 'Guinea-Bissau', 'GW'),
('', 'Guyana', 'GY'),
('', 'Haiti', 'HT'),
('', 'Heard Island and McDonald Islands', 'HM'),
('', 'Honduras', 'HN'),
('', 'Hong Kong', 'HK'),
('', 'Hungary', 'HU'),
('', 'Iceland', 'IS'),
('', 'India', 'IN'),
('', 'Indonesia', 'ID'),
('', 'Iran', 'IR'),
('', 'Iraq', 'IQ'),
('', 'Ireland', 'IE'),
('', 'Isle of Man', 'IM'),
('', 'Israel', 'IL'),
('', 'Italy', 'IT'),
('', 'Ivory Coast', 'CI'),
('', 'Jamaica', 'JM'),
('', 'Japan', 'JP'),
('', 'Jersey', 'JE'),
('', 'Jordan', 'JO'),
('', 'Kazakhstan', 'KZ'),
('', 'Kenya', 'KE'),
('', 'Kiribati', 'KI'),
('', 'Kosovo', 'XK'),
('', 'Kuwait', 'KW'),
('', 'Kyrgyzstan', 'KG'),
('', 'Laos', 'LA'),
('', 'Latvia', 'LV'),
('', 'Lebanon', 'LB'),
('', 'Lesotho', 'LS'),
('', 'Liberia', 'LR'),
('', 'Libya', 'LY'),
('', 'Liechtenstein', 'LI'),
('', 'Lithuania', 'LT'),
('', 'Luxembourg', 'LU'),
('', 'Macao', 'MO'),
('', 'Macedonia', 'MK'),
('', 'Madagascar', 'MG'),
('', 'Malawi', 'MW'),
('', 'Malaysia', 'MY'),
('', 'Maldives', 'MV'),
('', 'Mali', 'ML'),
('', 'Malta', 'MT'),
('', 'Marshall Islands', 'MH'),
('', 'Martinique', 'MQ'),
('', 'Mauritania', 'MR'),
('', 'Mauritius', 'MU'),
('', 'Mayotte', 'YT'),
('', 'Mexico', 'MX'),
('', 'Micronesia', 'FM'),
('', 'Moldova', 'MD'),
('', 'Monaco', 'MC'),
('', 'Mongolia', 'MN'),
('', 'Montenegro', 'ME'),
('', 'Montserrat', 'MS'),
('', 'Morocco', 'MA'),
('', 'Mozambique', 'MZ'),
('', 'Myanmar [Burma]', 'MM'),
('', 'Namibia', 'NA'),
('', 'Nauru', 'NR'),
('', 'Nepal', 'NP'),
('', 'Netherlands', 'NL'),
('', 'New Caledonia', 'NC'),
('', 'New Zealand', 'NZ'),
('', 'Nicaragua', 'NI'),
('', 'Niger', 'NE'),
('', 'Nigeria', 'NG'),
('', 'Niue', 'NU'),
('', 'Norfolk Island', 'NF'),
('', 'North Korea', 'KP'),
('', 'Northern Mariana Islands', 'MP'),
('', 'Norway', 'NO'),
('', 'Oman', 'OM'),
('', 'Pakistan', 'PK'),
('', 'Palau', 'PW'),
('', 'Palestine', 'PS'),
('', 'Panama', 'PA'),
('', 'Papua New Guinea', 'PG'),
('', 'Paraguay', 'PY'),
('', 'Peru', 'PE'),
('', 'Philippines', 'PH'),
('', 'Pitcairn Islands', 'PN'),
('', 'Poland', 'PL'),
('', 'Portugal', 'PT'),
('', 'Puerto Rico', 'PR'),
('', 'Qatar', 'QA'),
('', 'Republic of the Congo', 'CG'),
('', 'Réunion', 'RE'),
('', 'Romania', 'RO'),
('', 'Russia', 'RU'),
('', 'Rwanda', 'RW'),
('', 'Saint Barthélemy', 'BL'),
('', 'Saint Helena', 'SH'),
('', 'Saint Kitts and Nevis', 'KN'),
('', 'Saint Lucia', 'LC'),
('', 'Saint Martin', 'MF'),
('', 'Saint Pierre and Miquelon', 'PM'),
('', 'Saint Vincent and the Grenadines', 'VC'),
('', 'Samoa', 'WS'),
('', 'San Marino', 'SM'),
('', 'São Tomé and Príncipe', 'ST'),
('', 'Saudi Arabia', 'SA'),
('', 'Senegal', 'SN'),
('', 'Serbia', 'RS'),
('', 'Seychelles', 'SC'),
('', 'Sierra Leone', 'SL'),
('', 'Singapore', 'SG'),
('', 'Sint Maarten', 'SX'),
('', 'Slovakia', 'SK'),
('', 'Slovenia', 'SI'),
('', 'Solomon Islands', 'SB'),
('', 'Somalia', 'SO'),
('', 'South Africa', 'ZA'),
('', 'South Georgia and the South Sandwich Islands', 'GS'),
('', 'South Korea', 'KR'),
('', 'South Sudan', 'SS'),
('', 'Spain', 'ES'),
('', 'Sri Lanka', 'LK'),
('', 'Sudan', 'SD'),
('', 'Suriname', 'SR'),
('', 'Svalbard and Jan Mayen', 'SJ'),
('', 'Swaziland', 'SZ'),
('', 'Sweden', 'SE'),
('', 'Switzerland', 'CH'),
('', 'Syria', 'SY'),
('', 'Taiwan', 'TW'),
('', 'Tajikistan', 'TJ'),
('', 'Tanzania', 'TZ'),
('', 'Thailand', 'TH'),
('', 'Togo', 'TG'),
('', 'Tokelau', 'TK'),
('', 'Tonga', 'TO'),
('', 'Trinidad and Tobago', 'TT'),
('', 'Tunisia', 'TN'),
('', 'Turkey', 'TR'),
('', 'Turkmenistan', 'TM'),
('', 'Turks and Caicos Islands', 'TC'),
('', 'Tuvalu', 'TV'),
('', 'U.S. Minor Outlying Islands', 'UM'),
('', 'U.S. Virgin Islands', 'VI'),
('', 'Uganda', 'UG'),
('', 'Ukraine', 'UA'),
('', 'United Arab Emirates', 'AE'),
('', 'United Kingdom', 'GB'),
('', 'United States', 'US'),
('', 'Uruguay', 'UY'),
('', 'Uzbekistan', 'UZ'),
('', 'Vanuatu', 'VU'),
('', 'Vatican City', 'VA'),
('', 'Venezuela', 'VE'),
('', 'Vietnam', 'VN'),
('', 'Wallis and Futuna', 'WF'),
('', 'Western Sahara', 'EH'),
('', 'Yemen', 'YE'),
('', 'Zambia', 'ZM'),
('', 'Zimbabwe', 'ZW');
