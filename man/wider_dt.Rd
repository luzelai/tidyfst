% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wider_dt.R
\name{wider_dt}
\alias{wider_dt}
\title{Pivot data from long to wide}
\usage{
wider_dt(.data, ..., name, value = NULL, fun = NULL, fill = NA)
}
\arguments{
\item{.data}{A data.frame}

\item{...}{Optional. The unchanged group in the transformation.
Could use integer vector, could receive what \code{select_dt} receives.}

\item{name}{Chracter.One column name of class to spread}

\item{value}{Chracter.One column name of value to spread.
If \code{NULL}, use all other variables.}

\item{fun}{Should the data be aggregated before casting?
Defaults to \code{NULL}, which uses \code{length} for aggregation.
If a function is provided, with aggregated by this function.}

\item{fill}{Value with which to fill missing cells. Default uses \code{NA}.}
}
\value{
data.table
}
\description{
Analogous function for \code{pivot_wider} in \pkg{tidyr}.
}
\details{
The parameter of `name` and `value` should always
be provided and should be explicit called (with the parameter names attached).
}
\examples{
 stocks = data.frame(
   time = as.Date('2009-01-01') + 0:9,
   X = rnorm(10, 0, 1),
   Y = rnorm(10, 0, 2),
   Z = rnorm(10, 0, 4)
 ) \%>\%
   longer_dt(time) -> longer_stocks

 longer_stocks

 longer_stocks \%>\%
   wider_dt("time",
            name = "name",
            value = "value")

 longer_stocks \%>\%
   mutate_dt(one = 1) \%>\%
   wider_dt("time",
            name = "name",
            value = "one")

## using "fun" parameter for aggregation
DT <- data.table(v1 = rep(1:2, each = 6),
                 v2 = rep(rep(1:3, 2), each = 2),
                 v3 = rep(1:2, 6),
                 v4 = rnorm(6))
## for each combination of (v1, v2), add up all values of v4
DT \%>\%
  wider_dt(v1,v2,
           value = "v4",
           name = ".",
           fun = sum)
}
\seealso{
\code{\link[tidyfst]{longer_dt}},
 \code{\link[data.table]{dcast}},
 \code{\link[tidyr]{pivot_wider}}
}
