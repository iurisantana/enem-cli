pacotes_necessarios <- c("data.table", "ggplot2")

instalar_pacotes <- function(pacotes) {
  pacotes_faltando <- pacotes[!(pacotes %in% installed.packages()[, "Package"])]
  if (length(pacotes_faltando) > 0) {
    message("Instalando pacotes: ", paste(pacotes_faltando, collapse = ", "))
    install.packages(pacotes_faltando, repos = "https://cloud.r-project.org")
  }
}

instalar_pacotes(pacotes_necessarios)

dir_base <- dirname(dirname(normalizePath(sys.frame(1)$ofile)))
path_data <- file.path(dir_base, "data")
path_temp <- file.path(dir_base, "temp")
path_work <- file.path(dir_base, "work")

source(file.path(dir_base, "lib", "comandos.R"))
source(file.path(dir_base, "lib", "desvioPadrao.R"))
source(file.path(dir_base, "lib", "boxplot.R"))
source(file.path(dir_base, "lib", "amostra.R"))
source(file.path(dir_base, "lib", "sumario.R"))
source(file.path(dir_base, "lib", "modelo.R"))
source(file.path(dir_base, "lib", "anova.R"))