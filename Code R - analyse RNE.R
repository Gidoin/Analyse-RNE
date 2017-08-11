## Installation et chargement des packages nécessaires pour l'analyse
library(xml2)
library(XML)
library(purrr)
library(tidyverse)
library(googlesheets)
library(httr)
library(xmlview)
library(htmltools)
library(widgetframe)
library(htmlwidgets)

## Visualisation des nodes XML
cd <- read_xml("http://www.hatvp.fr/livraison/merge/declarations.xml")
xml_tree_view(cd)
xmlview(cd)

## chargement du fichier XML de la HATVP sur les déclarations des élus
### Code récupéré à partir de la page @hrbrmstr https://rud.is/rpubs/xml2power/
res <- GET("http://www.hatvp.fr/livraison/merge/declarations.xml")
doc <- content(res, as="parsed", encoding="UTF-8")
xtrct <- function(doc, target) { xml_find_all(doc, target) %>% xml_text() %>% trimws() }
xtrct_df <- function(doc, top) {
  xml_find_first(doc, sprintf(".//%s", top)) %>%
    xml_children() %>%
    xml_name() %>%
    map(~{
      xtrct(doc, sprintf(".//%s/%s", top, .x)) %>%
        list() %>%
        set_names(tolower(.x))
    }) %>%
    flatten_df() %>%
    readr::type_convert()
}
declaration_df <- xtrct_df(doc, "declaration")
glimpse(declaration_df)
view(declaration_df) # Seulement 10 entrées => Vérification avec la liste des déclarations publiées par la HATVP

listeHATPV <- read_csv2("./data/Liste declarations hatvp.csv")
View(listeHATPV)

listeHATPV %>% 
  arrange(desc(open_data)) # Effectivement seulement 10 entrées correspondant à 10 ministres => abandon du XML de la HATVP

## Importation des 14 fichiers texte du RNE
CAC <- read_tsv("./data/RNE/CAC.txt", locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
CD <- read_tsv("./data/RNE/CD.txt", locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
CM0125 <- read_tsv("./data/RNE/CM 01 25.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
CM2645 <- read_tsv("./data/RNE/CM 26 45.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
CM4655 <- read_tsv("./data/RNE/CM 46 55.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
CM5669 <- read_tsv("./data/RNE/CM 56 69.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
CM7085 <- read_tsv("./data/RNE/CM 70 85.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
CM8695 <- read_tsv("./data/RNE/CM 86 95.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
CMOM <- read_tsv("./data/RNE/CM OM.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
CR <- read_tsv("./data/RNE/CR.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
Deputes <- read_tsv("./data/RNE/Deputes.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
MembresEPCI<- read_tsv("./data/RNE/Membres EPCI.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
RPE <- read_tsv("./data/RNE/RPE.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))
Senateurs <- read_tsv("./data/RNE/Senateurs.txt", skip=1, locale = locale(encoding="ISO-8859-1", date_names = "fr", date_format = "%d/%m/%Y"))

setwd("./Data/RNE")
## Juxtaposer les fichiers textes 

CM0125$`Code du département (Maire)` <-  as.integer(CM0125$`Code du département (Maire)`)
CM2645$`Code du département (Maire)` <-  as.integer(CM2645$`Code du département (Maire)`)
CM4655$`Code du département (Maire)` <-  as.integer(CM4655$`Code du département (Maire)`)
CM5669$`Code du département (Maire)` <-  as.integer(CM5669$`Code du département (Maire)`)
CM7085$`Code du département (Maire)` <-  as.integer(CM7085$`Code du département (Maire)`)
CM8695$`Code du département (Maire)` <-  as.integer(CM8695$`Code du département (Maire)`)
CMCONSO <- bind_rows(CM0125,CM2645,CM4655,CM5669,CM7085,CM8695)
CMCONSO1 <- full_join(CMCONSO,CAC) 

## Erreurs avec le type des colonnes "Code Insee de la commune" & "Code du dpt" # entre CMCONSO1 et CMOM
str(CMCONSO1) # character
str(CMOM)  # integer
CMCONSO1$`Code Insee de la commune` <- as.integer(CMCONSO1$`Code Insee de la commune`)
CMOM$`Code du département (Maire)` <- as.integer(CMOM$`Code du département (Maire)`)

## Reprise des consolidations entre les fichiers

CMCONSO2 <- full_join(CMCONSO1,CMOM) # A noter: cela a remplacé le code dpt des lignes corses de CMCONSO1 par "NA"

## Erreur sur le code région à fixer
str(CMCONSO2)
str(CR)
CR$`Code région` <- as.integer(CR$`Code région`)
CMCONSO3 <- full_join(CMCONSO2,CR) #issue fixed
CMCONSO4 <- full_join(CMCONSO3,CD) #no issue
CMCONSO5 <- full_join(CMCONSO4,Deputes) #no issue
CMCONSO6 <- full_join(CMCONSO5,Senateurs) #no issue
RNEbeta <- full_join(CMCONSO6,RPE) #no issue
View(RNEbeta) # Le problème est la présence de nombreuses colonnes similaires (Ex: libellé dpt)

#identification des colonnes doublons et chgt de leurs noms
colnames(RNEbeta)[2] <- "libellé dpt 1"
colnames(RNEbeta)[20] <- "libellé dpt 2"
colnames(RNEbeta)[21] <- "libellé dpt 3"
colnames(RNEbeta)[1] <- "Code dpt 1"
colnames(RNEbeta)[19] <- "Code dpt 2"
colnames(RNEbeta)[24] <- "Nuance pol CG"
colnames(RNEbeta)[27] <- "Nuance pol Dep"
colnames(RNEbeta)[28] <- "Nuance pol Sen"
colnames(RNEbeta)[31] <- "Nuance pol RPE"

# Merge des colonnes doublons
## Cas du libelle dpt
RNEbeta1 <- RNEbeta %>% 
  select("libellé dpt 1", "libellé dpt 2", "libellé dpt 3")
colnames(RNEbeta1)[1] <- "Libellé dpt"
RNEbeta11  <- paste(RNEbeta1$`Libellé dpt`, RNEbeta1$`libellé dpt 2`, RNEbeta1$`libellé dpt 3`, sep='-')
RNEbeta11 <- gsub('NA-|-NA', '', RNEbeta11)
(RNEbeta12 <- cbind(RNEbeta1, RNEbeta11))
RNEbeta12[1] <- NULL
RNEbeta12[2] <- NULL
colnames(RNEbeta12)[1] <- "Libellé dpt"
RNElibdpt <-  RNEbeta12 # nom + explicite

## Cas du code dpt
RNEbeta2 <- RNEbeta %>% 
  select("Code dpt 1", "Code dpt 2")
RNEbeta21 <- paste(RNEbeta2$`Code dpt 1`, RNEbeta2$`Code dpt 2`, sep='-')
RNEbeta21 <- gsub('NA-|-NA', '', RNEbeta21)
(RNEbeta22 <- cbind(RNEbeta2, RNEbeta21))
RNEbeta22[1]<- NULL
colnames(RNEbeta22)[1] <- "Code dpt" # nom + explicite
RNEcodedpt <-  RNEbeta22 
View(RNEcodedpt) #il restera des observations à harmoniser. Ex: 1 => 01

## Cas des nuances politiques
RNEbeta3 <- RNEbeta %>%
  select("Nuance mandat","Nuance pol CG", "Nuance pol Dep", "Nuance pol Sen", "Nuance pol RPE", "Nuance pol Dep")
RNEbeta31 <- paste(RNEbeta3$`Nuance mandat`, RNEbeta3$`Nuance pol CG`, RNEbeta3$`Nuance pol Dep`, RNEbeta3$`Nuance pol RPE`,RNEbeta3$`Nuance pol Sen`, sep='-')
RNEbeta31 <- gsub('NA-|-NA', '', RNEbeta31)
(Nuancepol <- cbind(RNEbeta3, RNEbeta31))
# connaitre le nb de nuances politiques répertoriées
513968 - sum(is.na(Nuancepol$`Nuance mandat`))+513968 - sum(is.na(Nuancepol$`Nuance pol CG`))+513968 - sum(is.na(Nuancepol$`Nuance pol Dep`))+513968 - sum(is.na(Nuancepol$`Nuance pol Sen`))+513968 - sum(is.na(Nuancepol$`Nuance pol RPE`))
Nuancepol[1] <- NULL
colnames(Nuancepol)[1] <- "Nuance pol" # nom + explicite
View(Nuancepol)
