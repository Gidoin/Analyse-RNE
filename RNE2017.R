#---------
# Packages

library(tidyverse)

#----------------
# Import fichiers

CAC <- read_tsv("./Data/RNE/CAC.txt", locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"), col_types = cols(
  `Code région` = col_character(),
  `Libellé de la région` = col_character(),
  `Nom de l'élu` = col_character(),
  `Prénom de l'élu` = col_character(),
  `Date de naissance` = col_date(format = ""),
  Civilité = col_character(),
  `Code profession` = col_character(),
  `Libellé de la profession` = col_character(),
  `Date de début du mandat` = col_date(format = ""),
  `Libellé de fonction` = col_character(),
  `Date de début de la fonction` = col_date(format = ""),
  `N° Identification d'un élu` = col_integer(),
  `Nuance mandat` = col_character()
  )
)
CD <- read_tsv("./Data/RNE/CD.txt", locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
CM0125 <- read_tsv("./Data/RNE/CM 01 25.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
CM2645 <- read_tsv("./Data/RNE/CM 26 45.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"), col_types = cols(
  `Code du département (Maire)` = col_character(),
  `Libellé de département (Maires)` = col_character(),
  `Code Insee de la commune` = col_character(),
  `Libellé de la commune` = col_character(),
  `Population de la commune` = col_integer(),
  `Nom de l'élu` = col_character(),
  `Prénom de l'élu` = col_character(),
  Civilité = col_character(),
  `Date de naissance` = col_date(format = ""),
  `Code profession` = col_character(),
  `Libellé de la profession` = col_character(),
  `Nuance mandat` = col_character(),
  `Date de début du mandat` = col_date(format = ""),
  `Libellé de fonction` = col_character(),
  `Date de début de la fonction` = col_date(format = ""),
  `N° Identification d'un élu` = col_integer()
))
CM4655 <- read_tsv("./Data/RNE/CM 46 55.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"), col_types = cols(
  `Code du département (Maire)` = col_character(),
  `Libellé de département (Maires)` = col_character(),
  `Code Insee de la commune` = col_character(),
  `Libellé de la commune` = col_character(),
  `Population de la commune` = col_integer(),
  `Nom de l'élu` = col_character(),
  `Prénom de l'élu` = col_character(),
  Civilité = col_character(),
  `Date de naissance` = col_date(format = ""),
  `Code profession` = col_character(),
  `Libellé de la profession` = col_character(),
  `Nuance mandat` = col_character(),
  `Date de début du mandat` = col_date(format = ""),
  `Libellé de fonction` = col_character(),
  `Date de début de la fonction` = col_date(format = ""),
  `N° Identification d'un élu` = col_integer()
))
CM5669 <- read_tsv("./Data/RNE/CM 56 69.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"), col_types = cols(
  `Code du département (Maire)` = col_character(),
  `Libellé de département (Maires)` = col_character(),
  `Code Insee de la commune` = col_character(),
  `Libellé de la commune` = col_character(),
  `Population de la commune` = col_integer(),
  `Nom de l'élu` = col_character(),
  `Prénom de l'élu` = col_character(),
  Civilité = col_character(),
  `Date de naissance` = col_date(format = ""),
  `Code profession` = col_character(),
  `Libellé de la profession` = col_character(),
  `Nuance mandat` = col_character(),
  `Date de début du mandat` = col_date(format = ""),
  `Libellé de fonction` = col_character(),
  `Date de début de la fonction` = col_date(format = ""),
  `N° Identification d'un élu` = col_integer()
))
CM7085 <- read_tsv("./Data/RNE/CM 70 85.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"), col_types = cols(
  `Code du département (Maire)` = col_character(),
  `Libellé de département (Maires)` = col_character(),
  `Code Insee de la commune` = col_character(),
  `Libellé de la commune` = col_character(),
  `Population de la commune` = col_integer(),
  `Nom de l'élu` = col_character(),
  `Prénom de l'élu` = col_character(),
  Civilité = col_character(),
  `Date de naissance` = col_date(format = ""),
  `Code profession` = col_character(),
  `Libellé de la profession` = col_character(),
  `Nuance mandat` = col_character(),
  `Date de début du mandat` = col_date(format = ""),
  `Libellé de fonction` = col_character(),
  `Date de début de la fonction` = col_date(format = ""),
  `N° Identification d'un élu` = col_integer()
))
CM8695 <- read_tsv("./Data/RNE/CM 86 95.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"), col_types = cols(
  `Code du département (Maire)` = col_character(),
  `Libellé de département (Maires)` = col_character(),
  `Code Insee de la commune` = col_character(),
  `Libellé de la commune` = col_character(),
  `Population de la commune` = col_integer(),
  `Nom de l'élu` = col_character(),
  `Prénom de l'élu` = col_character(),
  Civilité = col_character(),
  `Date de naissance` = col_date(format = ""),
  `Code profession` = col_character(),
  `Libellé de la profession` = col_character(),
  `Nuance mandat` = col_character(),
  `Date de début du mandat` = col_date(format = ""),
  `Libellé de fonction` = col_character(),
  `Date de début de la fonction` = col_date(format = ""),
  `N° Identification d'un élu` = col_integer()
))
CMOM <- read_tsv("./Data/RNE/CM OM.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"), col_types = cols(
  `Code du département (Maire)` = col_character(),
  `Libellé de département (Maires)` = col_character(),
  `Code Insee de la commune` = col_character(),
  `Libellé de la commune` = col_character(),
  `Population de la commune` = col_integer(),
  `Nom de l'élu` = col_character(),
  `Prénom de l'élu` = col_character(),
  Civilité = col_character(),
  `Date de naissance` = col_date(format = ""),
  `Code profession` = col_character(),
  `Libellé de la profession` = col_character(),
  `Nuance mandat` = col_character(),
  `Date de début du mandat` = col_date(format = ""),
  `Libellé de fonction` = col_character(),
  `Date de début de la fonction` = col_date(format = ""),
  `N° Identification d'un élu` = col_integer()
))
CR <- read_tsv("./Data/RNE/CR.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
Deputes <- read_tsv("./Data/RNE/Deputes.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
MembresEPCI<- read_tsv("./Data/RNE/Membres EPCI.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"), col_types = cols(
  `Code département EPCI` = col_character(),
  `Code département commune rattachée` = col_character(),
  `Code de la commune` = col_character(),
  `Libellé commune rattachée` = col_character(),
  `N° SIREN` = col_character(),
  `Libellé de l'EPCI` = col_character(),
  `Nom de l'élu` = col_character(),
  `Prénom de l'élu` = col_character(),
  `Date de naissance` = col_date(format = ""),
  Civilité = col_character(),
  `Code profession` = col_character(),
  `Libellé de la profession` = col_character(),
  `Date de début du mandat` = col_date(format = ""),
  `Libellé de fonction` = col_character(),
  `Date de début de la fonction` = col_date(format = ""),
  `N° Identification d'un élu` = col_integer(),
  `Nuance mandat` = col_character()
))
RPE <- read_tsv("./Data/RNE/RPE.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
Senateurs <- read_tsv("./Data/RNE/Senateurs.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))

#-------------------------
# Nettoyage des fichiers  


CAC <- CAC %>% 
  mutate(mandat = "CAC",
         territoire_mandat = "Collectivité de Corse",
         code_territoire_mandat = `Code région`,
         libellé_territoire_mandat = "Corse",
         territoire_élection = "Collectivité de Corse",
         code_territoire_élection = `Code région`,
         libellé_territoire_élection = "Corse") %>% 
  select(mandat, territoire_mandat, code_territoire_mandat, libellé_territoire_mandat, territoire_élection, code_territoire_élection, libellé_territoire_élection, ID_elu = `N° Identification d'un élu`, civilité = Civilité, nom = `Nom de l'élu`, prénom = `Prénom de l'élu`, date_naissance = `Date de naissance`, code_profession = `Code profession`, libellé_profession = `Libellé de la profession`, date_mandat = `Date de début du mandat`, libellé_fonction = `Libellé de fonction`, date_fonction = `Date de début de la fonction`, nuance = `Nuance mandat`)

CD <- CD %>% 
  mutate(mandat = "Conseiller départemental",
         territoire_mandat = "Département",
         code_territoire_mandat = `Code du département`,
         libellé_territoire_mandat = `Libellé du département`,
         territoire_élection = "Canton",
         code_territoire_élection = `Code du canton`,
         libellé_territoire_élection = `Libellé du canton`) %>% 
  select(mandat, territoire_mandat, code_territoire_mandat, libellé_territoire_mandat, territoire_élection, code_territoire_élection, libellé_territoire_élection, ID_elu = `N° Identification d'un élu`, civilité = Civilité, nom = `Nom de l'élu`, prénom = `Prénom de l'élu`, date_naissance = `Date de naissance`, code_profession = `Code profession`, libellé_profession = `Libellé de la profession`, date_mandat = `Date de début du mandat`, libellé_fonction = `Libellé de fonction`, date_fonction = `Date de début de la fonction`, nuance = `Nuance politique (C. Gén.)`)

CM <- bind_rows(CM0125, CM2645, CM4655, CM5669, CM7085, CM8695, CMOM)

CM <- CM %>% 
  mutate(mandat = "Conseiller municipal",
         territoire_mandat = "Commune",
         code_territoire_mandat = paste0(`Code du département (Maire)`, `Code Insee de la commune`),
         libellé_territoire_mandat = `Libellé de la commune`,
         territoire_élection = "Commune",
         code_territoire_élection = code_territoire_mandat,
         libellé_territoire_élection = libellé_territoire_mandat) %>% 
  select(mandat, territoire_mandat, code_territoire_mandat, libellé_territoire_mandat, territoire_élection, code_territoire_élection, libellé_territoire_élection, ID_elu = `N° Identification d'un élu`, civilité = Civilité, nom = `Nom de l'élu`, prénom = `Prénom de l'élu`, date_naissance = `Date de naissance`, code_profession = `Code profession`, libellé_profession = `Libellé de la profession`, date_mandat = `Date de début du mandat`, libellé_fonction = `Libellé de fonction`, date_fonction = `Date de début de la fonction`, nuance = `Nuance mandat`)

CR <- CR %>% 
  mutate(mandat = "Conseiller régional",
         territoire_mandat = "Région",
         code_territoire_mandat = `Code région`,
         libellé_territoire_mandat = `Libellé de la région`,
         territoire_élection = "Département",
         code_territoire_élection = `Code du département`,
         libellé_territoire_élection = `Libellé de département`) %>% 
  select(mandat, territoire_mandat, code_territoire_mandat, libellé_territoire_mandat, territoire_élection, code_territoire_élection, libellé_territoire_élection, ID_elu = `N° Identification d'un élu`, civilité = Civilité, nom = `Nom de l'élu`, prénom = `Prénom de l'élu`, date_naissance = `Date de naissance`, code_profession = `Code profession`, libellé_profession = `Libellé de la profession`, date_mandat = `Date de début du mandat`, libellé_fonction = `Libellé de fonction`, date_fonction = `Date de début de la fonction`, nuance = `Nuance mandat`)

Deputes <- Deputes %>% 
  mutate(mandat = "Députés",
         territoire_mandat = "France",
         code_territoire_mandat = "FR",
         libellé_territoire_mandat = "France",
         territoire_élection = "Circonscription législative",
         code_territoire_élection = paste0(`Code du département`, `Code de la cir.législative`),
         libellé_territoire_élection = paste0(`Libellé de la cir.législative`, " - ", `Libellé du département`)) %>% 
  mutate(libellé_fonction = NA_character_, date_fonction = NA_character_) %>% 
  select(mandat, territoire_mandat, code_territoire_mandat, libellé_territoire_mandat, territoire_élection, code_territoire_élection, libellé_territoire_élection, ID_elu = `N° Identification d'un élu`, civilité = Civilité, nom = `Nom de l'élu`, prénom = `Prénom de l'élu`, date_naissance = `Date de naissance`, code_profession = `Code profession`, libellé_profession = `Libellé de la profession`, date_mandat = `Date de début du mandat`, libellé_fonction, date_fonction, nuance = `Nuance politique (Député)`)

MembresEPCI <- MembresEPCI %>% 
  mutate(mandat = "Membre d'un EPCI",
         territoire_mandat = "EPCI",
         code_territoire_mandat = `N° SIREN`,
         libellé_territoire_mandat = `Libellé de l'EPCI`,
         territoire_élection = "Commune",
         code_territoire_élection = paste0(`Code département commune rattachée`, `Code de la commune`),
         libellé_territoire_élection = `Libellé commune rattachée`) %>% 
  select(mandat, territoire_mandat, code_territoire_mandat, libellé_territoire_mandat, territoire_élection, code_territoire_élection, libellé_territoire_élection, ID_elu = `N° Identification d'un élu`, civilité = Civilité, nom = `Nom de l'élu`, prénom = `Prénom de l'élu`, date_naissance = `Date de naissance`, code_profession = `Code profession`, libellé_profession = `Libellé de la profession`, date_mandat = `Date de début du mandat`, libellé_fonction = `Libellé de fonction`, date_fonction = `Date de début de la fonction`, nuance = `Nuance mandat`)

RPE <- RPE %>% 
  mutate(mandat = "Député européen",
         territoire_mandat = "Union européenne",
         code_territoire_mandat = "UE",
         libellé_territoire_mandat = "Union européenne",
         territoire_élection = "Circonscription européenne",
         code_territoire_élection = CodeCirER,
         libellé_territoire_élection = LibelléCirER) %>% 
  mutate(libellé_fonction = NA_character_, date_fonction = NA_character_) %>% 
  select(mandat, territoire_mandat, code_territoire_mandat, libellé_territoire_mandat, territoire_élection, code_territoire_élection, libellé_territoire_élection, ID_elu = `N° Identification d'un élu`, civilité = Civilité, nom = `Nom de l'élu`, prénom = `Prénom de l'élu`, date_naissance = `Date de naissance`, code_profession = `Code profession`, libellé_profession = `Libellé de la profession`, date_mandat = `Date de début du mandat`, libellé_fonction, date_fonction, nuance = `Nuance politique (Rep. P.E.)`)

Senateurs <- Senateurs %>% 
  mutate(mandat = "Sénateur",
         territoire_mandat = "France",
         code_territoire_mandat = "FR",
         libellé_territoire_mandat = "France",
         territoire_élection = "Département",
         code_territoire_élection = `Code du département`,
         libellé_territoire_élection = `Libellé du département`) %>% 
  mutate(libellé_fonction = NA_character_, date_fonction = NA_character_) %>% 
  select(mandat, territoire_mandat, code_territoire_mandat, libellé_territoire_mandat, territoire_élection, code_territoire_élection, libellé_territoire_élection, ID_elu = `N° Identification d'un élu`, civilité = Civilité, nom = `Nom de l'élu`, prénom = `Prénom de l'élu`, date_naissance = `Date de naissance`, code_profession = `Code profession`, libellé_profession = `Libellé de la profession`, date_mandat = `Date de début du mandat`, libellé_fonction, date_fonction, nuance = `Nuance politique (Sénateur)`)

RNE_2017 <- bind_rows(CAC, CD, CM, CR, Deputes, MembresEPCI)
write_excel_csv(RNE_2017, path = "./Data/RNE/RNE2017.csv.gz")
