amostra <- function(path, percent = 1, seed = NULL) {
  tryCatch({
    message("Lendo dados de: ", path)
    library(data.table)
    
    ENEM <- fread(
      input = path,
      integer64 = "character",
      na.strings = "",
      showProgress = TRUE
    )[TP_PRESENCA_CN == 1 & TP_PRESENCA_CH == 1 & TP_PRESENCA_LC == 1 & TP_PRESENCA_MT == 1]
    
    if (nrow(ENEM) == 0) stop("Nenhum dado presente encontrado.")
    
    total <- nrow(ENEM)
    percent <- as.numeric(percent)
    size <- max(1, min(total, round(percent / 100 * total)))
    
    if (is.null(seed)) {
      seed <- as.integer(Sys.time())
    }
    
    message("Usando seed: ", seed)
    set.seed(as.integer(seed))
    
    AMOSTRA <- ENEM[sample(total, size = size)]
    
    path_out <- file.path(path_temp, "amostra_enem.rds")
    saveRDS(AMOSTRA, file = path_out)
    message("Amostra salva em '", path_out, "'")
  }, error = function(e) {
    message("Erro ao carregar os dados: ", e$message)
  })
}
