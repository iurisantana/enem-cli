anova <- function(variaveis, comparar) {
  tryCatch({
    if (!file.exists(path_temp)) stop("Arquivo não encontrado em: ", path_temp)
    
    amostra <- readRDS(path_temp)
    
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
      
      boxplot_args <- list(
        formula = NOTA ~ CLASSE,
        data = dados_plot,
        main = paste("Notas em", var, "\n(n =", nrow(dados_plot), ")"),
        xlab = comparar,
        ylab = "Nota",
        col = "lightblue",
        las = 2,
        ylim = range(dados_plot$NOTA, na.rm = TRUE)
      )
      
      do.call(graphics::boxplot, boxplot_args)
      
      if (length(unique(dados_plot$CLASSE)) > 1) {
        anova_result <- aov(NOTA ~ CLASSE, data = dados_plot)
        p_valor <- summary(anova_result)[[1]]$"Pr(>F)"[1]
        legend("topright", 
               legend = paste("p =", format.pval(p_valor, digits = 3)),
               bty = "n")
      }
    }
    
    dev.off()
    message("Análise ANOVA salva em: ", file.path(path_work, "anova.pdf"))
    
  }, error = function(e) {
    message("Erro: ", e$message)
    return(NULL)
  })
}
