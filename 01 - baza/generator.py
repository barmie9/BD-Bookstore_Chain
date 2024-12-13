import random
import json
import random
import urllib.request

def get_random(lista):
    return random.choice(lista)


class Non_repeat_random(object):
    def __init__(self,my_list):
        self.my_list = my_list
        self.drawn = []
    def get_random(self):
        while True:
            my_random = random.choice(self.my_list)
            if my_random not in self.drawn:
                self.drawn.append(my_random)
                return my_random

def add_id(file_path_in,file_path_out):
    f_in = open(file_path_in, "r", encoding="utf-8")  # otwarcie pliku
    list_of_rows = f_in.readlines()
    f_in.close()
    
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    my_id = 1 
    
    for x in list_of_rows:
        row = str(my_id) + "," + x
        print(row)
        my_id += 1
        f_out.write(row)
    
    f_out.close()

#Tworzy adresy, nalezy podać ilosc wierszy, maxymalne wartosci kluczy obcych, nr_bud,nr_miesz, oraz sciezke pliku zapisu
#Uwaga!! liczba wierszy nie moze być wieksza od liczby kodow pocztowych*10 oraz miast*10.
def address_generator(address_rows_number, num_kod_poczt,num_woje,num_miejsc,num_ulic,num_nr_bud,num_nr_miesz,file_path_out):
    non_repeat_miejsc = Non_repeat_random(range(1,num_miejsc+1))
    
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    my_id = 1
    for x in range(int(address_rows_number/10)): # Tworzenie 10 adresow w jednym miescie
        miejscowosc = non_repeat_miejsc.get_random()
        wojewodztwo = get_random(range(1,num_woje+1))
        non_repeat_kod = Non_repeat_random(range(1,num_kod_poczt+1))
        non_repeat_ulica = Non_repeat_random(range(1,num_ulic+1))
        for y in range(10):
             ulica = non_repeat_ulica.get_random()
             kod_pocztowy = non_repeat_kod.get_random()
             row = str(my_id)+","+ str(get_random(range(1,num_nr_bud+1)))+","+str(get_random(range(1,num_nr_miesz+1)))+","+str(ulica)+","+str(miejscowosc)+","+str(wojewodztwo)+","+str(kod_pocztowy)+"\n"
             f_out.write(row)
             my_id += 1
             
    f_out.close()

# rows_number nie moze byc wieksze niz num_addres
def ksiegarnia_generator(rows_number, num_addres,file_path_out):
    my_id = 1
    
    adres_ksiegarni = Non_repeat_random(range(1,num_addres+1))
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    
    for x in range(rows_number):
        row = str(my_id)+","+str(adres_ksiegarni.get_random())+"\n"
        f_out.write(row)
        my_id += 1
    
    f_out.close()

def dodaj_cudzysłow (file_path_in,file_path_out):
    f_in = open(file_path_in, "r", encoding="utf-8")  # otwarcie pliku
    list_of_rows = f_in.readlines()
    f_in.close()
    
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    
    for x in list_of_rows:
        #row = "'"+x+"'"+","+"\n"
        #row = "'"+x.rstrip('\n')+"'"+"\n"
        row = '"'+x.rstrip('\n')+'"'+","+"\n"
        f_out.write(row)
    
    f_out.close()

def autor_generator(num_rows,file_path_name,file_path_surname,file_path_out):
    f_name= open(file_path_name, "r", encoding="utf-8")  # otwarcie pliku
    f_surname = open(file_path_surname, "r", encoding="utf-8")  # otwarcie pliku
    list_of_name = f_name.readlines()
    list_of_surname = f_surname.readlines()
    f_name.close()
    f_surname.close()
    
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    
    for x in range(1,num_rows+1):
        name = get_random(list_of_name)
        surname = get_random(list_of_surname)
        date = str(get_random(range(1000,2021)))+"/"+str(get_random(range(1,13)))+"/"+str(get_random(range(1,28)))
        row = str(x) + ','+name.rstrip('\n') + ","+surname.rstrip('\n') + ","+ date +"\n"
        f_out.write(row)       

def pracownik_generator(num_rows,file_path_name,file_path_surname,file_path_pesel, file_path_out,num_ksiegarnia,num_adress):
    f_name= open(file_path_name, "r", encoding="utf-8")  # otwarcie pliku
    f_surname = open(file_path_surname, "r", encoding="utf-8")  # otwarcie pliku
    f_pesel = open(file_path_pesel, "r", encoding="utf-8")  # otwarcie pliku
    list_of_name = f_name.readlines()
    list_of_surname = f_surname.readlines()
    list_of_pesel = f_pesel.readlines()
    f_name.close()
    f_surname.close()
    f_pesel.close()
    
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    
    non_repeat_pesel = Non_repeat_random(list_of_pesel)
    non_repeat_number_1 = Non_repeat_random(range(num_rows))
    non_repeat_number_2 = Non_repeat_random(range(111111111,999999999))
    
    for x in range(1,num_rows+1):
        imie = get_random(list_of_name).rstrip('\n')
        nazwisko = get_random(list_of_surname).rstrip('\n')
        email = imie.rstrip('\n') +"."+ nazwisko.rstrip('\n') + "."+str(non_repeat_number_1.get_random())+"@gmail.com"
        nr_tel = str(non_repeat_number_2.get_random())
        pesel = non_repeat_pesel.get_random().rstrip('\n')
        day =  pesel[4:6]
        month = pesel[2:4]
        year = "19" + pesel[0:2]
        data_urodzenia = year +"/"+ month +"/"+ day
        data_zatrudnienia = str(get_random(range(2015,2017)))+"/"+str(get_random(range(1,13)))+"/"+str(get_random(range(1,28)))
        pensja = str(get_random(range(2000,10000)))
        id_ksiegarnia = str(get_random(range(1,num_ksiegarnia+1)))
        id_adres = str(get_random(range(1,num_adress+1)))
        
        row = str(x) +","+ imie +","+ nazwisko +","+ email +","+ nr_tel +","+ pesel +","+ data_urodzenia +","+ data_zatrudnienia +","+ pensja +","+ id_ksiegarnia +","+ id_adres +","+ "\n"
        f_out.write(row)
    f_out.close()
    
        
def premia_generator(num_rows, file_path_out,num_pracownik):
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    
    opis_list = ["Największa sprzedaż", "Punktualnośc", "Ciekawe Pomysły", "Wysoka sprzedaż"]
    
    
    for x in range(1,num_rows+1):
        wysokosc_premi = str(get_random(range(500,2000)))
        opis = get_random(opis_list)
        data = str(get_random(range(2017,2021)))+"/"+str(get_random(range(1,13)))+"/"+str(get_random(range(1,28)))
        id_pracownik = str(get_random(range(1,num_pracownik+1)))
        
        row = str(x) +","+ wysokosc_premi +","+ opis  +","+ data +","+  id_pracownik + "\n"
        f_out.write(row)
    
    f_out.close()
    

def klient_generator(num_rows,file_path_name,file_path_surname, file_path_out):
    f_name= open(file_path_name, "r", encoding="utf-8")  # otwarcie pliku
    f_surname = open(file_path_surname, "r", encoding="utf-8")  # otwarcie pliku
    
    list_of_name = f_name.readlines()
    list_of_surname = f_surname.readlines()
    f_name.close()
    f_surname.close()
    
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    
    non_repeat_number_1 = Non_repeat_random(range(num_rows))
    non_repeat_number_2 = Non_repeat_random(range(111111111,999999999))
    
    for x in range(1,num_rows+1):
        imie = get_random(list_of_name).rstrip('\n')
        nazwisko = get_random(list_of_surname).rstrip('\n')
        email = imie.rstrip('\n') +"."+ nazwisko.rstrip('\n') + "."+str(non_repeat_number_1.get_random())+"@wp.pl"
        nr_tel = str(non_repeat_number_2.get_random())
        row = str(x) +","+ imie +","+  nazwisko  +","+ email +","+  nr_tel + "\n"
        f_out.write(row)
    
    f_out.close()

def ksiazka_generator(num_rows,num_gatunek,num_wydawnictwo,file_path_out):
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    url = urllib.request.urlopen("https://raw.githubusercontent.com/sindresorhus/mnemonic-words/master/words.json")
    words = json.loads(url.read())

    rand_words_1 = Non_repeat_random(words)

    my_id = 1 
    for x in range(int(num_rows/20)):
        tytul_1 = rand_words_1.get_random()
        for y in range(20):
            tytul_2 = get_random(words)
            tytul = tytul_1 + " " + tytul_2
            cena = str(get_random(range(9,400)))
            id_gatunek = str(get_random(range(1,num_gatunek+1)))
            id_wydawnictwo = str(get_random(range(1,num_wydawnictwo+1)))
            row = str(my_id) +","+ tytul +","+  cena +","+  id_gatunek +","+  id_wydawnictwo + "\n"
            f_out.write(row)
            my_id += 1  
        
    f_out.close()


def gatunek_generator(file_path_in,file_path_out):
    f_in = open(file_path_in, "r", encoding="utf-8")  # otwarcie pliku
    gatunki = f_in.readlines()
    f_in.close()
    
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    
    opisy = ["Gatunek swietny dla rozwoju osobistego", "Śmieszne i nie tylko", "Nie dla dzieci", "Wciaga w kazdym wieku", "Gatunek stary jak swiat", "Nikt ni chciał kazdy potrzebował"]
    
    my_id = 1 
    for x in gatunki:
        row = str(my_id) +","+ x.rstrip("\n") +","+ get_random(opisy) +"\n"
        f_out.write(row)
        my_id += 1
    
    f_out.close()


def autorzy_ksiazki_generator(num_ksiazka,num_autor,file_path_out):
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    
    losowanie = [1,2]
    my_id = 1 
    for x in range(1,num_ksiazka+1):
        if(get_random(losowanie) == 1):
            id_autor = str(get_random(range(1,num_autor+1)))
            row = str(my_id)  +","+ str(x)   +","+ id_autor + "\n"
            my_id += 1
            f_out.write(row)
        else:
            id_autor = str(get_random(range(1,num_autor+1)))
            row = str(my_id)  +","+ str(x)   +","+ id_autor + "\n"
            my_id += 1
            f_out.write(row)
            
            id_autor = str(get_random(range(1,num_autor+1)))
            row = str(my_id)  +","+ str(x)  +","+ id_autor + "\n"
            my_id += 1
            f_out.write(row)
        
        
    f_out.close()

def recenzja_ksiazki_generator(num_rows,num_ksiazka,file_path_out):
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie pliku
    
    komentarze = ["Dobra ale są lepsze", "Moze być", "Kupilem wiele ksiazek","Od tego sprzedawcy kupuje raz", "Udana transakcja"]
    
    for x in range(1,num_rows+1):
        ocena = str(get_random(range(1,6)))
        komentarz = get_random(komentarze)
        data_recenzji = str(get_random(range(2000,2021)))+"/"+str(get_random(range(1,13)))+"/"+str(get_random(range(1,28)))
        id_ksiazka = str(get_random(range(1,num_ksiazka+1)))
        row = str(x) +","+ ocena +","+ komentarz +","+ data_recenzji +","+  id_ksiazka + "\n"
        f_out.write(row)
    f_out.close()

def stan_ksiazki_generator(num_ksiazka,num_ksiegarnia,file_path_out):
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie 
    
    my_id = 1
    for x in range(1,num_ksiazka+1):
        for y in range(1,num_ksiegarnia+1):
            ilosc = str(get_random(range(100)))
            row = str(my_id) +","+ ilosc +","+ str(x) +","+ str(y) + "\n"
            my_id += 1
            f_out.write(row)
    f_out.close()

def zakup_generator(num_rows,num_pracownik,num_klient,num_stan_ksiazki,file_path_out):
    f_out = open(file_path_out, "w", encoding="utf-8")  # otwarcie
    
    for x in range(1,num_rows+1):
        ilosc = str(get_random(range(1,4)))
        data_zakupu = str(get_random(range(2017,2021)))+"/"+str(get_random(range(1,13)))+"/"+str(get_random(range(1,28)))
        id_pracownik = str(get_random(range(1,num_pracownik+1)))
        id_klient = str(get_random(range(1,num_klient+1)))
        id_stan_ksiazki = str(get_random(range(1,num_stan_ksiazki+1)))
        
        row = str(x)  +","+ ilosc +","+ data_zakupu +","+ id_pracownik +","+ id_klient +","+ id_stan_ksiazki + "\n"
        f_out.write(row)
    
    f_out.close()



##################               Tworzenie plików:                ####################
add_id("kod_pocztowy.txt", "kod_pocztowy.txt")
add_id("wojewodztwo.txt", "wojewodztwo.txt")
add_id("miejscowosc.txt", "miejscowosc.txt")
add_id("ulica.txt", "ulica.txt")
address_generator(10000,4004,16,20000,5000,100,50,"adres.txt")
ksiegarnia_generator(100,10000,"ksiegarnia.txt")
autor_generator(1000,"imiona.txt","nazwiska.txt","autor.txt")
pracownik_generator(1000, "imiona.txt", "nazwiska.txt", "pesel.txt", "pracownik.txt",100,10000)
premia_generator(200,"premia.txt",1000)
klient_generator(1000,"imiona.txt","nazwiska.txt","klient.txt")
add_id("wydawnictwa.txt", "wydawnictwo.txt")
gatunek_generator("gatunki_demo.txt","gatunek.txt")
ksiazka_generator(10000,286,4500,"ksiazka.txt")
autorzy_ksiazki_generator(10000,1000,"autorzy_ksiazki.txt")
recenzja_ksiazki_generator(1000,10000,"recenzja_ksiazki.txt")
stan_ksiazki_generator(10000,100,"stan_ksiazki.txt")
zakup_generator(10000,1000,1000,1000000,"zakup.txt")

