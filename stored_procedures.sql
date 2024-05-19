DELIMITER $$
CREATE PROCEDURE piante_minacciate(in categoria varchar(8), in endem bool)
BEGIN
    select count(*) as totale, 
    count(*) / (select count(*) from Lista_Rossa) as proporzione
from 
    Lista_Rossa
where 
    endemicita = endem
and
    Lista_Rossa.categoria = categoria;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE piante_endemiche_per_regione(in nome_regione varchar(30))
BEGIN
select 
	   count(*) as totale, 
	   count(*) / (select count(*) from Distribuzione where regione = nome_regione ) 
    as proporzione
from 
	   Pianta
inner join 
	   Distribuzione
on 
	   Pianta.id = Distribuzione.pianta
where 
	   tipo_corologico = 1
and
	   regione = nome_regione;
END $$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE mostra_immagini_e_descrizione(
    IN p_classe VARCHAR(50),
    IN p_ordine VARCHAR(50),
    IN p_famiglia VARCHAR(50), 
    IN p_sotto_famiglia VARCHAR(50), 
    IN p_genere VARCHAR(50))
BEGIN
    SELECT 
        Immagine.percorso AS img_percorso, 
        Descrizione.percorso AS desc_percorso
    FROM 
        Tassonomia
    INNER JOIN 
        Pianta ON Tassonomia.pianta = Pianta.id
    INNER JOIN
        Descrizione ON Pianta.id = Descrizione.pianta
    INNER JOIN
        Immagine ON Pianta.id = Immagine.pianta
    WHERE 
        (p_classe IS NULL OR classe = p_classe) AND
        (p_ordine IS NULL OR ordine = p_ordine) AND
        (p_famiglia IS NULL OR famiglia = p_famiglia) AND
        (p_sotto_famiglia IS NULL OR sotto_famiglia = p_sotto_famiglia) AND
        (p_genere IS NULL OR genere = p_genere);
END $$

DELIMITER ;
