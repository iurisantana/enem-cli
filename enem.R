#!/usr/bin/env Rscript

# Função segura para descobrir caminho base
get_script_path <- function() {
  args_full <- commandArgs(trailingOnly = FALSE)
  file_arg <- "--file="
  script_path <- sub(file_arg, "", args_full[grep(file_arg, args_full)])
  if (length(script_path) == 0) return(".")
  normalizePath(dirname(script_path))
}

dir_base <- get_script_path()

# Carrega sources
source(file.path(dir_base, "conf", "config.R"))


# Ações conforme o comando
if (comando == "sample") {
  if (!is.null(flags[["-f"]])) {
    if(!is.null(flags[["-p"]])){
      amostra(file.path(path_data, flags[["-f"]]), flags[["-p"]])
    }else{
      amostra(file.path(path_data, flags[["-f"]]))
    }
  } else {
    stop("Uso: sample -f <arquivo> -p <percentual>")
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
  if (!is.null(flags[["-v"]])) {
    variaveis <- strsplit(flags[["-v"]], ",")[[1]]
    anova(variaveis)
  } else {
    stop("Uso: anova_renda -v <nota1,nota2,...>")
  }
} else if (comando == "summary") {
  sumario()
} else if (comando == "lm") {
  modeloLinear()
} else {
  stop("Comando inválido.")
}