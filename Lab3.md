**1. Функція add2(x, y), яка повертає суму двох чисел.**
``` r
add2 <- function(x,y){ x+y }

#приклад
add2(99,1)
```
```
[1] 100
```

**2. Функція above(x, n), яка приймає вектор та число n, та повертає всі елементі вектору, які більше n. По замовчуванню n = 10.**
``` r
above <- function(x,n=10) { x[x>n] }

#приклад
above(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), 5)
```
```
[1]  6  7  8  9 10
```

**3. Функція my_ifelse(x, exp, n), яка приймає вектор x, порівнює всі його елементи за допомогою exp з n, та повертає елементи вектору, які відповідають умові expression. Наприклад, my_ifelse(x, “>”, 0) повертає всі елементи x, які більші 0. Exp може дорівнювати “<”, “>”, “<=”, “>=”, “==”. Якщо exp не співпадає ні з одним з цих виразів, повертається вектор x.**
``` r
my_ifelse <- function(x,exp,n=10) {
  if (exp == "<") { x[x<n] }
  else if (exp == ">") { x[x>n] }
  else if (exp == "<=") { x[x<=n] }
  else if (exp == ">=") { x[x>=n] }
  else if (exp == "==") { x[x==n] }
  else { x }
}

#приклад
x <- 1:20
my_ifelse(x,">",5)
```
```
 [1]  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

**4. Функція columnmean(x, removeNA), яка розраховує середнє значення (mean) по кожному стовпцю матриці, або data frame. Логічний параметр removeNA вказує, чи видаляти NA значення. По замовчуванню він дорівнює TRUE.**
``` r
columnmean <- function(x, removeNA=TRUE){
  col_n <- ncol(x)
  col_means <- numeric(col_n)
  for (i in 1:col_n){
    col_means[i]<-mean(x[,i],na.rm=removeNA)
  }
  col_means
}

#приклад
exampleMatrix <- matrix(c(1, 2, 3, 4, 5, 6), nrow=2, ncol=3)
columnmean(exampleMatrix)
```
```
[1] 1.5 3.5 5.5
```
