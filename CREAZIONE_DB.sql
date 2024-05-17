create database if not exists floraitaliana;
use floraitaliana;

create table Pianta(
ID INT primary key auto_increment,
nome_comune varchar(50) not null,
tipo_corologico INT not null,
forma_biologica varchar(8) not null
);

create table Tassonomia(
Pianta int primary key,
classe varchar(50) not null,
ordine varchar(50) not null,
famiglia varchar(50) not null,
sotto_famiglia varchar(50) not null,
genere varchar(50) not null,
specie varchar(50) not null,
foreign key (Pianta) references Pianta (ID)
);

create table Regione(
nome_regione varchar(30) primary key
);

create table Parco_Botanico (
Regione varchar(30) not null,
nome_parco varchar(255) not null,
città varchar(50) not null,
via varchar(255) not null,
cap int not null,
superficie float,
primary key (nome_parco, città),
foreign key (Regione) references Regione(nome_regione)
);

create table Immagine (
path varchar(255) primary key
);

create table Descrizione (
Pianta int not null,
path varchar(255) primary key,
foreign key (Pianta) references Pianta (ID)
);

create table lista_rossa (
Pianta int not null, 
categoria varchar(8) not null,
endemicità bool not null,
primary key(pianta),
foreign key (Pianta) references Pianta (ID)
);

create table Distribuzione(
pianta int not null, 
regione varchar(30) not null, 
status varchar(24), 
nome_locale varchar(50),
primary key(pianta,regione),
foreign key (Pianta) references Pianta (ID),
foreign key (Regione) references Regione(nome_regione)
);

create table Documentazione(
pianta int not null, 
immagine varchar(255) not null, 
primary key (pianta, immagine), 
foreign key (Pianta) references Pianta (ID), 
foreign key (immagine) references Immagine (path)
);

create table conservazione(
pianta int not null, 
nome_parco varchar(255) not null, 
città varchar(50) not null,
primary key(pianta, nome_parco, città), 
foreign key (Pianta) references Pianta (ID),
foreign key (nome_parco, città) references Parco_Botanico(nome_parco, città)
);

