# Найти координаты, которые сфотографировали и Hubble и Pan-Starrs 
# Рассмотреть координаты с точностью до трех знаков после запятой
# Вывести имя объекта для каждого телескопа, малую и большую оси PSF FWHM,
# среднее смещение расстояния источника от позиции совпадения(милли аркстрем) 
# и имена используемых каталогов

SELECT * FROM ps_dr2forced_mean  WHERE obj_name  = 'PSO J245.8956-26.5358';
SELECT * FROM ps_dr2detection WHERE obj_id = 76152458957087502;

SELECT concat(hs.match_id, ' ', hs.filter_) name_hubble, 
      -- fm.obj_name name_pan,
       pd.detect_id,
       round(hs.ra, 3) ra, 
       round(hs.dec_, 3) dec_,
       pd.psf_major_fwhm, 
       pd.psf_minor_fwhm,
       (select distinct avg(d) over(partition by hd.match_id, hd.filter_) 
        from hsc_v3hcvdetailed hd where hd.match_id = hs.match_id and hs.filter_ = hd.filter_ 
       ) avg_d,        
       concat ((select concat(main, ' ', releases, ' ', name) from full_name_catalog c where c.id = hs.catalog_id), ' ',
               (select concat(main, ' ', releases, ' ', name) from full_name_catalog c where c.id = pd.catalog_id), ' ',
               (select concat(main, ' ', releases, ' ', name) from full_name_catalog c where c.id = fm.catalog_id)
               ) catalogs
FROM hsc_v3hcvsummary hs
    INNER JOIN ps_dr2detection pd -- так как нужны только совпадающие координаты
            ON round(hs.ra, 3) = round(pd.ra, 3) and round(hs.dec_, 3) = round(pd.dec_,3) 
    INNER JOIN ps_dr2forced_mean fm 
            ON fm.id = pd.obj_id;
   
# Вывести имя объекта Hubble, ссылку на фото,
# минимальную корректировку, максимальную ошибку корректировки и
# усредненное смещение расстояния источника от позиции совпадения, значение которого больше 3

SELECT * FROM image;
SELECT * FROM hsc_v3hcvdetailed WHERE match_id = 69245948 AND filter_ = 'WFC3_F467M';

SELECT CONCAT(t.match_id, ' ', t.filter_) name,         
       t.link, 
       MIN(corr_mag), 
       MAX(mag_err), 
       AVG(d)
FROM 
( 
   SELECT d.match_id, d.filter_, i.link, corr_mag, mag_err, d
   FROM  image i 
     JOIN hsc_v3hcvdetailed d ON i.id = d.image_id 
)t  
GROUP BY CONCAT(t.match_id, ' ', t.filter_),
         t.link
HAVING AVG(d) > 3;  


# Вывести имя планеты, массу, радиус,
# Разбить планеты на группы: с массой больше или равно 2 массы Юпитера и меньше 2 масс Юпитера
# для каждой группы вывести: максимальнумассу планеты, минимальную массу планеты, средний радиус.
# Вывести общее время которое планеты проводят перед звездой хозяином
# имя самой горячей планеты, имя планеты с самым маленьким поверхностным притяжением
# количество транзитных и не транзитных планет планет

SELECT planet_name, Rp, Mp, 
       MAX(Mp) OVER(w_mass) max_mp,
       MIN(Mp) OVER(w_mass) min_mp,
       AVG(Rp) OVER(w_mass) avg_r,
       SUM(transit_duration) OVER() time_trans,
       FIRST_VALUE(planet_name) OVER(ORDER BY Tday DESC) hot_planet,
       LAST_VALUE(planet_name) OVER(ORDER BY log_gp RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) g_min_planet,
       transit_flag,
       COUNT(transit_flag) OVER(PARTITION BY transit_flag) qty_transit       
FROM nexsci
WINDOW w_mass AS (PARTITION BY Mp >= 2);

     

