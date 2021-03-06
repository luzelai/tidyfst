% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/join_dt.R
\name{join}
\alias{join}
\alias{left_join_dt}
\alias{right_join_dt}
\alias{inner_join_dt}
\alias{full_join_dt}
\alias{anti_join_dt}
\alias{semi_join_dt}
\alias{ljoin}
\alias{rjoin}
\alias{ijoin}
\alias{fjoin}
\alias{ajoin}
\alias{sjoin}
\title{Join table by common keys}
\usage{
left_join_dt(x, y, by = NULL, suffix = c(".x", ".y"))

right_join_dt(x, y, by = NULL, suffix = c(".x", ".y"))

inner_join_dt(x, y, by = NULL, suffix = c(".x", ".y"))

full_join_dt(x, y, by = NULL, suffix = c(".x", ".y"))

anti_join_dt(x, y, by = NULL)

semi_join_dt(x, y, by = NULL)

ljoin(x, y, by = NULL)

rjoin(x, y, by = NULL)

ijoin(x, y, by = NULL)

fjoin(x, y, by = NULL)

ajoin(x, y, by = NULL)

sjoin(x, y, by = NULL)
}
\arguments{
\item{x}{data.frame}

\item{y}{data.frame}

\item{by}{For functions without suffix \code{_dt},
this parameter will pass to the
\code{on} paramter to the data.table. Details could be found at
\code{\link[data.table]{data.table}}.Examples included:
1.\code{.by = c("a","b")} (this is a must for \code{set_full_join});
2.\code{.by = c(x1="y1", x2="y2")};
3.\code{.by = c("x1==y1", "x2==y2")};
4.\code{.by = c("a", V2="b")};
5.\code{.by = .(a, b)};
6.\code{.by = c("x>=a", "y<=b")} or \code{.by = .(x>=a, y<=b)}.}

\item{suffix}{If there are non-joined duplicate variables in x and y, these
suffixes will be added to the output to disambiguate them. Should be a
character vector of length 2.}
}
\value{
data.table
}
\description{
Join operations.

For functions without suffix \code{_dt}, they use
\code{X[Y]} syntax to join tables, and pass the "by" parameter to
"on" in data.table. They have different features and syntax. They
starts with first letter of left/right/full/inner/semi/anti.
}
\examples{

workers = fread("
    name company
    Nick Acme
    John Ajax
    Daniela Ajax
")

positions = fread("
    name position
    John designer
    Daniela engineer
    Cathie manager
")

workers \%>\% inner_join_dt(positions)
workers \%>\% left_join_dt(positions)
workers \%>\% right_join_dt(positions)
workers \%>\% full_join_dt(positions)

# filtering joins
workers \%>\% anti_join_dt(positions)
workers \%>\% semi_join_dt(positions)

# To suppress the message, supply 'by' argument
workers \%>\% left_join_dt(positions, by = "name")

# Use a named 'by' if the join variables have different names
positions2 = setNames(positions, c("worker", "position")) # rename first column in 'positions'
workers \%>\% inner_join_dt(positions2, by = c("name" = "worker"))

# the syntax of non-"_dt" suffix joins is a bit different
workers \%>\% ijoin(positions2,by = "name==worker")

x= data.table(a=1:5,a1 = 2:6,b=11:15)
y= data.table(a=c(1:4,6), a1 = c(1,2,4,5,1),c=c(101:104,106))

merge(x,y,all = TRUE) -> a
fjoin(x,y,by = c("a","a1")) -> b
data.table::setcolorder(a,names(b))

fsetequal(a,b)
}
\seealso{
\code{\link[dplyr]{left_join}}
}
