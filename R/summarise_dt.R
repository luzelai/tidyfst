
#' @title Summarise columns to single values
#' @name summarise_dt
#' @description Analogous function for \code{summarise}  in \pkg{dplyr}.
#' @param .data data.frame
#' @param ... List of variables or name-value pairs of summary/modifications
#'   functions for \code{summarise_dt}.Additional parameters to be passed to
#'    parameter '.func' in \code{summarise_vars}.
#' @param by unquoted name of grouping variable of list of unquoted names of
#'   grouping variables. For details see \link[data.table]{data.table}
#' @param when An object which can be coerced to logical mode
#' @param .cols Columns to be summarised.
#' @param .func Function to be run within each column, should return a value or vectors with same length.
#' @details \code{summarise_vars} could complete summarise on specific columns.
#' @return data.table
#' @seealso \code{\link[dplyr]{summarise}}
#' @examples
#' iris %>% summarise_dt(avg = mean(Sepal.Length))
#' iris %>% summarise_dt(avg = mean(Sepal.Length),by = Species)
#' mtcars %>% summarise_dt(avg = mean(hp),by = .(cyl,vs))
#'
#' # the data.table way
#' mtcars %>% summarise_dt(cyl_n = .N, by = .(cyl, vs)) # `.`` is short for list
#'
#' iris %>% summarise_vars(is.numeric,min)
#' iris %>% summarise_vars(-is.factor,min)
#' iris %>% summarise_vars(1:4,min)
#' iris %>% summarise_vars(.func = as.character)
#'
#' iris %>% summarise_vars(is.numeric,min,by ="Species")
#' mtcars %>% summarise_vars(is.numeric,mean,by = "vs,am")

globalVariables("res")

#' @rdname summarise_dt
#' @export

summarise_dt = function(.data,...,by = NULL){
  dt = as_dt(.data)
  eval(substitute(dt[,.(...),by = by]))
}

#' @rdname summarise_dt
#' @export

summarize_dt = summarise_dt

#' @rdname summarise_dt
#' @export

summarise_when = function(.data,when,...,by = NULL){
  dt = as_dt(.data)
  eval(substitute(dt[when,.(...),by = by]))
}

#' @rdname summarise_dt
#' @export

summarize_when = summarise_when

#' @rdname summarise_dt
#' @export

summarise_vars = function (.data, .cols = NULL, .func, ...,by) {
  dt = as_dt(.data)
  deparse(substitute(.cols)) -> .cols
  deparse(substitute(by)) -> .by
  if (.cols == "NULL")
    sel_name = names(dt[0])
  else{
    eval(
      parse(
        text =
          str_glue("select_dt(dt[0],{.cols}) %>% names() -> sel_name")))
  }

  eval(parse(text = str_glue(
  "res = dt[,lapply(.SD, .func, ...), by = {.by},.SDcols = sel_name]")))
  res[, unique(names(res)), with = FALSE]
}



#' @rdname summarise_dt
#' @export

summarize_vars = summarise_vars




