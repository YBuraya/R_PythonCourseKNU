**1. Написати функцію pmean, яка обчислює середнє значення (mean) забруднення сульфатами або нітратами серед заданого переліка моніторів. Ця функція приймає три аргументи: «directory», «pollutant», «id». Directory – папка, в якій розміщені дані, pollutant – вид забруднення, id – перелік моніторів. Аргумент id має значення за замовчуванням 1:332. Функція повинна ігнорувати NA значення.**
``` r
pmean <- function(directory, pollutant, id = 1:332) {
  setwd(file.path(getwd(), directory)) ## вказуємо директорію
  sum = 0 ## сума всіх спостережень
  observation_count = 0 ## кількість спостережень
  
  for (i in id)
  {
    if (i < 10) { 
      csvData <- read.csv(paste("0","0", as.character(i), ".csv", sep=""), 
                       header = T, 
                       na.strings=c("NA","NaN", " "))
    } else if (i >= 10 & i < 100) { 
      csvData <- read.csv(paste("0", as.character(i), ".csv", sep=""),
                       header = T, 
                       na.strings=c("NA","NaN", " ") 
      )
    } else { 
      csvData <- read.csv(paste(as.character(i), ".csv", sep=""),
                       header = T, 
                       na.strings=c("NA","NaN", " ") 
      )
    }

    filteredData = na.omit(csvData)
    observation_count = observation_count + nrow(filteredData)
    if (pollutant == "sulfate") {sum = sum + sum(filteredData$sulfate)}
    else {sum = sum + sum(filteredData$nitrate)}
  }
  
  setwd("..")
  return (sum/observation_count)
}

#приклад
pmean("specdata", "nitrate", 1:20)
pmean("specdata", "nitrate", 10)
pmean("specdata", "sulfate")
```
```
> pmean("specdata", "nitrate", 1:20)
[1] 0.8322655
> pmean("specdata", "nitrate", 10)
[1] 0.6016534
> pmean("specdata", "sulfate")
[1] 3.194204
```

**2. Написати функцію complete, яка виводить кількість повних спостережень (the number of completely observed cases) для кожного файлу. Функція приймає два аргументи: «Directory» та «id» та повертає data frame, в якому перший стовпчик – ім’я файлу, а другий – кількість повних спостережень.**
``` r
complete <- function(directory,id=1:332) {
  dataframe = NULL  ## ініціалізація data frame
  setwd(file.path(getwd(), directory))
  
  for (i in id)
  {
    if (i <10) { 
      csvDataComplete <- read.csv(paste("0","0", as.character(i), ".csv", sep=""),
                       header = T, 
                       na.strings=c("NA","NaN", " "))
    } else if (i>=10 & i<100) { 
      csvDataComplete <- read.csv(paste("0", as.character(i), ".csv", sep=""),
                       header = T, 
                       na.strings=c("NA","NaN", " ") 
      )
    } else { 
      csvDataComplete <- read.csv(paste(as.character(i), ".csv", sep=""),   
                       header = T, 
                       na.strings=c("NA","NaN", " ") 
      )
    }
    
    filteredData = na.omit(csvDataComplete) 
    matrixData = as.matrix(filteredData)
    dataframe = rbind(dataframe, c(i,nrow(matrixData)))
  }
  
  setwd("..")
  finalDataframe = data.frame(dataframe)
  names(finalDataframe) = c('id', 'nobs')
  return (finalDataframe) 
}

#приклад
complete("specdata", 100)
complete("specdata", c(1, 3, 5, 7, 8))
complete("specdata", 10:20)
```
```
> complete("specdata", 100)
   id nobs
1 100  104
> complete("specdata", c(1, 3, 5, 7, 8))
  id nobs
1  1  117
2  3  243
3  5  402
4  7  442
5  8  192
> complete("specdata", 10:20)
   id nobs
1  10  148
2  11  443
3  12   96
4  13   46
5  14   96
6  15   83
7  16   60
8  17  927
9  18   84
10 19  353
11 20  124
```

**3. Написати функцію corr, яка приймає два аргументи: directory (папка, де знаходяться файли спостережень) та threshold (порогове значення, за замовчуванням дорівнює 0) та обчислює кореляцію між сульфатами та нітратами для моніторів, кількість повних спостережень для яких більше порогового значення. Функція повинна повернути вектор значень кореляцій. Якщо ні один монітор не перевищує порогового значення, функція повинна повернути numeric вектор довжиною 0. Для обчислення кореляції між сульфатами та нітратами використовуйте вбудовану функцію «cor» з параметрами за замовчуванням.**
``` r
corr <- function(directory, threshold=0) {
  setwd(file.path(getwd(), directory))
  corrVector = NULL
  
  for (i in 1:332)
  {     
    if (i < 10) { 
      corrCsvData <- read.csv(
        paste("0","0", as.character(i), ".csv", sep=""),
        header = T, 
        na.strings=c("NA","NaN", " ")
        
      )
    } else if (i >= 10 & i < 100) { 
      corrCsvData <- read.csv(
        paste("0", as.character(i), ".csv", sep=""),
        header = T, 
        na.strings=c("NA","NaN", " ") 
        
      )
    } else { 
      corrCsvData <- read.csv(
        paste(as.character(i), ".csv", sep=""),     ## Normal
        header = T, 
        na.strings=c("NA","NaN", " ") 
      )
    }
    
    filteredData = na.omit(corrCsvData) 
    if (nrow(filteredData) > threshold) {
      corrVector = c(corrVector, cor(filteredData[,2], filteredData[,3]))
    }
    
  }
  
  setwd("..")
  return (corrVector)
}


#приклад
cr <- corr("specdata", 100)
head(cr); summary(cr)

cr <- corr("specdata", 200)
head(cr); summary(cr)

cr <- corr("specdata", 1000)
head(cr); summary(cr) ; length(cr)
```
```
> cr <- corr("specdata", 100)
> head(cr); summary(cr)
[1] -0.22255256 -0.01895754 -0.14051254 -0.04389737 -0.06815956
[6] -0.12350667
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.28827 -0.05549  0.09034  0.11943  0.26597  0.76313 
> cr <- corr("specdata", 200)
> head(cr); summary(cr)
[1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667
[6] -0.07588814
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.21057 -0.04415  0.09914  0.13286  0.26859  0.76313 
> cr <- corr("specdata", 1000)
> head(cr); summary(cr) ; length(cr)
[1] -0.01895754  0.04191777  0.19014198
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.01896  0.01148  0.04192  0.07103  0.11603  0.19014 
[1] 3
```

