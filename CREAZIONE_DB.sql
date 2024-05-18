CREATE DATABASE IF NOT EXISTS floraitaliana;
USE floraitaliana;

CREATE TABLE Pianta (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    nome_comune VARCHAR(50) NOT NULL,
    tipo_corologico INT NOT NULL,
    forma_biologica VARCHAR(10) NOT NULL,
    CHECK (forma_biologica IN
    ('NP', 'P scap', 'P caespn', 'P liann', 'P succ', 'P ep', 'P rept',
	'Ch suffr', 'Ch scap', 'Ch succ', 'Ch pulv', 'Ch frut', 'Ch rept',
	'H caesp', 'H rept', 'H scap', 'H ros', 'H bienn', 'H scand',
	'G rad', 'G bulb', 'G rhiz', 'G par', 'I rad', 'I nat',
	'T caesp', 'T rept', 'T scap', 'T ros', 'T par'))
);

CREATE TABLE Tassonomia (
    pianta INT PRIMARY KEY,
    classe VARCHAR(50) NOT NULL,
    ordine VARCHAR(50) NOT NULL,
    famiglia VARCHAR(50) NOT NULL,
    sotto_famiglia VARCHAR(50) NOT NULL,
    genere VARCHAR(50) NOT NULL,
    specie VARCHAR(50) NOT NULL,
    FOREIGN KEY (pianta) REFERENCES Pianta(ID)
);

CREATE TABLE Regione (
    nome_regione VARCHAR(30) PRIMARY KEY
);

CREATE TABLE Parco_Botanico (
    regione VARCHAR(30) NOT NULL,
    nome_parco VARCHAR(255) NOT NULL,
    citta VARCHAR(50) NOT NULL,
    via VARCHAR(255) NOT NULL,
    cap VARCHAR(10) NOT NULL,
    superficie FLOAT,
    PRIMARY KEY (nome_parco, citta),
    FOREIGN KEY (regione) REFERENCES Regione(nome_regione)
);

CREATE TABLE Immagine (
    pianta INT NOT NULL,
    percorso VARCHAR(255) PRIMARY KEY,
    FOREIGN KEY (pianta) REFERENCES Pianta(ID)
);

CREATE TABLE Lista_Rossa (
    pianta INT NOT NULL, 
    categoria VARCHAR(10) NOT NULL,
    endemicita BOOLEAN NOT NULL,
    PRIMARY KEY (pianta),
    FOREIGN KEY (pianta) REFERENCES Pianta(ID),
    CHECK (categoria IN ('EX', 'RE', 'EW', 'CR[PE]', 'CR', 'EN', 'VU', 'NT', 'LC', 'DD'))
);

CREATE TABLE Distribuzione (
    pianta INT NOT NULL, 
    regione VARCHAR(30) NOT NULL, 
    status VARCHAR(24), 
    nome_locale VARCHAR(50),
    PRIMARY KEY (pianta, regione),
    FOREIGN KEY (pianta) REFERENCES Pianta(ID),
    FOREIGN KEY (regione) REFERENCES Regione(nome_regione)
);

CREATE TABLE Descrizione (
    pianta INT NOT NULL, 
    percorso VARCHAR(255) NOT NULL, 
    PRIMARY KEY (percorso), 
    FOREIGN KEY (pianta) REFERENCES Pianta(ID)
);

CREATE TABLE Conservazione (
    pianta INT NOT NULL, 
    nome_parco VARCHAR(255) NOT NULL, 
    citta VARCHAR(50) NOT NULL,
    PRIMARY KEY (pianta, nome_parco, citta), 
    FOREIGN KEY (pianta) REFERENCES Pianta(ID),
    FOREIGN KEY (nome_parco, citta) REFERENCES Parco_Botanico(nome_parco, citta)
);
