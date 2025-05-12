modeloLinear <- function() {
  tryCatch(
    {
      if (!file.exists(path_temp)) stop("Arquivo de amostra não encontrado.")
      AMOSTRA <- readRDS(path_temp)
      AMOSTRA$MEDIA_NOTAS <- apply(
        AMOSTRA[, c("NU_NOTA_CN", "NU_NOTA_CH", "NU_NOTA_LC", "NU_NOTA_MT", "NU_NOTA_REDACAO")],
        1,
        median
      )      
      modelo <- lm(MEDIA_NOTAS ~ Q001 + Q002 + Q006 + TP_ESCOLA, data = AMOSTRA)
      print(summary(modelo))
    },
    error = function(e) {
      message("Erro ao gerar modelo: ", e$message)
    }
  )
}
