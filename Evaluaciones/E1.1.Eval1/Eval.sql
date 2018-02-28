create table LOG_FILM (id int PRIMARY KEY NOT Ncreate table LOG_FILM(Id int PRIMARY KEY NOT NULL AUTO_INCREMENT, Tipo varchar(10) NOT NULL DEFAULT 'Update', Film_id smallint(5), Last_value varchar(50), New_value varchar(50), Last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP);ULL, Tipo varchar(10) NOT NULL DEFAULT 'Update', film_id smallint(5) NOT NULL, Last_value varchar(20), New_value varchar(20), Last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP);

DELIMITER // 
CREATE procedure actu_LOG_FILM(
	in tipo_cambio varchar(10),
    in film_id smallint(5),
    in last_value varchar(20), 
    in new_value varchar(20))
BEGIN
	declare cambio varchar(10);
    declare lastval varchar(20);
    declare newval varchar(20);
    
    set cambio = concat(tipo_cambio, '%');
    set lastval = concat(last_value, '%');
    set newval = concat(new_value, '%');
    
    insert into LOG_FILM (Tipo, film_id, last_value, new_value) values (cambio, film_id, lastval, newval);

END //
DELIMITER ;  

DELIMITER //
CREATE TRIGGER update_film AFTER UPDATE ON film 
FOR EACH ROW 
BEGIN

    CALL actu_LOG_FILM('Update', old.film_id, 'old', 'new');

END //
DELIMITER ;