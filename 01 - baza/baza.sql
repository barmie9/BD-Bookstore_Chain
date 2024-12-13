DROP TABLE zakup;
DROP TABLE stan_ksiazki;
DROP TABLE recenzja_ksiazki;
DROP TABLE autorzy_ksiazki;
DROP TABLE autor;
DROP TABLE ksiazka;
DROP TABLE gatunek;
DROP TABLE wydawnictwo;
DROP TABLE klient;
DROP TABLE premia;
DROP TABLE pracownik;
DROP TABLE ksiegarnia;
DROP TABLE adres;
DROP TABLE kod_pocztowy;
DROP TABLE wojewodztwo;
DROP TABLE miejscowosc;
DROP TABLE ulica;

CREATE TABLE kod_pocztowy(
    id_kod_pocztowy NUMBER(6) PRIMARY KEY,
    nazwa VARCHAR2(6) NOT NULL
    );

CREATE TABLE wojewodztwo(
    id_wojewodztwo NUMBER(6) PRIMARY KEY,
    nazwa VARCHAR2(20) NOT NULL
    );

CREATE TABLE miejscowosc(
    id_miejscowosc NUMBER(6) PRIMARY KEY,
    nazwa VARCHAR2(20) NOT NULL
    );

CREATE TABLE ulica(
    id_ulica NUMBER(6) PRIMARY KEY,
    nazwa VARCHAR2(60) NOT NULL
    );

CREATE TABLE adres(
    id_adres NUMBER(6) PRIMARY KEY,
    nr_budynku NUMBER(6),
    nr_mieszkania NUMBER(4) NULL,
    id_ulica NUMBER(6) NOT NULL,
    id_miejscowosc NUMBER(6) NOT NULL,
    id_wojewodztwo NUMBER(6) NOT NULL,
    id_kod_pocztowy NUMBER(6) NOT NULL,
    CONSTRAINT fk_ulica_adres FOREIGN KEY (id_ulica) REFERENCES ulica (id_ulica),
    CONSTRAINT fk_miejscowosc_adres FOREIGN KEY (id_miejscowosc) REFERENCES miejscowosc (id_miejscowosc),
    CONSTRAINT fk_wojewodztwo_adres FOREIGN KEY (id_wojewodztwo) REFERENCES wojewodztwo (id_wojewodztwo),
    CONSTRAINT fk_kod_pocztowy_adres FOREIGN KEY (id_kod_pocztowy) REFERENCES kod_pocztowy (id_kod_pocztowy)
    );

CREATE TABLE ksiegarnia(
    id_ksiegarnia NUMBER(6) PRIMARY KEY,
    id_adres NUMBER(6) NOT NULL,
    CONSTRAINT fk_adres_ksiegarnia FOREIGN KEY (id_adres) REFERENCES adres (id_adres)
    );

CREATE TABLE pracownik(
    id_pracownik NUMBER(6) PRIMARY KEY,
    imie VARCHAR2(20) NOT NULL,
    nazwisko VARCHAR2(30) NOT NULL,
    email VARCHAR2(50) NOT NULL,
    nr_tel VARCHAR2(12) NOT NULL,
    pesel NUMBER(11) NOT NULL,
    data_urodzenia DATE NOT NULL,
    data_zatrudnienia DATE NOT NULL,
    pensja NUMBER(6) NOT NULL,
    id_ksiegarnia NUMBER(6) NOT NULL,
    id_adres NUMBER(6) NOT NULL,
    CONSTRAINT fk_ksiegarnia FOREIGN KEY (id_ksiegarnia) REFERENCES ksiegarnia (id_ksiegarnia),
    CONSTRAINT fk_adres_pracownik FOREIGN KEY (id_adres) REFERENCES adres (id_adres)
    );

CREATE TABLE premia(
    id_premia NUMBER(6) PRIMARY KEY,
    wysokosc_premi NUMBER(6) NOT NULL,
    opis VARCHAR2(100) NULL,
    data DATE NOT NULL,
    id_pracownik NUMBER(6) NOT NULL,
    CONSTRAINT fk_pracownik_premia FOREIGN KEY (id_pracownik) REFERENCES pracownik (id_pracownik)
    );

CREATE TABLE klient(
    id_klient NUMBER(6) PRIMARY KEY,
    imie VARCHAR2(20) NOT NULL,
    nazwisko VARCHAR2(30) NOT NULL,
    email VARCHAR2(60) NULL,
    nr_tel VARCHAR2(12) NULL
    );

CREATE TABLE wydawnictwo(
    id_wydawnictwo NUMBER(6) PRIMARY KEY,
    nazwa VARCHAR2(80) NOT NULL
    );

CREATE TABLE gatunek(
    id_gatunek NUMBER(6) PRIMARY KEY,
    nazwa VARCHAR2(50) NOT NULL,
    opis VARCHAR2(100) NULL
    );

CREATE TABLE ksiazka(
    id_ksiazka NUMBER(6) PRIMARY KEY,
    tytul VARCHAR2(30) NOT NULL,
    cena NUMBER(5) NOT NULL,
    id_gatunek NUMBER(6) NOT NULL,
    id_wydawnictwo NUMBER(6) NOT NULL,
    CONSTRAINT fk_gatunek_ksiazka FOREIGN KEY (id_gatunek) REFERENCES gatunek (id_gatunek),
    CONSTRAINT fk_wydawnictwo_ksiazka FOREIGN KEY (id_wydawnictwo) REFERENCES wydawnictwo (id_wydawnictwo)
    );
    
CREATE TABLE autor(
    id_autor NUMBER(6) PRIMARY KEY,
    imie VARCHAR2(20) NOT NULL,
    nazwisko VARCHAR2(30) NOT NULL,
    data_urodzenia DATE NULL
    );

CREATE TABLE autorzy_ksiazki(
    id_autorzy_ksiazki NUMBER(6) PRIMARY KEY,
    id_ksiazka NUMBER(6) NOT NULL,
    id_autor NUMBER(6) NOT NULL,
    CONSTRAINT fk_ksiazka_autorzy_ksiazki FOREIGN KEY (id_ksiazka) REFERENCES ksiazka (id_ksiazka),
    CONSTRAINT fk_autor_autorzy_ksiazki FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
    );

CREATE TABLE recenzja_ksiazki(
    id_recenzja_ksiazki NUMBER(6) PRIMARY KEY,
    ocena NUMBER(1) NOT NULL,
    komentarz VARCHAR2(100) NULL,
    data_recenzji DATE NOT NULL,
    id_ksiazka NUMBER(6) NOT NULL,
    CONSTRAINT fk_ksiazka_recenzja_ksiazki FOREIGN KEY (id_ksiazka) REFERENCES ksiazka (id_ksiazka)
    );

CREATE TABLE stan_ksiazki(
    id_stan_ksiazki NUMBER(7) PRIMARY KEY,
    ilosc NUMBER(7) NOT NULL,
    id_ksiazka NUMBER(6) NOT NULL,
    id_ksiegarnia NUMBER(6) NOT NULL,
    CONSTRAINT fk_ksiazka_stan_ksiazki FOREIGN KEY (id_ksiazka) REFERENCES ksiazka (id_ksiazka),
    CONSTRAINT fk_ksiegarnia_stan_ksiazki FOREIGN KEY (id_ksiegarnia) REFERENCES ksiegarnia (id_ksiegarnia)
    );

CREATE TABLE zakup(
    id_zakup NUMBER(6) PRIMARY KEY,
    ilosc NUMBER(5) NOT NULL,
    data_zakupu DATE NOT NULL,
    id_pracownik NUMBER(6) NOT NULL,
    id_klient NUMBER(6) NOT NULL,
    id_stan_ksiazki NUMBER(6) NOT NULL,
    CONSTRAINT fk_pracownik_zakup FOREIGN KEY (id_pracownik) REFERENCES pracownik (id_pracownik),
    CONSTRAINT fk_klient_zakup FOREIGN KEY (id_klient) REFERENCES klient (id_klient),
    CONSTRAINT fk_stan_ksiazki_zakup FOREIGN KEY (id_stan_ksiazki) REFERENCES stan_ksiazki (id_stan_ksiazki)
    );

