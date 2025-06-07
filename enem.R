#!/usr/bin/env Rscript

get_script_path <- function() {
  args_full <- commandArgs(trailingOnly = FALSE)
  file_arg <- "--file="
  script_path <- sub(file_arg, "", args_full[grep(file_arg, args_full)])
  if (length(script_path) == 0) return(".")
  normalizePath(dirname(script_path))
}

dir_base <- get_script_path()

source(file.path(dir_base, "conf", "config.R"))

if (comando == "sample") {
  if (!is.null(flags[["-f"]])) {
    percent <- if (!is.null(flags[["-p"]])) flags[["-p"]] else 1
    seed <- if (!is.null(flags[["-s"]])) flags[["-s"]] else NULL
    amostra(file.path(path_data, flags[["-f"]]), percent = percent, seed = seed)
  } else {
    stop("Uso: sample -f <arquivo> [-p <percentual>] [-s <seed>]")
  }
} else if (comando == "sd") {
  if (!is.null(flags[["-v"]])) {
    variaveis <- strsplit(flags[["-v"]], ",")[[1]]
    desvio_padrao(variaveis)
  } else {
    stop("Uso: sd -v <vetor,...>")
  }
} else if (comando == "bp") {
  if (!is.null(flags[["-v"]])) {
    variaveis <- strsplit(flags[["-v"]], ",")[[1]]
    boxplot(variaveis)
  } else {
    stop("Uso: bp -v <vetor,...>")
  }
} else if (comando == "anova") {
  if (!is.null(flags[["-v"]]) && !is.null(flags[["-c"]])) {
    variaveis <- strsplit(flags[["-v"]], ",")[[1]]
    comparar <- flags[["-c"]]
    anova(variaveis, comparar)
  } else {
    stop("Uso: anova -v <valor2,valor2,...> -c <comparar>")
  }
} else if (comando == "summary") {
  sumario()
} else if (comando == "lm") {
  modeloLinear()
} else {
  stop("Comando inválido.")
}