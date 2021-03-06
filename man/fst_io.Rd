% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fst_io.R
\name{export_fst}
\alias{export_fst}
\alias{import_fst}
\title{Read and write fst files}
\usage{
export_fst(x, path, compress = 100, uniform_encoding = TRUE)

import_fst(
  path,
  columns = NULL,
  from = 1,
  to = NULL,
  as.data.table = TRUE,
  old_format = FALSE
)
}
\arguments{
\item{x}{a data frame to write to disk}

\item{path}{path to fst file}

\item{compress}{value in the range 0 to 100, indicating the amount of compression to use.
Lower values mean larger file sizes. The default compression is set to 50.}

\item{uniform_encoding}{If `TRUE`, all character vectors will be assumed to have elements with equal encoding.
The encoding (latin1, UTF8 or native) of the first non-NA element will used as encoding for the whole column.
This will be a correct assumption for most use cases.
If `uniform.encoding` is set to `FALSE`, no such assumption will be made and all elements will be converted
to the same encoding. The latter is a relatively expensive operation and will reduce write performance for
character columns.}

\item{columns}{Column names to read. The default is to read all columns.}

\item{from}{Read data starting from this row number.}

\item{to}{Read data up until this row number. The default is to read to the last row of the stored dataset.}

\item{as.data.table}{If TRUE, the result will be returned as a \code{data.table} object. Any keys set on
dataset \code{x} before writing will be retained. This allows for storage of sorted datasets. This option
requires \code{data.table} package to be installed.}

\item{old_format}{must be FALSE, the old fst file format is deprecated and can only be read and
converted with fst package versions 0.8.0 to 0.8.10.}
}
\value{
`import_fst` returns a data.table with the selected columns and rows. `export_fst`
writes `x` to a `fst` file and invisibly returns `x` (so you can use this function in a pipeline).
}
\description{
Wrapper for \code{\link[fst]{read_fst}} and \code{\link[fst]{write_fst}}
from \pkg{fst}, but use a different default. For data import, always return a data.table.
For data export, always compress the data to the smallest size.
}
\examples{
\dontrun{
export_fst(iris,"iris_fst_test.fst")
iris_dt = import_fst("iris_fst_test.fst")
iris_dt
unlink("iris_fst_test.fst")
}
}
\seealso{
\code{\link[fst]{read_fst}}
}
