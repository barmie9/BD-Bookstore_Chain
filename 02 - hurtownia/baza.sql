DROP TABLE sprzedaz;
DROP TABLE pracownik;
DROP TABLE okres;
DROP TABLE ksiazka;
DROP TABLE kwartal;
DROP TABLE rok;
DROP TABLE wydawnictwo;
DROP TABLE gatunek;
DROP TABLE wojewodztwo;


create table kwartal(
    id_kwartal NUMBER(6) PRIMARY KEY,
    numer NUMBER(1) NOT NULL
    );


create table rok(
    id_rok NUMBER(6) PRIMARY KEY,
    nr_rok NUMBER(4) NOT NULL
    );


create table wydawnictwo(
    id_wydaw NUMBER(6) PRIMARY KEY,
    nazwa VARCHAR2(100) NOT NULL
    );
    

create table gatunek(
    id_gatunek NUMBER(6) PRIMARY KEY,
    nazwa VARCHAR2(60) NOT NULL
    );

create table wojewodztwo(
    id_wojewodztwo NUMBER(6) PRIMARY KEY,
    nazwa VARCHAR2(25) NOT NULL
    );
----------------------------
create table pracownik(
    id_pracownik NUMBER(6) PRIMARY KEY,
    pensja NUMBER(6) NOT NULL,
    imie VARCHAR2(40) NOT NULL,
    nazwisko VARCHAR2(50) NOT NULL,
    suma_premii NUMBER(6) NULL, 
    id_wojewodztwo NUMBER(6) NOT NULL,
    CONSTRAINT fk_wojewodztwo_pr_pracownik FOREIGN KEY (id_wojewodztwo) REFERENCES wojewodztwo(id_wojewodztwo)
    );

create table okres(
    id_okres NUMBER(6) PRIMARY KEY,
    id_kwartal NUMBER(6) NOT NULL,
    id_rok NUMBER(6) NOT NULL,
    CONSTRAINT fk_kwartal_okres FOREIGN KEY (id_kwartal) REFERENCES kwartal(id_kwartal),
    CONSTRAINT fk_rok_okres FOREIGN KEY (id_rok) REFERENCES rok(id_rok)
    );


create table ksiazka(
    id_ksiazka NUMBER(6) PRIMARY KEY,
    tytul VARCHAR2(60) NOT NULL,
    cena NUMBER(4) NOT NULL,
    id_wydaw NUMBER(6) NOT NULL,
    id_gatunek NUMBER(6) NOT NULL,
    CONSTRAINT fk_wydaw_ksiazka FOREIGN KEY (id_wydaw) REFERENCES wydawnictwo(id_wydaw),
    CONSTRAINT fk_gatunek_ksiazka FOREIGN KEY (id_gatunek) REFERENCES gatunek(id_gatunek)
    );

create table sprzedaz(
    id_sprzedaz NUMBER(6) PRIMARY KEY,
    zarobek NUMBER(9) NOT NULL,
    ilosc NUMBER(6) NOT NULL,
    id_okres NUMBER(6) NOT NULL,
    id_ksiazka NUMBER(6) NOT NULL,
    id_ksiegarnia NUMBER(6) NOT NULL,
    id_wojewodztwo NUMBER(6) NOT NULL,
    id_pracownik NUMBER(6) NOT NULL,
    CONSTRAINT fk_okres_sprzedaz FOREIGN KEY (id_okres) REFERENCES okres(id_okres),
    CONSTRAINT fk_ksiazka_sprzedaz FOREIGN KEY (id_ksiazka) REFERENCES ksiazka(id_ksiazka),
    CONSTRAINT fk_wojewodztwo_sprzedaz FOREIGN KEY (id_wojewodztwo) REFERENCES wojewodztwo(id_wojewodztwo),
    CONSTRAINT fk_pracownik_sprzedaz FOREIGN KEY (id_pracownik) REFERENCES pracownik(id_pracownik)
    );