desvio_padrao <- function(variaveis) {
  tryCatch(
    {
      if (!file.exists(file.path(path_temp, "amostra_enem.rds"))) {
        stop("Arquivo não encontrado em: ", file.path(path_temp, "amostra_enem.rds"))
      }
      
      amostra <- readRDS(file.path(path_temp, "amostra_enem.rds"))
      
      variaveis_numericas <- variaveis[sapply(amostra[, variaveis], is.numeric)]
      
      if (length(variaveis_numericas) == 0) {
        stop("Nenhuma variável numérica encontrada.")
      }
      
      SD <- file.path(path_work, "sd.pdf")
      pdf(SD, width = 8, height = 6)
      
      for (var in variaveis_numericas) {
        dados <- amostra[[var]]
        media <- mean(dados, na.rm = TRUE)
        sd_val <- sd(dados, na.rm = TRUE)
        
        hist(dados, 
             main = paste("Distribuição de", var),
             xlab = var,
             col = "lightblue",
             border = "white",
             freq = FALSE)
        
        abline(v = media, col = "red", lwd = 2)
        abline(v = media + sd_val, col = "blue", lty = 2, lwd = 2)
        abline(v = media - sd_val, col = "blue", lty = 2, lwd = 2)
        
        legend(
          "topright", 
          legend = c(paste("Média =", round(media, 2)), paste("SD =", round(sd_val, 2))),
          col = c("red", "blue"),
          lty = c(1, 2),
          lwd = 2,
          bg = "white"
         )
      }
      
      dev.off()
      message("Devio padrão salvos em: ", SD)
    },
    error = function(e) {
      message("Erro: ", e$message)
      return(NULL)
    }
  )
}