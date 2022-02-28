CREATE OR REPLACE VIEW full_name_catalog AS 
SELECT c.id, mc.name main, rc.name releases, c.name, 
       case when c.id in (5, 6, 15, 13, 14) then 'yes' else 'no' end 'is there in my project?'
FROM catalogs c
 INNER JOIN main_catalog mc ON c.main_id  = mc.id
 LEFT JOIN release_catalog rc ON c.release_id = rc.id;

SELECT * FROM full_name_catalog;

CREATE OR REPLACE VIEW obj_image_hubble AS 
SELECT distinct 
       (select o.name_messier from objects o where (o.right_ascension - 1 < v3sum.ra and v3sum.ra < o.right_ascension + 1 ) 
                                       and (o.declination - 1 < v3sum.dec_  and v3sum.dec_ < o.declination + 1 )) name_obj,
       v3sum.ra, 
       v3sum.dec_, 
       COALESCE(v3sum.match_id, v3det.match_id) match_id,
       COALESCE(v3sum.filter_, v3det.filter_) filter_,
       i.link
FROM hsc_v3hcvdetailed v3det 
     LEFT JOIN  hsc_v3hcvsummary v3sum
               ON v3sum.match_id = v3det.match_id AND  v3sum.filter_ = v3det.filter_
     INNER JOIN image i 
               ON v3det.image_id  = i.id 
WHERE i.link <> '' ;

SELECT * FROM obj_image_hubble;

-- Проверка валидности даных на примере таблицы ps_dr2detection
DELIMITER //
CREATE TRIGGER trg_dr2detection BEFORE INSERT ON ps_dr2detection
FOR EACH ROW BEGIN
	IF dec_ < -30
	  THEN
      SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Покрытие неба к северу от склонения не должно быть меньше -30 градусов';
    ELSEIF ra > 270 
       THEN
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Прямое восхождение указано неверно';
    ELSEIF obj_id IS NULL OR catalog_id IS NULL
       THEN
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Не заданы имя объекта или имя каталога';
    END IF;                  
END //

-- Процедура - получить фотографии объекта
DELIMITER //
DROP PROCEDURE IF EXISTS get_image //
CREATE PROCEDURE get_image(p_name_messier VARCHAR(100))
BEGIN
SET @var = CONCAT('(SELECT DISTINCT name_obj, link FROM obj_image_hubble WHERE name_obj IN ("',p_name_messier,'"))');
PREPARE zxc FROM @var;
EXECUTE zxc;
END //

call get_image('M4')




