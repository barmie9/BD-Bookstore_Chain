--okna
--Zmiany roczne zainteresowania ksiazkami danego ganunku
select id_gatunek, nazwa, rok, ilosc,
ilosc - (lag(ilosc, 1) over (partition by id_gatunek order by id_gatunek, rok))
as zmiana from (
    select g.id_gatunek, g.nazwa, EXTRACT(YEAR from z.data_zakupu) ROK,
    sum(z.ilosc) ILOSC from zakup z
    join stan_ksiazki sk on sk.id_stan_ksiazki = z.id_stan_ksiazki
    join ksiazka k on k.id_ksiazka = sk.id_ksiazka
    join gatunek g on g.id_gatunek = k.id_gatunek
    group by EXTRACT(YEAR from data_zakupu), g.nazwa, g.id_gatunek
    order by g.id_gatunek
);

--Wyswietla srednia ilosc sprzedanych ksiazek w obecnym oraz poprzednich kwartalach danego roku dla wojewodztwa
select id_wojewodztwo, nazwa, rok, kwartal, ilosc,
round(avg(ilosc) over (partition by id_wojewodztwo, rok order by kwartal range between 3 preceding and current row), 2) as srednia
from (
    select w.id_wojewodztwo, w.nazwa, EXTRACT(YEAR from z.data_zakupu) rok,
    TO_NUMBER(TO_CHAR(z.data_zakupu, 'Q')) kwartal, sum(z.ilosc) ilosc
    from zakup z
    join stan_ksiazki sk on z.id_stan_ksiazki = sk.id_stan_ksiazki
    join ksiegarnia ks on sk.id_ksiegarnia = ks.id_ksiegarnia
    join adres a on ks.id_adres = a.id_adres
    join wojewodztwo w on a.id_wojewodztwo = w.id_wojewodztwo
    group by w.id_wojewodztwo, w.nazwa, EXTRACT(YEAR from z.data_zakupu), TO_NUMBER(TO_CHAR(z.data_zakupu, 'Q'))
    order by w.id_wojewodztwo, w.nazwa, EXTRACT(YEAR from z.data_zakupu), TO_NUMBER(TO_CHAR(z.data_zakupu, 'Q'))
);

--Zmiany roczne zakupu ksi¹¿ek w województwach
SELECT id_wojewodztwo, nazwa, rok, ilosc, 
ilosc - (LAG(ilosc, 1) OVER (PARTITION BY id_wojewodztwo ORDER BY id_wojewodztwo, rok)) AS zmiana
FROM (
    SELECT w.id_wojewodztwo, nazwa, EXTRACT(YEAR FROM z.data_zakupu) rok, sum(z.ilosc) ilosc
    FROM ZAKUP z
    JOIN STAN_KSIAZKI sk ON sk.ID_STAN_KSIAZKI = z.ID_STAN_KSIAZKI
    JOIN KSIEGARNIA ks ON ks.ID_KSIEGARNIA = sk.ID_KSIEGARNIA 
    JOIN ADRES a ON a.ID_ADRES = ks.ID_ADRES 
    JOIN WOJEWODZTWO w ON w.ID_WOJEWODZTWO = a.ID_WOJEWODZTWO
    GROUP BY w.id_wojewodztwo, nazwa, EXTRACT(YEAR FROM z.data_zakupu)
    ORDER BY w.id_wojewodztwo, nazwa, EXTRACT(YEAR FROM z.data_zakupu)
);
