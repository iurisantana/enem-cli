anova <- function(variaveis) {
  tryCatch({
    if (!file.exists(path_temp)) stop("Arquivo não encontrado em: ", path_temp)
    
    amostra <- readRDS(path_temp)
    
    variaveis_validas <- intersect(variaveis, names(amostra))
    if (length(variaveis_validas) == 0) {
      stop("Nenhuma variável válida encontrada no dataset.")
    }
    
    if (!"Q006" %in% names(amostra)) {
      stop("Variável de renda (Q006) não encontrada.")
    }
    
    renda_map <- c(
      "A" = 1, "B" = 2, "C" = 3, "D" = 4, "E" = 5,
      "F" = 6, "G" = 7, "H" = 8, "I" = 9, "J" = 10,
      "K" = 11, "L" = 12, "M" = 13, "N" = 14, "O" = 15,
      "P" = 16, "Q" = 17
    )
    
    amostra$RENDA <- renda_map[amostra$Q006]
    amostra <- amostra[!is.na(amostra$RENDA), ]
    
    if (nrow(amostra) == 0) {
      stop("Nenhum dado válido após conversão da renda. Verifique os valores de Q006.")
    }
    
    amostra$FAIXA_RENDA <- cut(amostra$RENDA,
                               breaks = c(0, 5, 10, Inf),
                               labels = c("Baixa (A-E)", "Média (F-J)", "Alta (K-Q)"),
                               include.lowest = TRUE)
    
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
        formula = NOTA ~ FAIXA_RENDA,
        data = dados_plot,
        main = paste("Notas em", var, "\n(n =", nrow(dados_plot), ")"),
        xlab = "Faixa de Renda",
        ylab = "Nota",
        col = c("#FF9AA2", "#FFB7B2", "#FFDAC1"),
        ylim = range(dados_plot$NOTA, na.rm = TRUE)
      )
      
      do.call(graphics::boxplot, boxplot_args)
      
      if (length(unique(dados_plot$FAIXA_RENDA)) > 1) {
        anova_result <- aov(NOTA ~ FAIXA_RENDA, data = dados_plot)
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
