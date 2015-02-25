library(rvest)
library(plyr)
library(parallel)

base_url <- "http://data.gdeltproject.org/events/"

gdelt_data_index <- html(paste0(base_url, "index.html"))

# extraemos los links a los archivos
daily_urls <- gdelt_data_index %>%
    html_nodes("li~ li+ li a") %>%
    html_text()

down_urls <- paste0(base_url, daily_urls)

# funcion para descargar
download.maybe <- function(url, refetch=FALSE, path=".") {
    dest <- file.path(path, basename(url))
    if (refetch || !file.exists(dest))
        download.file(url, dest, quiet=T)
    dest
}

# Creamos el directorio para guardar los datos
path <- "../datos/gdelt"
dir.create(path, showWarnings=FALSE)
files <- mclapply(down_urls, download.maybe, path=path)
