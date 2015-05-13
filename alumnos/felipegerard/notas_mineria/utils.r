library(stringr)

loadData <- function(name, full_path, ...) {

  if (exists(name))
    stop("Error: No se indica el nombre del data source (ds), el argumento 'name' está vacío.")

  if (exists(full_path))
    stop("Error: No se indica la ruta para el archivo que contiene el data source, el argumento 'full_path' está vacío")

  ds <- NULL

  name <- paste(name, ".rds", sep="")

  rds_path <- paste("../rds","/", name, sep="")

  if(file.exists(rds_path)) {
    cat("Buscando el RDS en ", rds_path, "\n")
    cat(system.time(ds <- readRDS(file = rds_path)), "\n")
  } else {
    cat("Buscando el archivo en ", full_path, "\n")
    cat(system.time(ds <- read.table(full_path, ...)), "\n")
    cat("Guardando el RDS en ", rds_path, "\n")
    cat(system.time(saveRDS(object = ds, file = rds_path)), "\n")
  }

  ds
}

normalizarNombres <- function(nombres) {

  # Convertimos a minúsculas
  nombres <- tolower(nombres)

  # Eliminamos '_' por '.'
  nombres <- str_replace_all(string = nombres, pattern = '_', replacement = '.')

}


pruebaChiCuadrada <- function(var1, var2) {
  tabla <- table(var1, var2)
  
  plot(tabla, main=var1, las=1)
  
  print(var1)
  
  print(chisq.test(tabla))
}


## Predicciones


predecirVariableCategorica <- function(outCol, varCol, appCol, pos) {
  pPos <- sum(outCol == pos) / length(outCol)
  naTab <- table(as.factor(outCol[is.na(varCol)]))
  pPosWna <- (naTab/sum(naTab))[pos]
  vTab <- table(as.factor(outCol), varCol)
  pPosWv <- (vTab[pos,]+1.0e-3*pPos)/(colSums(vTab)+1.0e-3)
  pred <- pPosWv[appCol]
  pred[is.na(appCol)] <- pPosWna
  pred[is.na(pred)] <- pPos
  pred
}


## Evaluación

library(ROCR)

calcAUC <- function(predcol, outcol) {
  perf <- performance(prediction(predcol, outcol == pos), 'auc')
  as.numeric(perf@y.values)
}
