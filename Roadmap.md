# Roadmap
Timothée Gidoin  
4 août 2017  
### Objectifs de l'analyse
- Evaluer le cumul des mandats des élus actuels, à la fois dans le temps et dans les différentes fonctions électives (parlemenaires et locales).
- Compléter et actualiser l'étude réalisée par le HCEfh en 2013 (sous la mandature précédente)
- Avoir une approche centrée autour de la parité parmi les élus cumulant les mandats
    + Hypothèse 1 que les mandats cumulés ne sont pas les mêmes entre les hommes et les femmes - au détriment de ces dernières - du fait de différences en termes de:
        * Niveau de responsabilité
        * Thématiques traitées (Ex: culture, éducation vs économie, sécurité)
        * Prestige, 
        * Rémunération,
    + Hypothèse 2 que le nombre de mandats cumulés - *bien que plus limité qu'auparavant du fait de la loi de 2013 interdisant le cumul d'un mandat parlementaire avec celui d'un exécutif local* - est supérieur chez les élus masculins

***Cette analyse ambitionne de nourrir le débat public autour de la parité dans la sphère politique, en partant des données disponibles publiquement, et aura donc vocation à être partagée sur les réseaux sociaux***

### Revue de la documentation existante
- **Etude genrée sur le cumul des mandats des parlementaires (Mars 2013 HCEhf) [lien](http://haut-conseil-egalite.gouv.fr/IMG/pdf/etude_hce-2013-0329-par001_maquettee.pdf). Plusieurs enseignements:**

    + Au moment de l'étude la parité est loin d’être atteinte:
    
    > ##### *les hommes représentent plus de 73% des députés, près de 78% des sénateurs, plus de 86% des maires, plus de 92% des présidents de conseils régionaux, près de 93% des présidents d’EPCI, et représentent 95% des présidents de conseils généraux.*
    + En plus d'être très majoritaires parmi les élus, les hommes cumulent, en proportion, davantages de mandats

    > ##### *80% des parlementaires en situation de cumul sont des hommes. Seulement un homme député sur 5 est en situation de mandat unique, contre près d’une femme députée sur deux.*
    + Et les mandats qui font l'objet du cumul sont souvent les plus intéressants

    > ##### *Ainsi, 100% des parlementaires en situation de cumul avec une présidence de conseil général ou régional sont des hommes (15 députés-présidents et 38 sénateurs-présidents*
    + A cette inégalité du cumul des mandats au niveau des fonctions, s'ajoute l'inégalité du cumul des mandats dans le temps

    > ##### *les hommes députés sont 10 fois plus nombreux que leurs collègues femmes à être sur les bancs de l’Assemblée nationale depuis au moins 15 ans, soit 4 mandats successifs*
    + Données utilisées par le HCEfh:
        *  Déclarations des député-e-s et recueillies dans les "Notices et portraits des députés de la XIVe législature", éditées par l’Assemblée nationale
        *  Données du RNE notamment sur les présidences des EPCI des députées
        *  « Notices biographiques », en particulier des « Listes des Sénateurs exerçant des fonctions locales », consultables sur le site internet du Sénat.
  
-  **Enquête des Décodeurs du Monde sur les nouveaux députés (Juin 2017) [lien](http://abonnes.lemonde.fr/les-decodeurs/article/2017/06/25/comment-le-monde-a-enquete-sur-les-577-deputes-de-la-nouvelle-assemblee_5150847_4355770.html). A retenir:**

    > ##### *Pas moins de **327 des 577 membres** de l’Assemblée nationale élue dimanche 18 juin disposaient d’au moins un autre mandat à la date de leur élection, dont 223 qui sont en contradiction avec la loi sur le cumul des mandats*
    
    > ##### *Aujourd’hui, 223 députés, soit 38,6 % de l’Hémicycle cumulent un mandat de député avec un exécutif local. Sauf à démissionner de l’Assemblée nationale, ce qui serait surprenant, ils ont trente jours à compter de leur élection pour abandonner leurs autres responsabilités incompatibles avec la fonction.*
    
    > ##### *Ce dilemme touche en premier lieu les fameux députés et maires : pas moins de 135 nouveaux élus à l’Assemblée nationale ont cette double casquette. A tous ces élus s’ajoutent en outre 49 adjoints au maire, eux aussi concernés par la loi qui restreint les possibilités de cumul. Soit 184 élus qui vont devoir lâcher les rênes de leur commune.*

    > ##### *Dans la nouvelle Assemblée, on dénombre au total 271 élus municipaux, 76 départementaux et 65 régionaux, sans compter le sénateur socialiste Luc Carvounas et les députés européens Louis Aliot, Marine Le Pen (Front national), Constance Le Grip (Les Républicains) et Jean-Luc Mélenchon (La France insoumise), qui vont devoir abandonner leur mandat avant son terme.* **In fine, seuls 188 parlementaires arrivent à l’Assemblée vierges de toute expérience élective**
    
    > ##### *La réforme de 2014 devrait quelque peu alléger l’emploi du temps surchargé de certains élus. On trouve tout de même pas moins de 85 députés qui exercent en parallèle deux autres mandats, soit 15 % environ et 241 autres (42 % de l’Hémicycle) qui en ont un autre. Ils ne seront que 43 % à se consacrer uniquement à la députation.* 
    
    > ##### *La nette progression de la part des femmes, passée en cinq ans de 27 % à 39 %, est à mettre largement au crédit de La République en marche (LRM) et du MoDem, qui comptent 47 % de députées.*
    
    
    

    + Données utilisées par Les Décodeurs:
        * RNE
        * Site Assemblée Nationale
        * Déclarations d'intérêts auprès de la HATVP

- **Autres, à compléter**

### Méthodologie d'analyse sur R

1. **Importer les données**

```r
library(readr)
```

```
## Warning: package 'readr' was built under R version 3.3.3
```

2. **Consolider le Registre National des Elus**
- Consolider les données de 2008 à 2017
- Consolider les différents fichiers (EPCI, maires, sénateurs...) dans un seul fichier

2. **




