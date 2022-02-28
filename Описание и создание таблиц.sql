
# STScI - Space Telescope Science Institute  https://www.stsci.edu/
# Catalogs. MAST (Multimission Archive at STScI) provides access to tabular measurements of astronomical 
# objects from the Hubble Space Telescope and other missions.
# https://catalogs.mast.stsci.edu/
# Каталоги Научного института космического телескопа обеспечивает доступ к табличным измерениям 
# астрономических объектов с космического телескопа Хаббла и других миссий.
# По сути, это сборник двумерных таблиц с координатами различных объектов, полученных с разных телескопов. 
# Зная координаты, можно рассмотреть/изучить объекты например по этому адресу: https://mast.stsci.edu/

# Из всего множества подкаталогов, для проекта выбрала 5 подкаталогов 
# В одном из представлений будут выведены полные имена с метками у выбранных подкаталогов
# Данные в подкаталогах Хаббла и Пан-Старс содержат информацию об объекте М4 (звездное шаровое скопление в созвездии Скорпиона)
 

CREATE DATABASE STScI_Catalog; 
USE STScI_Catalog;

-- Таблица главных каталогов сайта https://catalogs.mast.stsci.edu/
CREATE TABLE main_catalog (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(100) NOT NULL COMMENT "Имя каталога",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);  

INSERT INTO main_catalog (name) VALUES
('Pan-STARRS'),
('Hubble Source Catalog'),
('Exoplanet Atmosphere Observability Table');

SELECT * FROM main_catalog mc;

-- Таблица всех подкаталогов сайта https://catalogs.mast.stsci.edu/
CREATE TABLE catalogs (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  main_id INT UNSIGNED NOT NULL COMMENT "Ссылка на главный каталог",
  release_id INT UNSIGNED COMMENT "версия каталога",
  name VARCHAR(100) NOT NULL COMMENT "Имя каталога",
  magnitude_type VARCHAR(100) COMMENT "Тип величины",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
); 

-- Справочник релизов для каталогов 
CREATE TABLE release_catalog(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(100) NOT NULL COMMENT "Имя Релиза",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
); 

INSERT INTO release_catalog (name)
VALUES ('PS1 DR1'),
       ('PS1 DR2'),
       ('V2'),
       ('V3');
      
SELECT * FROM release_catalog;

INSERT INTO catalogs (main_id, release_id, name, magnitude_type)
VALUES (1, 1, 'mean object', ''),
       (1, 1, 'stacked object', ''),
       (1, 2, 'mean object', ''),
       (1, 2, 'stacked object', ''),
       (1, 2, 'forced mean object', ''),
       (1, 2, 'detections', ''),
       (2, 3, 'summary', 'magaper2'),
       (2, 3, 'summary', 'magauto'),
       (2, 3, 'detailed', ''),
       (2, 4, 'summary', 'magaper2'),
       (2, 4, 'summary', 'magauto'),
       (2, 4, 'detailed', ''),
       (2, 4, 'hcv summary', ''),
       (2, 4, 'hcv detailed', ''),
       (3, null, 'nexsci', ''),
       (3, null, 'exoplanets.org', ''),
       (3, null, 'toi', '');

SELECT * FROM catalogs;

-- Таблица объектов на небе, изолированный справочник с координатами объектов 
CREATE TABLE objects (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор объекта", 
  name_messier VARCHAR(100) COMMENT "Имя объекта в каталоге Мессье",
  name_ngc VARCHAR(100) COMMENT "Имя объекта в Новом общем каталоге",
  right_ascension FLOAT COMMENT "прямое восхождение (RA)",
  declination FLOAT COMMENT "склонение (Dec)",
  max_m FLOAT COMMENT "Видимая звездная величина. Максимальная яркость",
  min_m FLOAT COMMENT "Видимая звездная величина. Минимальная яркость",
  d_pс FLOAT COMMENT "Расстояние в парсеках",
  d_ly FLOAT COMMENT "Расстояние в световых годах",
  description VARCHAR(255) COMMENT "описание",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

INSERT INTO objects (name_messier, name_ngc, right_ascension, declination, max_m, min_m, d_pс, d_ly, description)
VALUES  ('M4', 'NGC 6121', 245.898,	-26.5255, 8.1, null, 1888.7, 6160, 'It is a globular star cluster in the constellation Scorpio'),
        ('M31',	'NGC 224', 10.6848, 41.2691, 4.3, null, 740000, 2400000, 'The Andromeda Galaxy is a spiral galaxy in the constellation Andromeda'),
        ('M42',	'NGC 1976', 83.8187,-5.38968, 5, null, 398.6, 1300, 'The Orion Nebula is an emission and reflection nebula, as well as a star formation region in the constellation Orion'),   
        ('M1', 'NGC 1952', 83.6331,	22.0145, 8.4, null, 2000, 6500, 'The Crab Nebula is a supernova remnant and pulsar wind nebula in the constellation of Taurus'),
        ('δ Cep', '',  337.293, 58.4152, 4.07, 7.5, 273, 891, 'It is a double variable star in the constellation Cepheus'),
        ('M35',	'NGC 2168', 92.2711, 24.3386, 5.3, null, 860, 2800, 'It is a scattered star cluster in the constellation Gemini');
      
SELECT * FROM objects;

# Эпоха в астрономии — выбранный момент времени, для которого определены астрономические координаты или элементы орбиты небесных тел
# PSF - The point spread function - функция рассеяния точки

-- Подкаталог телескопа Pan-STARRS Forced Mean релиз DR2
CREATE TABLE ps_dr2forced_mean (
  id BIGINT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Идентификатор объекта", 
  obj_name VARCHAR(100) NOT NULL COMMENT "Имя объекта",
  n_detections SMALLINT DEFAULT -999 COMMENT "Количество обнаружений одной эпохи во всех фильтрах",
  gn_total SMALLINT DEFAULT -999 COMMENT "Количество принудительных обнаружений одной эпохи в g-фильтре",
  gf_psf_flux REAL DEFAULT -999 COMMENT "Средний поток PSF от принудительных обнаружений фильтра g в одну эпоху",
  gf_psf_flux_err REAL DEFAULT -999 COMMENT "Ошибка в среднем потоке PSF из-за принудительных обнаружений фильтра g в одну эпоху",
  gf_psf_flux_std REAL DEFAULT -999 COMMENT "Стандартное отклонение потоков PSF от принудительных одноэтапных обнаружений g-фильтра",
  catalog_id INT UNSIGNED NOT NULL COMMENT "Идентификатор каталога",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

SELECT * FROM ps_dr2forced_mean;

# FWHM - full width at half maximum - длительность импульса на уровне половины амплитуды

-- Подкаталог телескопа Pan-STARRS Detection релиз DR2
CREATE TABLE ps_dr2detection (
  detect_id BIGINT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Идентификатор обнаружения", 
  obj_id BIGINT UNSIGNED NOT NULL COMMENT "Идентификатор объекта",
  filter_id TINYINT COMMENT "Идентификатор фильтра",
  obs_time  FLOAT DEFAULT -999 COMMENT "Измененная юлианская дата в середине наблюдения. Это международное атомное время, а не UTC",
  ra FLOAT DEFAULT -999 COMMENT "Прямое восхождение (градусы)",
  dec_ FLOAT DEFAULT -999 COMMENT "Склонение (градусы)",
  psf_major_fwhm REAL DEFAULT -999 COMMENT "Большая ось PSF FWHM (арксеканс)",
  psf_minor_fwhm REAL DEFAULT -999 COMMENT "Малая ось PSF FWHM (арксеканс)",
  catalog_id INT UNSIGNED NOT NULL COMMENT "Идентификатор каталога",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

SELECT * FROM ps_dr2detection;

# Вданном случае я сначала создала таблицу со всеми столбцами, которые были на сайте,
# а затем удалила те из них значения в которых преимущественно NULL

-- Подкаталог экзопланет NexScI
CREATE TABLE nexsci (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  planet_name  VARCHAR(100) NOT NULL COMMENT "Имя Планеты",
  Rp FLOAT DEFAULT NULL	COMMENT "Радиус планеты (в радиусах Юпитера)",
  Mp FLOAT DEFAULT NULL	COMMENT "Масса планеты (в массах Юпитера)",	
  Tday FLOAT DEFAULT NULL COMMENT "Температура на освещенной стороне (Кельвин)",		
  Teq FLOAT	DEFAULT NULL COMMENT "Равновесная тампература планеты (Кельвин)",
  log_gp FLOAT DEFAULT NULL COMMENT "Поверхностная гравитация планеты",
  period FLOAT DEFAULT NULL	COMMENT "Орбитальный период (день)",
  transit_duration FLOAT DEFAULT NULL COMMENT "Продолжительность прохождения планеты перед звездой хозяином (час)",
  distance	FLOAT DEFAULT NULL COMMENT "Расстояние от планеты до звезды хозяина (парсек)",
  Teff FLOAT DEFAULT NULL COMMENT "Эффективная температура звезды (Кельвин)",
  log_gs FLOAT DEFAULT NULL COMMENT	"Поверхностная гравитация звезды",
  transit_flag	BOOLEAN  COMMENT	"Транзитная планета = True",
  catalog_id INT UNSIGNED NOT NULL COMMENT "Идентификатор каталога",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

SELECT * FROM nexsci;

# HCV - Hubble Catalog of Variables 
# HSC - Hubble Source Catalog

-- Подкаталог телескопа Хаббл HCV-Summary релиз v3
CREATE TABLE hsc_v3hcvsummary (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE COMMENT "Идентификатор строки", 
  match_id BIGINT NOT NULL COMMENT "Идентификатор для совпадения. Он соединяется с идентификатором соответствия, используемым в таблицах HSC",
  filter_  VARCHAR(100) COMMENT "Имя фильтра с префиксом имени инструмента",
  group_id BIGINT COMMENT "Идентификатор для группы изображений. Он соединяется с идентификатором группы, используемым в таблицах HSC, таких как Изображения",
  ra FLOAT DEFAULT -999 COMMENT "Прямое восхождение (градусы)",
  dec_ FLOAT DEFAULT -999 COMMENT "Склонение (градусы)",
  mean_mag FLOAT COMMENT "Средняя величина, определяемая HSC",
  mean_corr_mag INT COMMENT "Средняя величина, скорректированная с помощью HCV (такая же, как mean_mag, если коррекция невозможна)",
  mad FLOAT COMMENT "Среднее абсолютное отклонение величин",
  catalog_id INT UNSIGNED NOT NULL COMMENT "Идентификатор каталога",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
  PRIMARY KEY (match_id, filter_)
);

SELECT * FROM hsc_v3hcvsummary;

-- Подкаталог телескопа Хаббл HCV-Detailed релиз v3 
CREATE TABLE hsc_v3hcvdetailed (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  match_id BIGINT NOT NULL COMMENT "Идентификатор для совпадения. Он соединяется с идентификатором соответствия, используемым в таблицах HSC",
  filter_  VARCHAR(100) COMMENT "Имя фильтра с префиксом имени инструмента",
  mjd FLOAT  COMMENT "Измененная юлианская дата в середине наблюдения",
  image_id INT UNSIGNED NOT NULL COMMENT "Идентификатор изображения",
  corr_mag FLOAT COMMENT "Величина, скорректированная с помощью HCV (такая же, как Mag, если коррекция невозможна)",
  mag_err  FLOAT COMMENT "Погрешность величины",
  d  FLOAT COMMENT "Смещение расстояния источника от позиции совпадения(милли аркстрем)",
  catalog_id INT UNSIGNED NOT NULL COMMENT "Идентификатор каталога",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

SELECT * FROM hsc_v3hcvdetailed;

-- Таблица с сылками на фотографии объекта. Эту таблицу добавила без отсылки к сайту, 
-- для визуализации проекта. Ссылки на фото не соответствуют названиям файлов с фотографиями. 
-- Я просто нашла красивые фото шарового скопления М4 в интернете.
CREATE TABLE image (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  image_name VARCHAR(100) NOT NULL COMMENT "Именя файла с фотографией",
  link VARCHAR(500) COMMENT "Ссылка на фото",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

INSERT INTO image (image_name,link)
VALUES
      ('hst_12911_0i_wfc3_uvis_f467M', 'https://v-kosmose.com/wp-content/uploads/2014/04/NGC-6121.jpg'),
      ('hst_12911_0h_wfc3_uvis_f467M', 'https://v-kosmose.com/wp-content/uploads/2014/04/NGC-6121.jpg'),
      ('hst_12911_0j_wfc3_uvis_f467M', 'https://v-kosmose.com/wp-content/uploads/2014/04/NGC-6121.jpg'),
      ('hst_12911_0k_wfc3_uvis_f467M', 'https://v-kosmose.com/wp-content/uploads/2014/04/Messier-4.jpg'),
      ('hst_12911_0l_wfc3_uvis_f775W', ''),
      ('hst_12911_0m_wfc3_uvis_f775W', 'https://ps1images.stsci.edu/cgi-bin/fitscut.cgi?red=/rings.v3.skycell/0770/034/rings.v3.skycell.0770.034.stk.y.unconv.fits&blue=/rings.v3.skycell/0770/034/rings.v3.skycell.0770.034.stk.g.unconv.fits&green=/rings.v3.skycell/0770/034/rings.v3.skycell.0770.034.stk.i.unconv.fits&x=245.897510&y=-26.525520&size=240&wcs=1&asinh=True&autoscale=99.750000'),
      ('hst_12911_0n_wfc3_uvis_f775W', 'https://ps1images.stsci.edu/cgi-bin/fitscut.cgi?red=/rings.v3.skycell/0770/034/rings.v3.skycell.0770.034.stk.g.unconv.fits&x=245.897510&y=-26.525520&size=240&wcs=1&asinh=True&autoscale=99.500000'),
      ('hst_12911_0o_wfc3_uvis_f775W', 'https://v-kosmose.com/wp-content/uploads/2014/04/Pulsar-B1620-26.jpg');
    

SELECT * FROM image;
