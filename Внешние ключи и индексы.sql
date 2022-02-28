-- Индексы таблицы objects
CREATE INDEX objects_name_messier_idx ON objects(name_messier);
CREATE INDEX objects_name_ngc_idx ON objects(name_ngc);

-- Внешние ключи catalogs
ALTER TABLE catalogs ADD CONSTRAINT catalogs_main_id_fk 
            FOREIGN KEY (main_id) REFERENCES main_catalog(id) ON DELETE RESTRICT,
                     ADD CONSTRAINT catalogs_release_id_fk 
            FOREIGN KEY (release_id) REFERENCES release_catalog (id) ON DELETE RESTRICT;
           
-- Внешние ключи и индексы ps_dr2detection
ALTER TABLE ps_dr2detection ADD CONSTRAINT dr2detection_catalog_id_fk 
            FOREIGN KEY (catalog_id) REFERENCES catalogs(id) ON DELETE RESTRICT;
           
CREATE INDEX ps_dr2detection_obj_id_idx ON ps_dr2detection(obj_id); -- необходимо, чтобы создать внешний ключ к ps_dr2forced_mean          
CREATE INDEX ps_dr2detection_ra_idx ON ps_dr2detection(ra);  
CREATE INDEX ps_dr2detection_dec__idx ON ps_dr2detection(dec_); 
            
-- Внешние ключи и индексы ps_dr2forced_mean           
ALTER TABLE ps_dr2forced_mean ADD CONSTRAINT dr2forced_catalog_id_fk 
            FOREIGN KEY (catalog_id) REFERENCES catalogs(id) ON DELETE RESTRICT,
                              ADD CONSTRAINT ps_dr2forced_mean_id_fk 
            FOREIGN KEY (id) REFERENCES ps_dr2detection(obj_id) ON DELETE RESTRICT;
           
CREATE INDEX dr2forced_mean_obj_name_idx ON ps_dr2forced_mean(obj_name); 
#SHOW INDEX FROM ps_dr2forced_mean;          

-- Внешние ключи nexsci  и индексы
ALTER TABLE nexsci ADD CONSTRAINT nexsci_catalog_id_fk
            FOREIGN KEY (catalog_id) REFERENCES catalogs(id) ON DELETE RESTRICT;  
           
CREATE INDEX nexsci_planet_name_idx ON nexsci(planet_name);
CREATE INDEX nexsci_Rp_idx ON nexsci(Rp);  
CREATE INDEX nexsci_Mp_idx ON nexsci(Mp);

-- Внешние ключи и индексы hsc_v3hcvdetailed
ALTER TABLE hsc_v3hcvdetailed ADD CONSTRAINT v3hcvdetailed_catalog_id_fk
            FOREIGN KEY (catalog_id) REFERENCES catalogs(id) ON DELETE RESTRICT,
                              ADD CONSTRAINT hsc_v3hcvdetailed_image_id_fk
            FOREIGN KEY (image_id) REFERENCES image(id) ON DELETE RESTRICT; 
           
CREATE INDEX hsc_v3hcvdetailed_match_id_filter_idx ON hsc_v3hcvdetailed(match_id, filter_);  
            
-- Внешние ключи и индексы hsc_v3hcvsummary  
ALTER TABLE hsc_v3hcvsummary ADD CONSTRAINT v3hcvsummary_catalog_id_fk
            FOREIGN KEY (catalog_id) REFERENCES catalogs(id) ON DELETE RESTRICT,
                    ADD CONSTRAINT v3hcvsummary_match_id_fk
            FOREIGN KEY (match_id, filter_) REFERENCES hsc_v3hcvdetailed(match_id, filter_) ON DELETE RESTRICT;                          

CREATE INDEX hsc_v3hcvsummary_ra_idx ON hsc_v3hcvsummary(ra);  
CREATE INDEX hsc_v3hcvsummary_dec__idx ON hsc_v3hcvsummary(dec_); 
         
-- Внешние ключи и индексы image            
CREATE INDEX image_image_name_idx ON image(image_name); 