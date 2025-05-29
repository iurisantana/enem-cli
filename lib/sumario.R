sumario <- function() {
  tryCatch(
    {
      if (!file.exists(file.path(path_temp, "amostra_enem.rds"))) stop("Arquivo de amostra não encontrado.")
      AMOSTRA <- readRDS(file.path(path_temp, "amostra_enem.rds"))
      print(summary(AMOSTRA))
    },
    error = function(e) {
      message("Erro ao gerar resumo: ", e$message)
    }
  )
}
