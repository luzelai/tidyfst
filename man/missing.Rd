% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/missing.R
\name{drop_na_dt}
\alias{drop_na_dt}
\alias{replace_na_dt}
\alias{delete_na_cols}
\alias{delete_na_rows}
\alias{fill_na_dt}
\alias{shift_fill}
\title{Dump, replace and fill missing values in data.frame}
\usage{
drop_na_dt(.data, ...)

replace_na_dt(.data, ..., to)

delete_na_cols(.data, prop = NULL, n = NULL)

delete_na_rows(.data, prop = NULL, n = NULL)

fill_na_dt(.data, ..., direction = "down")

shift_fill(x, direction = "down")
}
\arguments{
\item{.data}{data.frame}

\item{...}{Colunms to be replaced or filled. If not specified, use all columns.}

\item{to}{What value should NA replace by?}

\item{prop}{If proportion of NAs is larger than or equal to "prop", would be deleted.}

\item{n}{If number of NAs is larger than or equal to "n", would be deleted.}

\item{direction}{Direction in which to fill missing values.
Currently either "down" (the default) or "up".}

\item{x}{A vector with missing values to be filled.}
}
\value{
data.table
}
\description{
Analogous function for \code{drop_na}, \code{replace_na} and
\code{fill} in \pkg{tidyr}, but with a different API.
}
\details{
\code{drop_na_dt} drops the entries with NAs in specific columns.
\code{fill_na_dt} fill NAs with observations ahead ("down") or below ("up"),
which is also known as last observation carried forward (LOCF) and
next observation carried backward(NOCB).

\code{delete_na_cols} could drop the columns with NA proportion larger
than or equal to "prop" or NA number larger than or equal to "n",
\code{delete_na_rows} works alike but deals with rows.

\code{shift_fill} could fill a vector with missing values.
}
\examples{
df <- data.table(x = c(1, 2, NA), y = c("a", NA, "b"))
 df \%>\% drop_na_dt()
 df \%>\% drop_na_dt(x)
 df \%>\% drop_na_dt(y)
 df \%>\% drop_na_dt(x,y)

 df \%>\% replace_na_dt(to = 0)
 df \%>\% replace_na_dt(x,to = 0)
 df \%>\% replace_na_dt(y,to = 0)
 df \%>\% replace_na_dt(x,y,to = 0)

 df \%>\% fill_na_dt(x)
 df \%>\% fill_na_dt() # not specified, fill all columns
 df \%>\% fill_na_dt(y,direction = "up")

x = data.frame(x = c(1, 2, NA, 3), y = c(NA, NA, 4, 5),z = rep(NA,4))
x
x \%>\% delete_na_cols()
x \%>\% delete_na_cols(prop = 0.75)
x \%>\% delete_na_cols(prop = 0.5)
x \%>\% delete_na_cols(prop = 0.24)
x \%>\% delete_na_cols(n = 2)

x \%>\% delete_na_rows(prop = 0.6)
x \%>\% delete_na_rows(n = 2)

# shift_fill
y = c("a",NA,"b",NA,"c")

shift_fill(y) # equals to
shift_fill(y,"down")

shift_fill(y,"up")
}
\references{
https://stackoverflow.com/questions/23597140/how-to-find-the-percentage-of-nas-in-a-data-frame

https://stackoverflow.com/questions/2643939/remove-columns-from-dataframe-where-all-values-are-na

https://stackoverflow.com/questions/7235657/fastest-way-to-replace-nas-in-a-large-data-table
}
\seealso{
\code{\link[tidyr]{drop_na}},\code{\link[tidyr]{replace_na}},
\code{\link[tidyr]{fill}}
}
