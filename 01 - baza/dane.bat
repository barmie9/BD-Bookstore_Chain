set "user=student@localhost"
set "password=student"

pushd loader

sqlldr USERID='%user%/%password%' CONTROL='kod_pocztowy_cfg.txt' LOG='kod_pocztowy.log'
sqlldr USERID='%user%/%password%' CONTROL='miejscowosc_cfg.txt' LOG='miejscowosc.log'
sqlldr USERID='%user%/%password%' CONTROL='ulica_cfg.txt' LOG='ulica.log'
sqlldr USERID='%user%/%password%' CONTROL='wojewodztwo_cfg.txt' LOG='wojewodztwo.log'
sqlldr USERID='%user%/%password%' CONTROL='adres_cfg.txt' LOG='adres.log'
sqlldr USERID='%user%/%password%' CONTROL='ksiegarnia_cfg.txt' LOG='ksiegarnia.log'
sqlldr USERID='%user%/%password%' CONTROL='pracownik_cfg.txt' LOG='pracownik.log'
sqlldr USERID='%user%/%password%' CONTROL='klient_cfg.txt' LOG='klient.log'
sqlldr USERID='%user%/%password%' CONTROL='premia_cfg.txt' LOG='premia.log'
sqlldr USERID='%user%/%password%' CONTROL='wydawnictwo_cfg.txt' LOG='wydawnictwo.log'
sqlldr USERID='%user%/%password%' CONTROL='autor_cfg.txt' LOG='autor.log'
sqlldr USERID='%user%/%password%' CONTROL='gatunek_cfg.txt' LOG='gatunek.log'
sqlldr USERID='%user%/%password%' CONTROL='ksiazka_cfg.txt' LOG='ksiazka.log'
sqlldr USERID='%user%/%password%' CONTROL='autorzy_ksiazki_cfg.txt' LOG='autorzy_ksiazki.log'
sqlldr USERID='%user%/%password%' CONTROL='recenzja_ksiazki_cfg.txt' LOG='recenzja_ksiazki.log'
sqlldr USERID='%user%/%password%' CONTROL='stan_ksiazki_cfg.txt' LOG='stan_ksiazki.log'
sqlldr USERID='%user%/%password%' CONTROL='zakup_cfg.txt' LOG='zakup.log'

popd
