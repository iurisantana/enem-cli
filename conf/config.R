# Caminhos globais
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