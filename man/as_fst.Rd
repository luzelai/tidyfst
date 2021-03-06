% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as_fst.R
\name{as_fst}
\alias{as_fst}
\title{Save a data.frame as a fst table}
\usage{
as_fst(.data)
}
\arguments{
\item{.data}{A data.frame}
}
\value{
An object of class \code{fst_table}
}
\description{
This function first export the data.frame to a temporal file,
and then parse it back as a fst table (class name is "fst_table").
}
\examples{

\dontrun{
  iris \%>\%
    as_fst() -> iris_fst
  iris_fst
}
}
