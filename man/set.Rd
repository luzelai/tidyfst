% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/set.R
\name{set_in_dt}
\alias{set_in_dt}
\alias{set_mutate}
\alias{set_arrange}
\alias{set_rename}
\alias{set_relocate}
\alias{set_add_count}
\alias{set_replace_na}
\alias{set_fill_na}
\title{Fast operations of data.table by reference (II)}
\usage{
set_in_dt(.data, ...)

set_mutate(.data, ..., by = NULL)

set_arrange(.data, ..., cols = NULL, order = 1L)

set_rename(.data, ...)

set_relocate(.data, ..., how = "first", where = NULL)

set_add_count(.data, ..., .name = "n")

set_replace_na(.data, ..., to)

set_fill_na(.data, ..., direction = "down")
}
\arguments{
\item{.data}{A data.table}

\item{...}{For \code{set_in_dt}: Receive '[i,j,by]' in data.table syntax.
 See \code{\link[tidyfst]{in_dt}}.
For \code{set_mutate}:
 List of variables or name-value pairs of summary/modifications functions.
 See \code{\link[tidyfst]{mutate_dt}}.
For \code{set_arrange}:
 Arrange by what group? Minus means descending order.
 See \code{\link[tidyfst]{arrange_dt}}.
For \code{set_rename}:
 List of variables or name-value pairs of summary/modifications functions.
 See \code{\link[tidyfst]{rename_dt}}.
For \code{set_relocate}: Columns to move.
 See \code{\link[tidyfst]{relocate_dt}}
For \code{set_add_count}: Variables to group by.
 See \code{\link[tidyfst]{add_count_dt}}
For \code{set_replace_na} and \code{set_fill_na}:
 Colunms to be replaced or filled. If not specified, use all columns.
 See \code{\link[tidyfst]{fill_na_dt}}}

\item{by}{Mutate by which group(s)?}

\item{cols}{For \code{set_arrange}:A character vector of column names of x by which to order.
If present, override \code{...}. Defaults to \code{NULL}.}

\item{order}{For \code{set_arrange}:An integer vector with only possible
values of 1 and -1, corresponding to ascending and descending order.
Defaults to 1.}

\item{how}{For \code{set_relocate}:The mode of movement, including "first","last","after","before". Default uses "first".}

\item{where}{For \code{set_relocate}:Destination of columns selected by .... Applicable for "after" and "before" mode.}

\item{.name}{For \code{set_add_count}:
Character. Name of resulting variable. Default uses "n".}

\item{to}{What value should NA replace by?}

\item{direction}{Direction in which to fill missing values. Currently either "down" (the default) or "up".}
}
\value{
The input is modified by reference, and returned (invisibly)
so it can be used in compound statements.
}
\description{
Combination of \code{set*} functions provided by \pkg{data.table}.
 This is memeroy efficient because no copy is made at all.
}
\details{
These are a set of functions for modification
on data.table by reference. They follow the same syntax of similar
\pkg{tidyfst} functions. They do not return the result and considered
to be memory efficient.
}
\examples{

library(pryr)
rm(list = ls())

nr_of_rows <- 1e5

df <- data.table(
  Logical = sample(c(TRUE, FALSE, NA),
                   prob = c(0.85, 0.1, 0.05),
                   nr_of_rows, replace = TRUE)
)

mem_change(mutate_dt(df,one = 1) -> res)

# makes no copy, update on "df" directly
mem_change(set_mutate(df,one = 1))

all.equal(res,df)
}
\seealso{
\code{\link[tidyfst]{set_dt}}
}
