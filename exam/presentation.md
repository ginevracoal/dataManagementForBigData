---
title: 'Analisi dei progetti di Kickstarter'
author: Ginevra Carbone
always_allow_html: yes
editor_options: 
  chunk_output_type: inline
output:
  ioslides_presentation:
    incremental: true
    # logo: immagini/kickstarter-logo.png
    # css: theme.css
    widescreen: true
    # fig_width: 7
    # smaller: true
    # template: quarterly_report.html
---







***

## Introduzione | Cos'è Kickstarter? {.build}

<div id="kickstarter">
  <div align="center">
  <img src="immagini/kickstarter-logo.png" width=600>
  </div>
</div>



## Introduzione | Cos'è Kickstarter? {.build}

Piattaforma di **crowdfunding** lanciata il 28 Aprile del 2009 a Manhattan.

<div class="columns-2">
  
  <div align="left">
  <img src="immagini/crowdfunding.jpg" width=500>
  </div>
  
  - Progetto creativo 
    - data di scadenza
    - goal di finanziamenti
  - Finanziamento collettivo
  - Eventuale produzione e vendita
  
</div>

***

<div align="right">
Progetti creativi da tutto il mondo
</div>



<!--html_preserve--><iframe title="Worldmap" src="worldmap.html" height="300" width="700"></iframe><!--/html_preserve-->

## Scopi principali {.build .flexbox .vcenter}

1. Analisi esplorativa di un dataset
    - variabili coinvolte
    - informazioni mancanti o errate
2. Estrazione delle infomazioni
    - relazioni tra le diverse variabili
3. Modelli di previsione del successo

## Il dataset | Overview {.build .flexbox .vcenter}

<img src="immagini/kaggle.png" width=350>

*www.kaggle.com*

formato csv

## Il dataset | Overview {.build}


- $378661$ progetti 

- 16 variabili:


```
##  [1] "ID"               "name"             "category"        
##  [4] "main_category"    "currency"         "deadline"        
##  [7] "goal"             "launched"         "pledged"         
## [10] "state"            "backers"          "country"         
## [13] "usd_pledged_real" "usd_goal_real"
```

## Il dataset | Cleaning {.build}

- Valori mancanti: Nomi


```
##               ID             name         category    main_category 
##                0                4                0                0 
##         currency         deadline             goal         launched 
##                0                0                0                0 
##          pledged            state          backers          country 
##                0                0                0                0 
## usd_pledged_real    usd_goal_real 
##                0                0
```

## Il dataset | Cleaning {.build}

<!-- - Valori mancanti: Nomi -->
- Valori errati: Date di lancio


```
## # A tibble: 378,657 x 2
##    name                                                launched           
##    <chr>                                               <dttm>             
##  1 Salt of the Earth: A Dead Sea Movie (Canceled)      1970-01-01 01:00:00
##  2 1st Super-Size Painting - Social Network Owned (Ca… 1970-01-01 01:00:00
##  3 "\"ICHOR\"  (Canceled)"                             1970-01-01 01:00:00
##  4 "Support Solo Theater! Help \"Ungrateful Daughter\… 1970-01-01 01:00:00
##  5 Help RIZ Make A Charity Album: 8 Songs, 8 Causes, … 1970-01-01 01:00:00
##  6 Identity Communications Infographic (Canceled)      1970-01-01 01:00:00
##  7 Student Auditions Music 2015                        1970-01-01 01:00:00
##  8 Grace Jones Does Not Give A F$#% T-Shirt (limited … 2009-04-21 21:02:48
##  9 CRYSTAL ANTLERS UNTITLED MOVIE                      2009-04-23 00:07:53
## 10 drawing for dollars                                 2009-04-24 21:52:03
## # ... with 378,647 more rows
```

----

The dataset contains all projects launched between 21/04/2009 (referring to the first project ever) and 02/01/2018.


```
## # A tibble: 1 x 1
##   launched           
##   <dttm>             
## 1 2009-04-21 21:02:48
```

```
## # A tibble: 1 x 1
##   launched           
##   <dttm>             
## 1 2018-01-02 15:02:31
```
----

This plot shows the distribution of USD fundings over time.
![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png)

---

### Fundings

I started analyzing columns referring to **pledged money**: for each possible currency, this dataset contains the corresponding pledged money in USD as `usd_pledged_real`.


```
## # A tibble: 69,488 x 3
##    currency  pledged usd_pledged_real
##    <chr>       <dbl>            <dbl>
##  1 GBP      94175.         121857.   
##  2 AUD          1.00            0.810
##  3 NOK         48.0             6.29 
##  4 CAD      48905.          42174.   
##  5 GBP        112.            161.   
##  6 GBP         21.0            31.1  
##  7 AUD       2000.           1427.   
##  8 CAD        592.            473.   
##  9 EUR        137.            151.   
## 10 CAD        700.            535.   
## # ... with 69,478 more rows
```
---
It also contains all conversions for goal fundings.


```
## # A tibble: 69,494 x 5
##    currency   goal usd_goal_real usd_pledged_real state     
##    <chr>     <dbl>         <dbl>            <dbl> <chr>     
##  1 GBP       5000.        6470.        121857.    successful
##  2 AUD       2500.        2026.             0.810 failed    
##  3 NOK        500.          65.6            6.29  failed    
##  4 CAD      17757.       15313.         42174.    successful
##  5 GBP        100.         143.           161.    successful
##  6 GBP       3500.        5181.            31.1   failed    
##  7 AUD       2000.        1427.          1427.    successful
##  8 CAD       3000.        2396.           473.    live      
##  9 EUR      12000.       13202.           151.    failed    
## 10 CAD      15000.       11466.           535.    canceled  
## # ... with 69,484 more rows
```

The histogram shows the sum of **pledges over each year**, 2015 being the most funded one. I excluded 2018 from the maximum pledge plot since it only refers to a limited amount of projects.

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10-1.png)

These are the single projects having higher pledge by year:
  

```
## Joining, by = "year"
```

```
## # A tibble: 10 x 4
##    name                                    usd_pledged_real year        ID
##    <chr>                                   <chr>            <chr>    <int>
##  1 Designing Obama                         $84,614          2009    1.49e9
##  2 TikTok+LunaTik Multi-Touch Watch Kits   $942,578         2010    1.95e8
##  3 Elevation Dock: The Best Dock For iPho… $1,464,707       2011    1.67e9
##  4 Pebble: E-Paper Watch for iPhone and A… $10,266,846      2012    5.07e8
##  5 The Veronica Mars Movie Project         $5,702,153       2013    1.76e9
##  6 COOLEST COOLER: 21st Century Cooler th… $13,285,226      2014    3.43e8
##  7 Pebble Time - Awesome Smartwatch, No C… $20,338,986      2015    1.80e9
##  8 Pebble 2, Time 2 + All-New Pebble Core  $12,779,843      2016    2.10e9
##  9 THE 7th CONTINENT – What Goes Up, Must… $7,072,757       2017    6.47e8
## 10 The Prayer Chain - Shawl Double Vinyl … $10,847          2018    3.47e8
```


The **most funded project** in the history of kickstarter is "Pebble Time", with a $20,338,986 funding in 2015.

---

### Categories



Projects are divided into 15 categories, each one having many subcategories. The **interactive pie chart** below allows to explore the distribution of subcategories over each category.



```
## Error in loadNamespace(name): there is no package called 'webshot'
```
---
The information about subcategories is not very useful: most of them have the same name as the main category and do not provide any additional information. This interactive chart also counts the number of projects for each category and subcategory, which are better collected in the following histogram.


![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13-1.png)



**Film & Video** and **Music** are the largest categories, let's see how much money they raised. 

---

These are the top 15 categories in terms of funding.

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15-1.png)

---



Film & Video and Music have a great amount of fundings, but **Design** and **Games** alone, which are the most funded, with $\$1,475,547,207$ dollars almost account for half of the total money raised ($\$3,422,378,422$).


---

### Success 

Projects have six possible **states**. I discarded all the ones having an undefined state.


```
## [1] "failed"     "canceled"   "successful" "live"       "undefined" 
## [6] "suspended"
```




---

The distribution of categories over each state can be explored in this pie chart:

---


```
## Error in loadNamespace(name): there is no package called 'webshot'
```

---


Focusing on the states `successful` vs `failed`, we only need to look at the average differences between goal and total USD pledged for each category.

![plot of chunk unnamed-chunk-19](figure/unnamed-chunk-19-1.png)

---

Successful **Technology**, **Games** and **Design** projects show the highest fundings respect to the initial goal, overcoming it by $\$5000$ for Technology.
In case of failure, **Technology** also has the lowest fundings, going under the goal by over $\$15000$. It is followed by **Design** and **Food** categories, then Games and Film & Video.
This shows that some categories are more unpredictable than others in terms of expected fundings, and Technology in particular is the most risky field.

---

The following histogram shows Success vs Failure percentage rate for each category.

![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-20-1.png)

---

69% **Dance** projects reached their goal, followed by **Theater** and **Comics**, so they all have a low risk of failure.
**Technology** had very high pledges, but also shows the lowest success rate. This category is attractive to people, but also strongly reliant on innovation and engineering.
Overall Film & Video, Music, Games and Design seem to have the best funding vs success rate: these kind of products usually offer an instant satisfaction and are easily enjoyable.






![plot of chunk unnamed-chunk-22](figure/unnamed-chunk-22-1.png)

Unfortunately, **Italy** shows up as the most unsuccessful country, based on 2243 projects, while the most successful one is **Honk Kong**, having quite a low number of projects (only 555).

### Most frequent words

Finally, I only took into account successful projects in order to extract the most frequent words appearing in project's names.

I preprocessed the list of titles by removing punctuation, capital letters, white spaces and stopwords, then I got the worldcloud showed below.

![plot of chunk unnamed-chunk-23](figure/unnamed-chunk-23-1.png)

These are the names of successful projects containing the first five most frequent words:


```
## # A tibble: 27,083 x 1
##    name                                                     
##    <chr>                                                    
##  1 Lisa Lim New CD!                                         
##  2 Tombstone: Old West tabletop game and miniatures in 32mm.
##  3 CMUK. Shoes: Take on Life Feet First.                    
##  4 The Book Zoo - A Mini-Comic                              
##  5 My Moon - Animated Short Film                            
##  6 Ledr workbook: one tough journal!                        
##  7 Chris Eger Band - New Nashville Record!                  
##  8 Zen in America: a film on Zen Buddhism in North America  
##  9 Help Scott Reynolds Make a New Record!                   
## 10 Phil Younger - Slow Down (Official Music Video)          
## # ... with 27,073 more rows
```


### Predicting success


**Logistic regression** is a probabilistic statistical model that allows to perform binary classification (i.e. to predict a binary outcome) from a given set of continuous predictor variables.
For training and test sets I choose a 60/40 split ratio.



After fitting the `glm` model with different combinations of predictors, I got the lowest AIC and highest accuracy by using the following model:

$$
\text{state} = \beta_0 + \beta_1 \, \text{country} + \beta_2 \, \text{goal} + \beta_3 \, \text{category}
$$

The **AIC** value of a model is 
$$
AIC=2k-2ln(\hat{L}),
$$
where $k$ is the number of estimated parameters and $\hat{L}$ is the maximum value of the likelihood function for the model (the parameter values are calculated by maximising the likelihood function on the observations). It is a measure of the relative goodness of fit between two predictive models, since it penalizes the complexity of the model and maximizes the likehood. 


```
## [1] "AIC 380881.255473576"
```

**Accuracy** is used to describe the closeness of a measurement to the true value, and is defined as the fraction of correct predictions over all predictions:
$$
\frac{TP+TN}{TP+TN+FP+FN}
$$
This model predicts success and failure with 57% accuracy. 


```
## [1] "Accuracy 0.575695783492313"
```

The table below shows the exact number of classifications in each case: 0 for failure, 1 for success.


```
##       predicted
## actual     0     1
##      0 60775  3002
##      1 46729  6700
```

Due to the high number of missclassifications, I decided to propose **Random Forest** as an alternative classification model.

Random Forest is a supervised learning algorithm based on the idea of decision tree learning: each interior node of the tree corresponds to one of the input variables, each of the possible values of an input variable generates a new branch and each leaf reprents the value of the target variable obtained by using all the values correspondent of the correspondent branch to the root. Random forest builds many decision trees on different subsamples of features, in order to prevent overfitting and get a more stable classification.

The problem with this model is that RAM consumption increases linearly with the number of estimators. Due to the capabilities of my machine, I could only use two predictors and the first 8000 entries of the dataset. 

Despite this limitation, I got an accuracy of 63% on the predictions, meaning that it could potentially give very good results on another machine.


```
## [1] "Accuracy 0.629166666666667"
```

```
##       predicted
## actual    0    1
##      0 2214 1054
##      1 1171 1561
```


The **ROC curve** gives a graphical representation of accuracy, showing the true positive rate againts the false positive rate of our binary classifier: the closer the curve follows left and top borders of the space, the more accurate the test is. 

![plot of chunk roc curve](figure/roc curve-1.png)

A comparison between the two models used confirms the above results. 

For more informations you can consult the article [2], proposing a comparison between additional models other than the two just presented. Here Logistic Regression and Random Forest respectively reach 69% and 78% accuracy.

## Conclusions

In this project I explored all the possible factors influencing the success of a kickstarter project, by underlying the relationship between pledges, categories, fundings and countries.

I proposed different visualizations of data through the use of `dplyr`, `ggplot2`, `worldcloud` and `highcharter` packages, including interactive representations.

In the final part, I presented two different models for the prediction of success of a kickstarter campaign based on the available informations.

## References

[1] https://www.kaggle.com/kemical/kickstarter-projects/data

[2] "Predicting the success of Kickstarter campaigns", Nida Hussain, Kareem Kamel, Archana Radhakrishna, 2017, unpublished.

[3] "An Introduction to Statistical Learning, with Applications in R", Gareth James, Daniela Witten, Trevor Hastie, Robert Tibshirani, Springer, 2014.

[4] "R for Data Science. Import, Tidy, Transform, Visualize,
and Model Data", Hadley Wickham, Garrett Grolemund, O'Reilly, 2017.

[5] "Data Analysis and Graphics Using R", John Maindonald, W. John Braun, 2003. 

[6] "Predicting the Success of Kickstarter	Campaigns", Peter (Haochen) Zhou, 2017, unpublished.
