DELIMITER $$
CREATE TRIGGER Controlla_forma_biologica
BEFORE INSERT ON 
    Pianta
FOR EACH ROW 
BEGIN
    IF NEW.forma_biologica NOT IN (
        'NP', 'P scap', 'P caespn', 'P liann', 'P succ', 'P ep', 'P rept',
        'Ch suffr', 'Ch scap', 'Ch succ', 'Ch pulv', 'Ch frut', 'Ch rept',
        'H caesp', 'H rept', 'H scap', 'H ros', 'H bienn', 'H scand',
        'G rad', 'G bulb', 'G rhiz', 'G par', 'I rad', 'I nat',
        'T caesp', 'T rept', 'T scap', 'T ros', 'T par'
    ) THEN
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Forma biologica non valida';
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER Lista_Rossa
BEFORE insert ON Lista_Rossa
FOR EACH ROW 
BEGIN
    IF NEW.categoria NOT IN
    ('CR', 'EN', 'VU', 'NT', 'LC', 'DD')
	THEN
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Categoria non valida';
    END IF;
END$$
DELIMITER ;
