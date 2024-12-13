--Partycje obliczeniowe
--Udzial gatunku w wojewodztwach
select id_wojewodztwo, nazwa_woj, id_gatunek, nazwa_gatunku, ilosc,
sum(ilosc) over (partition by id_wojewodztwo) ILOSC_WOJ,
round(100*ilosc/sum(ilosc) over (partition by id_wojewodztwo), 2) UDZIAL_PROC
FROM (
    select w.id_wojewodztwo, w.nazwa as nazwa_woj, sum(s.ilosc) as ilosc,
    g.id_gatunek, g.nazwa as nazwa_gatunku from sprzedaz s
    join wojewodztwo w on s.id_wojewodztwo = w.id_wojewodztwo
    join ksiazka k on s.id_ksiazka = k.id_ksiazka
    join gatunek g on k.id_gatunek = g.id_gatunek
    group by w.id_wojewodztwo, w.nazwa, g.id_gatunek, g.nazwa
);

--Udzial pracownikow w sprzedazy ksiazek w wojewodztwie
select id_wojewodztwo, nazwa_woj, id_pracownik, nazwisko, ilosc as ILOSC_PRACOWNIK,
sum(ilosc) over (partition by id_wojewodztwo) ILOSC_WOJ,
round(100*ilosc/sum(ilosc) over (partition by id_wojewodztwo), 2) UDZIAL_PROC
FROM (
    select w.id_wojewodztwo, w.nazwa as nazwa_woj, sum(s.ilosc) as ilosc,
    p.id_pracownik, p.nazwisko from SPRZEDAZ s
    join pracownik p on s.id_pracownik = p.id_pracownik
    join wojewodztwo w on s.id_wojewodztwo = w.id_wojewodztwo
    group by w.id_wojewodztwo, w.nazwa, p.id_pracownik, p.nazwisko
);

--Podsumowanie premii pracowników w wojewodztwie
select id_pracownik, nazwisko, id_wojewodztwo, wojewodztwo, suma_pracownik, 
sum(suma_pracownik) over (partition by wojewodztwo) suma_wojewodztwo from (
    select pr.id_pracownik, pr.nazwisko,  w.id_wojewodztwo, w.nazwa wojewodztwo, pr.suma_premii AS suma_pracownik
    from pracownik pr
    join wojewodztwo w on pr.id_wojewodztwo = w.id_wojewodztwo
    WHERE pr.suma_premii IS NOT NULL
    order by w.nazwa, pr.nazwisko
);
