-- sprzedaz
select z.id_zakup as id_sprzedaz, k.cena*z.ilosc as zarobek, z.ilosc, to_char(z.data_zakupu,'Q') + (4*(to_char(z.data_zakupu,'YYYY')-2017))  id_okres,k.id_ksiazka, s_k.ID_KSIEGARNIA, a.ID_WOJEWODZTWO  as id_wojewodztwo, p.id_pracownik
from zakup z
join stan_ksiazki s_k on z.id_stan_ksiazki = s_k.id_stan_ksiazki
join ksiazka k on s_k.id_ksiazka = k.id_ksiazka
join ksiegarnia ksie on s_k.id_ksiegarnia = ksie.id_ksiegarnia
JOIN ADRES a ON a.ID_ADRES = ksie.ID_ADRES
join pracownik p on z.id_pracownik = p.id_pracownik
order by z.id_zakup;

-- pracownik
select p.id_pracownik, p.pensja, p.imie, p.nazwisko,
sum(pr.wysokosc_premi) as suma_premii, a.id_wojewodztwo
from pracownik p
join adres a on p.id_adres = a.id_adres
left join premia pr on pr.id_pracownik = p.id_pracownik
group by p.id_pracownik, p.pensja, p.imie, p.nazwisko, a.id_wojewodztwo
order by p.id_pracownik;

-- miejsce
select k.id_ksiegarnia as id_miejsce, a.id_miejscowosc, a.id_wojewodztwo
from ksiegarnia k
join adres a on k.id_adres = a.id_adres order by k.id_ksiegarnia;

-- ksiazka
select k.id_ksiazka, k.tytul, k.cena, k.id_wydawnictwo as id_wydaw, k.id_gatunek
from ksiazka k;

-- wydawnictwo
select id_wydawnictwo as id_wydaw, nazwa from wydawnictwo;

-- gatunek
select id_gatunek, nazwa from gatunek;

-- miejscowosc
select id_miejscowosc, nazwa from miejscowosc;

-- wojewodztwo
select id_wojewodztwo, nazwa from wojewodztwo;
