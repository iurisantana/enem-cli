anova <- function(variaveis, comparar) {
  tryCatch({
    if (!file.exists(file.path(path_temp, "amostra_enem.rds"))) stop("Arquivo não encontrado em: ", file.path(path_temp, "amostra_enem.rds"))
    
    amostra <- readRDS(file.path(path_temp, "amostra_enem.rds"))
    
    variaveis_validas <- intersect(variaveis, names(amostra))
    if (length(variaveis_validas) == 0) {
      stop("Nenhuma variável válida encontrada no dataset.")
    }
    
    if (!comparar %in% names(amostra)) {
      stop("Variável de classe (categórica) não encontrada: ", comparar)
    }
    
    amostra <- amostra[!is.na(amostra[[comparar]]), ]
    if (nrow(amostra) == 0) {
      stop("Nenhum dado válido após filtrar a variável de classe: ", comparar)
    }
    
    amostra$CLASSE <- factor(amostra[[comparar]], levels = sort(unique(amostra[[comparar]])))
    
    pdf(file.path(path_work, "anova.pdf"), width = 10, height = 6)
    
    for (var in variaveis_validas) {
      dados_plot <- amostra
      dados_plot$NOTA <- suppressWarnings(as.numeric(dados_plot[[var]]))
      dados_plot <- dados_plot[!is.na(dados_plot$NOTA), ]
      
      if (nrow(dados_plot) == 0) {
        warning(paste("Variável", var, "não contém valores numéricos válidos."))
        next
      }
      
      media_geral <- mean(dados_plot$NOTA, na.rm = TRUE)
      
      medias_por_grupo <- tapply(dados_plot$NOTA, dados_plot$CLASSE, mean, na.rm = TRUE)
      
      cores <- ifelse(medias_por_grupo > media_geral, "lightblue", "aliceblue")
      
      boxplot_args <- list(
        formula = NOTA ~ CLASSE,
        data = dados_plot,
        main = paste("Notas em", var, "\n(Total de análises =", nrow(dados_plot), ")"),
        xlab = comparar,
        ylab = "Nota",
        col = cores[as.character(levels(dados_plot$CLASSE))],
        las = 2,
        ylim = range(dados_plot$NOTA, na.rm = TRUE)
      )
      
      do.call(graphics::boxplot, boxplot_args)
      
      abline(h = media_geral, col = "red", lty = 2, lwd = 2)
      
      legend("topright", 
             legend = c("Acima da média", "Abaixo da média", "Média geral"),
             fill = c("lightblue", "aliceblue", NA),
             border = c("black", "black", NA),
             lty = c(NA, NA, 2),
             col = c(NA, NA, "red"),
             lwd = c(NA, NA, 2),
             bty = "o",
             bg = "gray95")
    }
    
    dev.off()
    message("Análise ANOVA com destaque por grupo salva em: ", file.path(path_work, "anova.pdf"))
    
  }, error = function(e) {
    message("Erro: ", e$message)
    return(NULL)
  })
}
