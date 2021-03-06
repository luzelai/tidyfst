% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/impute_dt.R
\name{impute_dt}
\alias{impute_dt}
\title{Impute missing values with mean, median or mode}
\usage{
impute_dt(.data, ..., .func = "mode")
}
\arguments{
\item{.data}{A data.frame}

\item{...}{Columns to select}

\item{.func}{Character, "mode" (default), "mean" or "median".
Could also define it by oneself.}
}
\value{
A data.table
}
\description{
Impute the columns of data.frame with its mean, median or mode.
}
\examples{

Pclass <- c(3, 1, 3, 1, 3, 2, 2, 3, NA, NA)
Sex <- c('male', 'male', 'female', 'female', 'female',
         'female', NA, 'male', 'female', NA)
Age <- c(22, 38, 26, 35, NA,
         45, 25, 39, 28, 40)
SibSp <- c(0, 1, 3, 1, 2, 3, 2, 2, NA, 0)
Fare <- c(7.25, 71.3, 7.92, NA, 8.05, 8.46, 51.9, 60, 32, 15)
Embarked <- c('S', NA, 'S', 'Q', 'Q', 'S', 'C', 'S', 'C', 'S')
data <- data.frame('Pclass' = Pclass,
 'Sex' = Sex, 'Age' = Age, 'SibSp' = SibSp,
 'Fare' = Fare, 'Embarked' = Embarked)

data
data \%>\% impute_dt() # defalut uses "mode" as `.func`
data \%>\% impute_dt(is.numeric,.func = "mean")
data \%>\% impute_dt(is.numeric,.func = "median")

# use user defined function
my_fun = function(x){
  (max(x,na.rm = TRUE) - min(x,na.rm = TRUE))/2
}
data \%>\% impute_dt(is.numeric,.func = my_fun)

}
