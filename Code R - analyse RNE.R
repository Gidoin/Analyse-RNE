## Installation et chargement des packages nécessaires pour l'analyse
install.packages("widgetframe")
devtools::install_github("ramnathv/htmlwidgets")
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

CMCONSO3 <- full_join(CMCONSO2,CR)
CMCONSO4 <- full_join(CMCONSO3,CD)
CMCONSO5 <- full_join(CMCONSO4,Deputes)
CMCONSO6 <- full_join(CMCONSO5,Senateurs)
CMCONSO7 <- full_join(CMCONSO6,RPE)
