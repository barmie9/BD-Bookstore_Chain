-- Rollup
-- Zestawienie wszystkich ksi¹¿ek sprzedanych przez wszytskich pracowników w województwie œwiêtkorzyskim, oraz ogólna iloœæ ksi¹¿ek sprzedana przez danego pracownika.
select z.id_pracownik, p.imie, p.nazwisko, z.id_ksiazka, k.tytul, z.ilosc from (
    select p.id_pracownik, k.id_ksiazka, sum(s.ilosc) as ilosc
    from sprzedaz s, ksiazka k, pracownik p, wojewodztwo w
    where s.id_ksiazka = k.id_ksiazka and p.id_pracownik = s.id_pracownik AND s.id_wojewodztwo = w.id_wojewodztwo
    and w.nazwa = 'œwiêtokrzyskie'
    group by rollup (p.id_pracownik, k.id_ksiazka)
) z
left join pracownik p on z.id_pracownik = p.id_pracownik
left join ksiazka k on z.id_ksiazka = k.id_ksiazka
order by p.nazwisko, p.imie, k.tytul;

-- Ile dane wydawnictwo wyda³o ksi¹¿ek danego gatunku oraz ich suma
select z.id_wydaw, w.nazwa as wydawnictwo, z.id_gatunek, g.nazwa as gatunek,
z.razem from (
  select w.id_wydaw, g.id_gatunek, count(id_ksiazka) as razem
  from ksiazka k, wydawnictwo w, gatunek g where k.id_wydaw = w.id_wydaw
  and k.id_gatunek = g.id_gatunek group by rollup(w.id_wydaw, g.id_gatunek)
) z
left join wydawnictwo w on z.id_wydaw = w.id_wydaw
left join gatunek g on z.id_gatunek = g.id_gatunek
order by w.nazwa, g.nazwa;

-- Ile dana ksiêgarnia sprzeda³a ksi¹¿ek danego gatunku i ich suma
select z.id_ksiegarnia, z.id_gatunek, g.nazwa as gatunek, z.razem from (
  select s.id_ksiegarnia, g.id_gatunek, sum(s.ilosc) as razem from gatunek g,
  ksiazka k, SPRZEDAZ s where k.id_ksiazka = s.id_ksiazka and k.id_gatunek = g.id_gatunek
  group by rollup(s.id_ksiegarnia, g.id_gatunek)
) z
left join gatunek g on z.id_gatunek = g.id_gatunek
order by z.id_ksiegarnia, g.nazwa;

