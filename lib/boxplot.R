boxplot <- function(variaveis) {
  tryCatch(
    {
      if (!file.exists(file.path(path_temp, "amostra_enem.rds"))) {
        stop("Arquivo não encontrado em: ", file.path(path_temp, "amostra_enem.rds"))
      }
      
      amostra <- readRDS(file.path(path_temp, "amostra_enem.rds"))
      
      variaveis_numericas <- variaveis[sapply(amostra[, variaveis, drop = FALSE], function(x) is.numeric(as.numeric(x[!is.na(x)])))]
      
      if (length(variaveis_numericas) == 0) {
        stop("Nenhuma variável numérica válida encontrada.")
      }
      
      boxplot_file <- file.path(path_work, "boxplot.pdf")
      pdf(boxplot_file, width = 8, height = 6)
      
      for (var in variaveis_numericas) {
        dados <- as.numeric(amostra[[var]])
        dados <- dados[!is.na(dados)]
        
        if (length(dados) == 0) {
          warning(paste("Variável", var, "sem dados numéricos válidos."))
          next
        }
        
        boxplot_args <- list(
          x = dados,
          main = paste("Boxplot de", var),
          col = "lightgreen",
          border = "darkgreen"
        )
        
        do.call(graphics::boxplot, boxplot_args)
        
        abline(h = mean(dados), col = "red", lty = 2, lwd = 2)
        
        legend("topright",
               legend = c(paste("Média =", round(mean(dados), 2))),
               col = "red",
               lty = 2,
               lwd = 2,
               bg = "white")
      }
      
      dev.off()
      message("Boxplots salvos em: ", boxplot_file)
    },
    error = function(e) {
      message("Erro: ", e$message)
      return(NULL)
    }
  )
}