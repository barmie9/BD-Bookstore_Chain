-- funkcje rankingowe
--Ranking zakupu ksi¹¿ek w województwach
SELECT w.ID_WOJEWODZTWO, w.NAZWA, SUM(Z.ILOSC),
RANK() OVER (ORDER BY SUM(z.ILOSC) DESC) AS Miejsce
FROM ZAKUP z
JOIN STAN_KSIAZKI sk ON sk.ID_STAN_KSIAZKI = z.ID_STAN_KSIAZKI 
JOIN KSIEGARNIA k ON k.ID_KSIEGARNIA = sk.ID_KSIEGARNIA 
JOIN ADRES a ON a.ID_ADRES = k.ID_ADRES 
JOIN WOJEWODZTWO w ON w.ID_WOJEWODZTWO = a.ID_WOJEWODZTWO
GROUP BY w.ID_WOJEWODZTWO, w.NAZWA;

--Ranking iloœci sprzedanych ksi¹¿ek danego gatunku
SELECT g.ID_GATUNEK, g.NAZWA, SUM(Z.ILOSC),
RANK() OVER (ORDER BY SUM(z.ILOSC) DESC) AS Miejsce
FROM ZAKUP z
JOIN STAN_KSIAZKI sk ON sk.ID_STAN_KSIAZKI = z.ID_STAN_KSIAZKI 
JOIN KSIAZKA k ON k.ID_KSIAZKA = sk.ID_KSIAZKA
JOIN GATUNEK g ON g.ID_GATUNEK = k.ID_GATUNEK
GROUP BY g.ID_GATUNEK, g.NAZWA;

-- Ranking w którym województwie pracownicy otrzymali najwiêksza premie
select w.id_wojewodztwo, w.nazwa wojewodztwo, sum(p.wysokosc_premi) suma_woj,
rank() over (order by sum(p.wysokosc_premi) desc) as rank
from premia p
join pracownik pr on pr.id_pracownik = p.id_pracownik
join adres a on pr.id_adres = a.id_adres
join wojewodztwo w on a.id_wojewodztwo = w.id_wojewodztwo
group by w.id_wojewodztwo, w.nazwa;

