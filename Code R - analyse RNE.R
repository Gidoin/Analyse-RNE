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

## Importation des fichiers texte du RNE
CAC <- read_tsv(file("./data/RNE/CAC.txt", encoding="ASCII"))
View(CAC)

# Enlever les accents du fichier texte
library(tools)
library(stringi)
showNonASCII("CAC")

x1 <- c("Code", "région",	"Libellé de la région",	"Nom de l'élu",	"Prénom de l'élu",	"Date de naissance",	"Civilité",	"Code profession",	"Libellé de la profession",	"Date de début du mandat",	"Libellé de fonction",	"Date de début de la fonction",	"N° Identification d'un élu",	"Nuance mandat")
Encoding(x1) <- "latin1"
View(x1)

CAC2 <- stri_trans_general(y, "latin-ascii")


any(grepl("I_WAS_NOT_ASCII", iconv(x, "latin1", "ASCII", sub="I_WAS_NOT_ASCII")))
grep("I_WAS_NOT_ASCII", iconv(x, "latin1", "ASCII", sub="I_WAS_NOT_ASCII"))

#Piste à creuser: https://stackoverflow.com/questions/6602881/text-file-to-list-in-r
