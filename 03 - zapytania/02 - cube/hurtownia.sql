-- Cube
--------------------------------------------------------------------------------
-- Ilosc ksiazek danego gatunku sprzedana przez pracownika, podsumowanie ilosci
-- ksiazek sprzedanych przez danego pracownika oraz podsumowanie ilosci
-- sprzedanych ksiazek danego gatunku przez wszystkich pracownikow
select z.id_pracownik, pr.imie, pr.nazwisko, z.id_gatunek, g.nazwa, z.ilosc from (
  select pr.id_pracownik, g.id_gatunek, count(g.id_gatunek) as ilosc
  from gatunek g
  join ksiazka k on k.id_gatunek = g.id_gatunek
  join sprzedaz s ON s.ID_KSIAZKA = k.ID_KSIAZKA
  join pracownik pr on pr.id_pracownik = s.id_pracownik
  group by cube(pr.id_pracownik, g.id_gatunek)
) z
left join pracownik pr on z.id_pracownik = pr.id_pracownik
left join gatunek g on z.id_gatunek = g.id_gatunek
order by pr.nazwisko, pr.imie, g.nazwa;

-- Ilosc ksiazek danego ganuku wydanych przez dane wydawnictwo, podsumowanie 
-- ksiazek wydanych przez wydawnictwo oraz podsumowanie ilosci wydanych ksiazek
-- danego gatunku
select z.id_wydaw, w.nazwa as wydawnictwo, g.id_gatunek,
g.nazwa as gatunek, z.razem from (
  select w.id_wydaw, g.id_gatunek, count(id_ksiazka) as razem
  from ksiazka k, wydawnictwo w, gatunek g where k.id_wydaw = w.id_wydaw
  and k.id_gatunek = g.id_gatunek group by cube(w.id_wydaw, g.id_gatunek)
) z
left join wydawnictwo w on z.id_wydaw = w.id_wydaw
left join gatunek g on z.id_gatunek = g.id_gatunek
order by w.nazwa, g.nazwa;

-- Ilosc egzemplazy ksiazek sprzedanych przez danego pracownika, podsumowanie
-- wszystkich ksiazek sprzedanych przez pracownika oraz ilosc egzamplazy danej
-- ksiazki sprzedanych przez wszystkich pracownikow
select z.id_pracownik, pr.imie, pr.nazwisko, z.id_ksiazka, k.tytul, z.razem from (
  select pr.id_pracownik, k.id_ksiazka, sum(s.ilosc) as razem
  from pracownik pr
  join sprzedaz s on s.id_pracownik = pr.id_pracownik
  join ksiazka k on k.id_ksiazka = s.id_ksiazka
  group by cube (pr.id_pracownik, k.id_ksiazka)
) z
left join pracownik pr on z.id_pracownik = pr.id_pracownik
left join ksiazka k on z.id_ksiazka = k.id_ksiazka
order by pr.nazwisko, pr.imie, k.tytul;

