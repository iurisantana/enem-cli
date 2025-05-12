# Caminhos globais
dir_base <- dirname(dirname(normalizePath(sys.frame(1)$ofile)))
path_data <- file.path(dir_base, "data")
path_temp <- file.path(dir_base, "temp", "amostra_enem.rds")
path_work <- file.path(dir_base, "work")
