# Test Rmd
Gidoin  
3 août 2017  
This rmd document is awesome

```r
getwd()
```

```
## [1] "C:/Users/timot/Documents/Datactivist/Mission HCE/Analyse RNE/Analyse-RNE"
```

```r
library(readr)
```

```
## Warning: package 'readr' was built under R version 3.3.3
```

```r
read_csv("CSVtest.csv")
```

```
## Parsed with column specification:
## cols(
##   url = col_character(),
##   Organismes = col_character(),
##   Organismes_link = col_character(),
##   `Nom contact` = col_character(),
##   `Statut & Adresse` = col_character(),
##   `Statut & Adresse_link` = col_character()
## )
```

```
## # A tibble: 1,631 x 6
##                                                                            url
##                                                                          <chr>
##  1 http://www.cada.fr/personnes-responsables,6059.html?id_article=6059&page=ar
##  2 http://www.cada.fr/personnes-responsables,6059.html?id_article=6059&page=ar
##  3 http://www.cada.fr/personnes-responsables,6059.html?id_article=6059&page=ar
##  4 http://www.cada.fr/personnes-responsables,6059.html?id_article=6059&page=ar
##  5 http://www.cada.fr/personnes-responsables,6059.html?id_article=6059&page=ar
##  6 http://www.cada.fr/personnes-responsables,6059.html?id_article=6059&page=ar
##  7 http://www.cada.fr/personnes-responsables,6059.html?id_article=6059&page=ar
##  8 http://www.cada.fr/personnes-responsables,6059.html?id_article=6059&page=ar
##  9 http://www.cada.fr/personnes-responsables,6059.html?id_article=6059&page=ar
## 10 http://www.cada.fr/personnes-responsables,6059.html?id_article=6059&page=ar
## # ... with 1,621 more rows, and 5 more variables: Organismes <chr>,
## #   Organismes_link <chr>, `Nom contact` <chr>, `Statut & Adresse` <chr>,
## #   `Statut & Adresse_link` <chr>
```
