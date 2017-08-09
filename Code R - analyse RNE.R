## Installation et chargement des packages nécessaires pour l'analyse

library(xml2)
library(XML)
library(purrr)
library(tidyverse)
library(googlesheets)
library(httr)
library(xmlview)
library(htmltools)
install.packages("widgetframe")
library(widgetframe)
devtools::install_github("ramnathv/htmlwidgets")
library(htmlwidgets)
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
view(declaration_df)

## Seulement 10 entrées. Vérification avec la liste des déclarations publiées par la HATVP
x <- read_csv2("./data/Liste declarations hatvp.csv")
view(x)
