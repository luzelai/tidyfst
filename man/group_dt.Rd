% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/group_dt.R
\name{group_dt}
\alias{group_dt}
\alias{rowwise_dt}
\title{Data manipulation within groups}
\usage{
group_dt(.data, by = NULL, ...)

rowwise_dt(.data, ...)
}
\arguments{
\item{.data}{A data.frame}

\item{by}{Variables to group by,unquoted name of grouping variable of list of unquoted names of grouping variables.}

\item{...}{Any data manipulation arguments that could be implemented on a data.frame.}
}
\value{
data.table
}
\description{
Analogous function for \code{group_by} and \code{rowwise}
 in \pkg{dplyr}, but in another efficient way.
}
\details{
If you want to use \code{summarise_dt} and \code{mutate_dt} in
\code{group_dt}, it is better to use the "by" parameter in those functions,
that would be much faster because you don't have to use \code{.SD} (which takes
extra time to copy).
}
\examples{
iris \%>\% group_dt(by = Species,slice_dt(1:2))
iris \%>\% group_dt(Species,filter_dt(Sepal.Length == max(Sepal.Length)))
iris \%>\% group_dt(Species,summarise_dt(new = max(Sepal.Length)))

# you can pipe in the `group_dt`
iris \%>\% group_dt(Species,
                  mutate_dt(max= max(Sepal.Length)) \%>\%
                    summarise_dt(sum=sum(Sepal.Length)))

# for users familiar with data.table, you can work on .SD directly
# following codes get the first and last row from each group
iris \%>\%
  group_dt(
    by = Species,
    rbind(.SD[1],.SD[.N])
  )

#' # for summarise_dt, you can use "by" to calculate within the group
mtcars \%>\%
  summarise_dt(
   disp = mean(disp),
   hp = mean(hp),
   by = cyl
)

  # but you could also, of course, use group_dt
 mtcars \%>\%
   group_dt(by =.(vs,am),
     summarise_dt(avg = mean(mpg)))

  # and list of variables could also be used
 mtcars \%>\%
   group_dt(by =list(vs,am),
            summarise_dt(avg = mean(mpg)))

# examples for `rowwise_dt`
df <- data.table(x = 1:2, y = 3:4, z = 4:5)

df \%>\% mutate_dt(m = mean(c(x, y, z)))

df \%>\% rowwise_dt(
  mutate_dt(m = mean(c(x, y, z)))
)
}
\references{
https://stackoverflow.com/questions/36802385/use-by-each-row-for-data-table
}
