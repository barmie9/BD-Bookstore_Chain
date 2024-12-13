--okna
--Zmiany roczne zainteresowania ksiazkami danego ganunku
select id_gatunek, nazwa, rok, ilosc,
ilosc - (lag(ilosc, 1) over (partition by id_gatunek order by id_gatunek, rok))
as zmiana from (
    select g.id_gatunek, g.nazwa, r.nr_rok AS rok,
    sum(s.ilosc) ILOSC from sprzedaz s
    join ksiazka k on k.id_ksiazka = s.id_ksiazka
    join gatunek g on g.id_gatunek = k.id_gatunek
    JOIN okres o ON s.ID_OKRES = o.ID_OKRES
    JOIN rok r ON o.ID_ROK = r.ID_ROK
    group by r.NR_ROK, g.nazwa, g.id_gatunek
    order by g.id_gatunek
);

--Wyswietla srednia ilosc sprzedanych ksiazek w obecnym oraz poprzednich kwartalach danego roku dla wojewodztwa
select id_wojewodztwo, nazwa, rok, kwartal, ilosc,
round(avg(ilosc) over (partition by id_wojewodztwo, rok order by kwartal range between 3 preceding and current row), 2) as srednia
from (
    select w.id_wojewodztwo, w.nazwa, r.nr_rok AS rok,
    kw.numer AS kwartal, sum(s.ilosc) ilosc
    from SPRZEDAZ s
    join wojewodztwo w on s.id_wojewodztwo = w.id_wojewodztwo
    JOIN okres o ON s.ID_OKRES = o.ID_OKRES
    JOIN KWARTAL kw ON o.ID_KWARTAL = kw.ID_KWARTAL
    JOIN rok r ON o.ID_ROK = r.ID_ROK
    group by w.id_wojewodztwo, w.nazwa, r.nr_rok, kw.numer
    order by w.id_wojewodztwo, w.nazwa, r.nr_rok, kw.numer
);

--Zmiany roczne zakupu ksi¹¿ek w województwach
SELECT id_wojewodztwo, nazwa, rok, ilosc, 
ilosc - (LAG(ilosc, 1) OVER (PARTITION BY id_wojewodztwo ORDER BY id_wojewodztwo, rok)) AS zmiana
FROM (
    SELECT w.id_wojewodztwo, nazwa, r.nr_rok AS rok, sum(s.ilosc) ilosc
    FROM SPRZEDAZ s
    JOIN okres o ON s.ID_OKRES = o.ID_OKRES
    JOIN rok r ON o.ID_ROK = r.ID_ROK
    JOIN WOJEWODZTWO w ON w.ID_WOJEWODZTWO = s.ID_WOJEWODZTWO
    GROUP BY w.id_wojewodztwo, nazwa, r.nr_rok
    ORDER BY w.id_wojewodztwo, nazwa, r.nr_rok
);
