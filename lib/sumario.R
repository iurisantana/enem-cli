sumario <- function() {
  tryCatch(
    {
      if (!file.exists(path_temp)) stop("Arquivo de amostra não encontrado.")
      AMOSTRA <- readRDS(path_temp)
      print(summary(AMOSTRA))
    },
    error = function(e) {
      message("Erro ao gerar resumo: ", e$message)
    }
  )
}
