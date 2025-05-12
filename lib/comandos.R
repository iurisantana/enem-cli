args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  stop("Nenhum comando fornecido.")
}

parse_flags <- function(args) {
  flags <- list()
  i <- 1
  while (i <= length(args)) {
    if (grepl("^-[a-zA-Z]$", args[i])) {
      key <- args[i]
      if ((i + 1) <= length(args) && !grepl("^-", args[i + 1])) {
        value <- args[i + 1]
        i <- i + 1
      } else {
        value <- TRUE
      }
      flags[[key]] <- value
    }
    i <- i + 1
  }
  return(flags)
}

comando <- args[1]
flags <- parse_flags(args[-1])