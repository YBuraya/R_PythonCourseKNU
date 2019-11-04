**1. Створити змінні базових (atomic) типів. Базові типи: character, numeric, integer, complex, logical.**
``` r
varCharacter <- "varCharacter"

varNumeric <- 1

varInteger <- 10L

varComplex <- 99i + 99

varLogical <- TRUE
```

**2. Створити вектори, які: містить послідовність з 5 до 75; містить числа 3.14, 2.71, 0, 13; 100 значень TRUE.**
``` r
vector0 <- 5:75

vector1 <- c(3.14, 2.71, 0, 13)

vector2 <- rep(TRUE, times=100)
```

**3. Створити наступну матрицю за допомогою matrix, та за допомогою cbind або rbind**
``` r
# за допомогою matrix
matrixMatrix <- matrix(c(.5, 3.9, 0, 2, 1.3, 131, 2.2, 7, 3.5, 2.8, 4.6, 5.1), nrow=4, ncol=3)

# за допомогою cbind
matrixColumn0 <- c(.5, 3.9, 0, 2)
matrixColumn1 <- c(1.3, 131, 2.2, 7)
matrixColumn2 <- c(3.5, 2.8, 4.6, 5.1)

matrixCbind <- cbind(matrixColumn0, matrixColumn1, matrixColumn2)
```

**4. Створити довільний список (list), в який включити всі базові типи.**
``` r
newList <- list("char", 32, 32L, 32i + 32, FALSE)
```

**5. Створити фактор з трьома рівнями «baby», «child», «adult».**
``` r
newFactor <- factor(c("baby", "child", "adult", "baby", "child", "baby", "child", "adult", "adult"), levels = c("baby", "child", "adult"))
```

**6. Знайти індекс першого значення NA в векторі 1, 2, 3, 4, NA, 6, 7, NA, 9, NA, 11. Знайти кількість значень NA.**
``` r
newVector <- c(1, 2, 3, 4, NA, 6, 7, NA, 9, NA, 11)

match(NA, newVector)

countNA <- length(newVector[is.na(newVector)])
```
```
[1] 5

[1] 3
```

**7. Створити довільний data frame та вивести в консоль.**
``` r
emloyeeid <- 1:3
employee <- c('John Doe','Peter Gynn','Jolie Hope')
salary <- c(21000, 23400, 26800)
startdate <- as.Date(c('2019-11-1','2019-3-25','2019-3-14'))
dataFrame <- data.frame(emloyeeid, employee, salary, startdate, stringsAsFactors = FALSE)

print(dataFrame)
```
```
  emloyeeid   employee salary  startdate
1         1   John Doe  21000 2019-11-01
2         2 Peter Gynn  23400 2019-03-25
3         3 Jolie Hope  26800 2019-03-14
```

**8. Змінити імена стовпців цього data frame.**
``` r
names(dataFrame) <- c("ID of Employee", "Employee Name", "Salary", "Start Date")

print(dataFrame)
```
```
  ID of Employee Employee Name Salary Start Date
1              1      John Doe  21000 2019-11-01
2              2    Peter Gynn  23400 2019-03-25
3              3    Jolie Hope  26800 2019-03-14
```
