-- Rollup
-- Zestawienie wszystkich ksi¹¿ek sprzedanych przez wszytskich pracowników w województwie œwiêtkorzyskim, oraz ogólna iloœæ ksi¹¿ek sprzedana przez danego pracownika.
select z.id_pracownik, p.imie, p.nazwisko, z.id_ksiazka, k.tytul, z.ilosc from (
select p.id_pracownik, k.id_ksiazka, sum(z.ilosc) as ilosc
from zakup z, stan_ksiazki s_k, ksiazka k, pracownik p, ksiegarnia ks, adres a, wojewodztwo w
where z.id_stan_ksiazki = s_k.id_stan_ksiazki and s_k.id_ksiazka = k.id_ksiazka and p.id_pracownik = z.id_pracownik
    and ks.id_ksiegarnia = s_k.id_ksiegarnia and a.id_adres = ks.id_adres and a.id_wojewodztwo = w.id_wojewodztwo
    and w.nazwa = 'œwiêtokrzyskie'
group by  rollup (p.id_pracownik, k.id_ksiazka)
) z
left join pracownik p on z.id_pracownik = p.id_pracownik
left join ksiazka k on z.id_ksiazka = k.id_ksiazka
order by p.nazwisko, p.imie, k.tytul;

-- Ile dane wydawnictwo wyda³o ksi¹¿ek danego gatunku oraz ich suma
select z.id_wydawnictwo, w.nazwa as wydawnictwo, z.id_gatunek, g.nazwa as gatunek,
z.razem from (
  select w.id_wydawnictwo, g.id_gatunek, count(id_ksiazka) as razem
  from ksiazka k, wydawnictwo w, gatunek g where k.id_wydawnictwo = w.id_wydawnictwo
  and k.id_gatunek = g.id_gatunek group by rollup(w.id_wydawnictwo, g.id_gatunek)
) z
left join wydawnictwo w on z.id_wydawnictwo = w.id_wydawnictwo
left join gatunek g on z.id_gatunek = g.id_gatunek
order by w.nazwa, g.nazwa;

-- Ile dana ksiêgarnia sprzeda³a ksi¹¿ek danego gatunku i ich suma
select z.id_ksiegarnia, z.id_gatunek, g.nazwa as gatunek, z.razem from (
  select ks.id_ksiegarnia, g.id_gatunek, sum(z.ilosc) as razem from ksiegarnia ks, gatunek g,
  ksiazka k, stan_ksiazki s, zakup z where ks.id_ksiegarnia = s.id_ksiegarnia
  and k.id_ksiazka = s.id_ksiazka and k.id_gatunek = g.id_gatunek
  and z.id_stan_ksiazki = s.id_stan_ksiazki
  group by rollup(ks.id_ksiegarnia, g.id_gatunek)
) z
left join gatunek g on z.id_gatunek = g.id_gatunek
order by z.id_ksiegarnia, g.nazwa;

