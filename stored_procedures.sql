DELIMITER $$
CREATE PROCEDURE piante_minacciate(in endem bool)
BEGIN
    select count(*) as totale, 
    count(*) / (select count(*) from Lista_Rossa) as proporzione,
    categoria
from 
    Lista_Rossa
where 
    endemicita = endem
group by
    categoria;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE mostra_parchi(in nome_regione varchar(30))
BEGIN
select 
	nome_parco, 
    citta,
    via, 
    Tassonomia.* 
from
	Parco_Botanico 
inner join 
	Conservazione 
USING
	(nome_parco, citta)
inner join 
	Pianta 
on 
	Conservazione.pianta = Pianta.id
inner join 
	Tassonomia
on 
	Tassonomia.pianta = Pianta.id
where 
	regione = nome_regione;
END $$


DELIMITER $$
CREATE PROCEDURE superficie_parchi()
BEGIN
select 
	regione, 
    sum(superficie) as area_parchi
from 
	Parco_Botanico 
group by 
	regione
order by 
	area_parchi
desc;
END $$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE mostra_immagini_e_descrizione(
    IN p_classe VARCHAR(50),
    IN p_ordine VARCHAR(50),
    IN p_famiglia VARCHAR(50), 
    IN p_sotto_famiglia VARCHAR(50), 
    IN p_genere VARCHAR(50),
    IN p_specie VARCHAR(50))
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
        (p_classe IS NULL OR classe = p_classe) 
    AND
        (p_ordine IS NULL OR ordine = p_ordine)
    AND
        (p_famiglia IS NULL OR famiglia = p_famiglia)
    AND
        (p_sotto_famiglia IS NULL OR sotto_famiglia = p_sotto_famiglia)
    AND
        (p_genere IS NULL OR genere = p_genere)
    AND 
        (p_specie is NULL OR specie = p_specie);
END $$
DELIMITER ;
