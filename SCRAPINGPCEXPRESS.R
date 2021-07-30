library("rvest")
################################variable sitio web################################
pcexpressaudifonos <- read_html("https://tienda.pc-express.cl/index.php?route=product/category&path=414_416&page=1")

################################asignacion de la data frame################################
datospcexpress <- data.frame()
for (nropagina in 1:1){
  nombreproducto <- NA
  precioproducto <- NA
  linkproduto    <- NA
  ################################navegacion por los distintos nro de pagina################################
  print("=========================================================================================================")
  print(paste("navegacion por el numero de pagina:",nropagina))
  urlpcexppress <- paste("https://tienda.pc-express.cl/index.php?route=product/category&path=414_416&page=",nropagina,sep = "")
  print(urlpcexppress)
  pcexpressaudifonos <- read_html(urlpcexppress)
  print("=========================================================================================================")
  divdeproductos <- html_nodes(pcexpressaudifonos, css = ".col-sm-8")
  print("=========================================================================================================")
  ################################asignacion variablre nombre################################
  nombreaudifonospcexpress <- html_nodes(divdeproductos, css = ".product-list__name")
  nombreproducto <- html_text(nombreaudifonospcexpress)
  ################################limpieza de variable nombre################################
  if(!is.na(nombreproducto)){
    nombreproducto <- gsub("\n","",nombreproducto)
  }
  print(nombreproducto)
  print("=========================================================================================================")
  ################################asignacion variable precio################################
  preciospcexpress <- html_nodes(divdeproductos, css = ".product-list__price")
  precioproducto <- html_text(preciospcexpress)
  ################################limpieza de variable precio################################
  if(!is.na(precioproducto)){
    precioproducto <- gsub("\n","",precioproducto)
    precioproducto <- gsub("\t","",precioproducto)
    precioproducto <- gsub("[$]","",precioproducto)
    precioproducto <- gsub("[.]","",precioproducto)
    precioproducto <- as.numeric(precioproducto)
    print(precioproducto)
  }else{
    print("no hay precio")
  }
  print("=========================================================================================================")
  ################################extraccion de links################################
  cajaarticulos <- html_nodes(pcexpressaudifonos, css = ".product-list__item")
  cajaimagenes <- html_nodes(cajaarticulos, css = ".product-list__image")
  a <- html_nodes(cajaimagenes, css = "a" )
  print(html_attr(a,"href"))
  linkproduto  <- html_attr(a,"href")
  ################################
  datatmp <- data.frame (Nombre = nombreproducto, Precio = precioproducto, Link = linkproduto)
  datospcexpress <- rbind(datatmp,datospcexpress)
}

write.csv(datospcexpress,"micsv.csv")
write.csv2(datospcexpress,"micsv2.csv")

read.csv(datospcexpress,"micsv.csv")
read.csv2(datospcexpress,"micsv2.csv")