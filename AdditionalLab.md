# Додаткова лабораторна робота.

Встановимо та підключимо бібліотеку **stringr**:
``` r
install.packages("stringr")
library(stringr)
```

Напишіть функцію **prepare_set <- function(file_name) {}** яка в якості аргументу приймає ім’я файлу і повертає дата фрейм. Збережіть цей дата фрейм в змінну **olympics**<br/>**olympics <- prepare_set(“olympics.csv”)**
``` r
prepare_set <- function(file_name) {
  data <- read.csv(file_name, skip=1, header=TRUE, encoding="UTF-8", stringsAsFactors=FALSE)
  
  names(data)[1] <- "Country"

  for(current_name in colnames(data)) {
    new_name <- str_replace_all(current_name, "X.U.2116..", "")
    new_name <- str_replace_all(new_name, "X01..", "Gold")
    new_name <- str_replace_all(new_name, "X02..", "Silver")
    new_name <- str_replace_all(new_name, "X03..", "Bronze")
    # необхідно для виконання завдання, щоб стовпці мали правильні назви
    new_name <- str_replace_all(new_name, "X..", "")
    names(data)[names(data) == current_name] <- new_name
  }

  divided_data <- str_split(data$Country, "[:space:]\\(", simplify=TRUE)
  data$Country <- divided_data[,1]
  data$ID <- str_split(divided_data[,2],"\\)", simplify=TRUE)[,1]
  data <- data[-nrow(data),]
  return(data)
}

olympics <- prepare_set("olympics.csv")
```

**Питання 1**\
Котра країна виграла найбільшу кількість золотих нагород на літніх іграх?
Функція повинна повернути одне текстове значення.
``` r
answer_one <- function() {
  return(olympics[olympics$Gold == max(olympics$Gold),]$Country[[1]])
}
answer_one()
```
``` r
[1] "United States"
```

**Питання 2**\
Яка країна має найбільшу різницю між кількістю нагород на літніх та зимових
іграх?
Функція повинна повернути одне текстове значення.
``` r
answer_two <- function() {
  id <- which(abs(olympics$Summer - olympics$Winter) == max(abs(olympics$Summer - olympics$Winter)))
  return(olympics[id,]$Country)
}
answer_two()
```
``` r
[1] "Egypt"
```

**Питання 3**\
В якій крайні найбільша різниця між літніми та зимовими золотими нагородами
відносно до загальної кількості нагород (Summer Gold - Winter Gold) / Total Gold.
Врахувати тільки країни які мають як мінімум по одній нагороді в літніх та
зимових іграх.
Функція повинна повернути одне текстове значення.
``` r
answer_three <- function() {
  filtered_olympics <- olympics[olympics$Gold > 0 & olympics$Gold.1 > 0,]
  id <- which(
    abs(filtered_olympics$Gold - filtered_olympics$Gold.1) / filtered_olympics$Gold.2
    == max(abs(filtered_olympics$Gold - filtered_olympics$Gold.1) / filtered_olympics$Gold.2)
  )
  return(filtered_olympics[id,]$Country)
}
answer_three()
```
``` r
[1] "Bulgaria"
```

**Питання 4**\
Необхідно знайти кількість балів по кожній крайні. Бали рахуються наступним
чином: Золота нагорода Gold.2 це три бали, срібна Silver.2 - 2 бали та бронзова
Bronze.2 – 1 бал.
Функція повинна повертати дата фрейм довжиною 146, який складається з двох
колонок: "Country", "Points".
``` r
answer_four <- function() {
  result <- olympics[c("Country")]
  result$Points <- olympics$Gold.2 * 3 + olympics$Silver.2 * 2 + olympics$Bronze.2 * 1
  return(result)
}
answer_four()
```
``` r
                             Country Points
1                        Afghanistan      2
2                            Algeria     27
3                          Argentina    130
4                            Armenia     16
5                        Australasia     22
6                          Australia    923
7                            Austria    569
8                         Azerbaijan     43
9                            Bahamas     24
10                           Bahrain      1
11                          Barbados      1
12                           Belarus    154
13                           Belgium    276
14                           Bermuda      1
15                           Bohemia      5
16                          Botswana      2
17                            Brazil    184
18               British West Indies      2
19                          Bulgaria    411
20                           Burundi      3
21                          Cameroon     12
22                            Canada    846
23                             Chile     24
24                             China   1120
25                          Colombia     29
26                        Costa Rica      7
27                       Ivory Coast      2
28                           Croatia     67
29                              Cuba    420
30                            Cyprus      2
31                    Czech Republic    134
32                    Czechoslovakia    327
33                           Denmark    335
34                          Djibouti      1
35                Dominican Republic     14
36                           Ecuador      5
37                             Egypt     49
38                           Eritrea      1
39                           Estonia     77
40                          Ethiopia     94
41                           Finland    895
42                            France   1500
43                             Gabon      2
44                           Georgia     42
45                           Germany   1546
46            United Team of Germany    269
47                      East Germany   1068
48                      West Germany    459
49                             Ghana      5
50                     Great Britain   1574
51                            Greece    213
52                           Grenada      3
53                         Guatemala      2
54                            Guyana      1
55                             Haiti      3
56                         Hong Kong      6
57                           Hungary    962
58                           Iceland      6
59                             India     50
60                         Indonesia     49
61                              Iran    110
62                              Iraq      1
63                           Ireland     55
64                            Israel     10
65                             Italy   1333
66                           Jamaica    131
67                             Japan    866
68                        Kazakhstan    113
69                             Kenya    168
70                       North Korea     90
71                       South Korea    609
72                            Kuwait      2
73                        Kyrgyzstan      4
74                            Latvia     47
75                           Lebanon      6
76                     Liechtenstein     15
77                         Lithuania     38
78                        Luxembourg      9
79                         Macedonia      1
80                          Malaysia      9
81                         Mauritius      1
82                            Mexico    109
83                           Moldova      9
84                          Mongolia     37
85                        Montenegro      2
86                           Morocco     39
87                        Mozambique      4
88                           Namibia      8
89                       Netherlands    727
90              Netherlands Antilles      2
91                       New Zealand    203
92                             Niger      1
93                           Nigeria     37
94                            Norway    985
95                          Pakistan     19
96                            Panama      5
97                          Paraguay      2
98                              Peru      9
99                       Philippines     11
100                           Poland    520
101                         Portugal     39
102                      Puerto Rico     10
103                            Qatar      4
104                          Romania    572
105                           Russia   1042
106                   Russian Empire     14
107                     Soviet Union   2526
108                     Unified Team    287
109                     Saudi Arabia      4
110                          Senegal      2
111                           Serbia     11
112            Serbia and Montenegro     17
113                        Singapore      6
114                         Slovakia     58
115                         Slovenia     56
116                     South Africa    148
117                            Spain    268
118                        Sri Lanka      4
119                            Sudan      2
120                         Suriname      4
121                           Sweden   1217
122                      Switzerland    630
123                            Syria      6
124                   Chinese Taipei     32
125                       Tajikistan      4
126                         Tanzania      4
127                         Thailand     44
128                             Togo      1
129                            Tonga      2
130              Trinidad and Tobago     27
131                          Tunisia     19
132                           Turkey    191
133                           Uganda     14
134                          Ukraine    220
135             United Arab Emirates      3
136                    United States   5684
137                          Uruguay     16
138                       Uzbekistan     38
139                        Venezuela     18
140                          Vietnam      4
141                   Virgin Islands      2
142                       Yugoslavia    171
143 Independent Olympic Participants      4
144                           Zambia      3
145                         Zimbabwe     18
146                       Mixed team     38
```