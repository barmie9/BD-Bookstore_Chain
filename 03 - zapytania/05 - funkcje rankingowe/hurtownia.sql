-- funkcje rankingowe
--Ranking zakupu ksi¹¿ek w województwach
SELECT w.ID_WOJEWODZTWO, w.NAZWA, SUM(S.ILOSC),
RANK() OVER (ORDER BY SUM(s.ILOSC) DESC) AS Miejsce
FROM SPRZEDAZ s
JOIN WOJEWODZTWO w ON w.ID_WOJEWODZTWO = s.ID_WOJEWODZTWO
GROUP BY w.ID_WOJEWODZTWO, w.NAZWA;

--Ranking iloœci sprzedanych ksi¹¿ek danego gatunku
SELECT g.ID_GATUNEK, g.NAZWA, SUM(s.ILOSC),
RANK() OVER (ORDER BY SUM(s.ILOSC) DESC) AS Miejsce
FROM SPRZEDAZ s 
JOIN KSIAZKA k ON k.ID_KSIAZKA = s.ID_KSIAZKA
JOIN GATUNEK g ON g.ID_GATUNEK = k.ID_GATUNEK
GROUP BY g.ID_GATUNEK, g.NAZWA;

-- Ranking w którym województwie pracownicy otrzymali najwiêksza premie
select w.id_wojewodztwo, w.nazwa wojewodztwo, sum(pr.SUMA_PREMII) suma_woj,
rank() over (order by sum(pr.SUMA_PREMII) desc) as rank
from pracownik pr
join wojewodztwo w on pr.id_wojewodztwo = w.id_wojewodztwo
group by w.id_wojewodztwo, w.nazwa;
