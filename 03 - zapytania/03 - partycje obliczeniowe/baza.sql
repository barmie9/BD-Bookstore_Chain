--Partycje obliczeniowe
--Udzial gatunku w wojewodztwach
select id_wojewodztwo, nazwa_woj, id_gatunek, nazwa_gatunku, ilosc,
sum(ilosc) over (partition by id_wojewodztwo) ILOSC_WOJ,
round(100*ilosc/sum(ilosc) over (partition by id_wojewodztwo), 2) UDZIAL_PROC
FROM (
    select w.id_wojewodztwo, w.nazwa as nazwa_woj, sum(z.ilosc) as ilosc,
    g.id_gatunek, g.nazwa as nazwa_gatunku from zakup z
    join stan_ksiazki sk on z.id_stan_ksiazki = sk.id_stan_ksiazki
    join ksiegarnia ks on sk.id_ksiegarnia = ks.id_ksiegarnia
    join adres a on ks.id_adres = a.id_adres
    join wojewodztwo w on a.id_wojewodztwo = w.id_wojewodztwo
    join ksiazka k on sk.id_ksiazka = k.id_ksiazka
    join gatunek g on k.id_gatunek = g.id_gatunek
    group by w.id_wojewodztwo, w.nazwa, g.id_gatunek, g.nazwa
);

--Udzial pracownikow w sprzedazy ksiazek w wojewodztwie
select id_wojewodztwo, nazwa_woj, id_pracownik, nazwisko, ilosc as ILOSC_PRACOWNIK,
sum(ilosc) over (partition by id_wojewodztwo) ILOSC_WOJ,
round(100*ilosc/sum(ilosc) over (partition by id_wojewodztwo), 2) UDZIAL_PROC
FROM (
    select w.id_wojewodztwo, w.nazwa as nazwa_woj, sum(z.ilosc) as ilosc,
    p.id_pracownik, p.nazwisko from zakup z
    join pracownik p on z.id_pracownik = p.id_pracownik
    join stan_ksiazki sk on z.id_stan_ksiazki = sk.id_stan_ksiazki
    join ksiegarnia ks on sk.id_ksiegarnia = ks.id_ksiegarnia
    join adres a on ks.id_adres = a.id_adres
    join wojewodztwo w on a.id_wojewodztwo = w.id_wojewodztwo
    group by w.id_wojewodztwo, w.nazwa, p.id_pracownik, p.nazwisko
);

--Podsumowanie premii pracowników w wojewodztwie
select id_pracownik, nazwisko, id_wojewodztwo, wojewodztwo, suma_pracownik, 
sum(suma_pracownik) over (partition by wojewodztwo) suma_wojewodztwo from (
    select pr.id_pracownik, pr.nazwisko,  w.id_wojewodztwo, w.nazwa wojewodztwo,
    sum(p.wysokosc_premi) suma_pracownik
    from premia p
    join pracownik pr on pr.id_pracownik = p.id_pracownik
    join adres a on pr.id_adres = a.id_adres
    join wojewodztwo w on a.id_wojewodztwo = w.id_wojewodztwo
    group by pr.id_pracownik, pr.nazwisko,  w.id_wojewodztwo, w.nazwa
    order by w.nazwa, pr.nazwisko
);
