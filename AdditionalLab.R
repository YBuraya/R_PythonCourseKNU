install.packages("stringr")
library(stringr)

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

answer_one <- function() {
  return(olympics[olympics$Gold == max(olympics$Gold),]$Country[[1]])
}
answer_one()

answer_two <- function() {
  id <- which(abs(olympics$Summer - olympics$Winter) == max(abs(olympics$Summer - olympics$Winter)))
  return(olympics[id,]$Country)
}
answer_two()

answer_three <- function() {
  filtered_olympics <- olympics[olympics$Gold > 0 & olympics$Gold.1 > 0,]
  id <- which(
    abs(filtered_olympics$Gold - filtered_olympics$Gold.1) / filtered_olympics$Gold.2
    == max(abs(filtered_olympics$Gold - filtered_olympics$Gold.1) / filtered_olympics$Gold.2)
  )
  return(filtered_olympics[id,]$Country)
}
answer_three()

answer_four <- function() {
  result <- olympics[c("Country")]
  result$Points <- olympics$Gold.2 * 3 + olympics$Silver.2 * 2 + olympics$Bronze.2 * 1
  return(result)
}
answer_four()
