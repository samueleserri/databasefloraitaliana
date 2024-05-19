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
CREATE PROCEDURE mostra_immagini(
    in class varchar(50),
    in ord varchar(50),
    in fam varchar(50), 
    in subfam varchar(50), 
    in gen varchar(50))
BEGIN
select 
	   Immagine.percorso, Descrizione.percorso
from 
	   Tassonomia
inner join 
	   Pianta
on 
	   Tassonomia.pianta = Pianta.id
inner join
    Descrizione
on 
    Pianta.id = Descrizione.pianta
Inner join
	   Immagine
on 
	   Pianta.id = Immagine.pianta
where 
    	classe = class and
        ordine = ord and
        famiglia = fam and
        sotto_famiglia = subfam and
        genere = gen;
END $$
DELIMITER ;
