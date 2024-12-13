set "user=hurtownia_projekt@localhost"
set "password=hp"

pushd import

sqlldr USERID='%user%/%password%' CONTROL='kwartal_cfg.txt' LOG='kwartal.log'
sqlldr USERID='%user%/%password%' CONTROL='rok_cfg.txt' LOG='rok.log'
sqlldr USERID='%user%/%password%' CONTROL='okres_cfg.txt' LOG='okres.log'
sqlldr USERID='%user%/%password%' CONTROL='miejscowosc_cfg.txt' LOG='miejscowosc.log'
sqlldr USERID='%user%/%password%' CONTROL='wojewodztwo_cfg.txt' LOG='wojewodztwo.log'
sqlldr USERID='%user%/%password%' CONTROL='wydawnictwo_cfg.txt' LOG='wydawnictwo.log'
sqlldr USERID='%user%/%password%' CONTROL='gatunek_cfg.txt' LOG='gatunek.log'
sqlldr USERID='%user%/%password%' CONTROL='ksiazka_cfg.txt' LOG='ksiazka.log'
sqlldr USERID='%user%/%password%' CONTROL='pracownik_cfg.txt' LOG='pracownik.log'
sqlldr USERID='%user%/%password%' CONTROL='miejsce_cfg.txt' LOG='miejsce.log'
sqlldr USERID='%user%/%password%' CONTROL='sprzedaz_cfg.txt' LOG='sprzedaz.log'

popd
