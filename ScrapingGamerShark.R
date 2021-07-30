library("rvest")

#####################Variable del sitio web####################################
gamershark <- read_html("https://www.gameshark.cl/sitio/21-audifonos?page=1")
##################Asignacion de la data frame########################
datosgamershark <- data.frame()

############Realizar un for para ver y abrir los distintas pagina############## 
##########################  del sitio web  ####################################
for (NumeroPagina in 1:4){
  nombreaudifono <- NA
  precioaudifono <- NA
  linkaudifono <- NA
  
  print("================================================================================================")
  print(paste("Navegacion por el numero de pagina:",NumeroPagina))
  urlgamershark <- paste("https://www.gameshark.cl/sitio/21-audifonos?page=",NumeroPagina,"",sep= "")
  print(urlgamershark)
  gamershark <- read_html(urlgamershark)
  print("================================================================================================")
  #print(gamershark)
  
  #################nombre de los audifonos#####################################

  nombgamershark <- html_nodes(gamershark,css =".product-title")
  nombreaudifono <- html_text(nombgamershark)
  print(nombreaudifono)

  ############### Precio Actual de los audifinos ###############################               
  preciogamershark <- html_nodes(gamershark,css =".price")
  precioaudifono <- html_text(preciogamershark)
  if(!is.na(precioaudifono)){
    precioaudifono <- gsub("[$]","",precioaudifono)
    precioaudifono <-gsub(" ","",precioaudifono)
    precioaudifono <- gsub("[.]","",precioaudifono)}
  print("===================================================================================================================")
  print(precioaudifono)

  ################## Links de los productos ###################################
  Cajaarticulocolum <- html_nodes(gamershark,css =".thumbnail-container")
  caja <- html_nodes(Cajaarticulocolum,css =".product-description")
  a <- html_nodes(caja,css ="a")
  print(html_attr(a,"href"))
  linkaudifono <- html_attr(a,"href")
  
  ########################## DATA FRAME ########################################
  datatmpgamershark <- data.frame(Nombre =nombreaudifono, Precio =precioaudifono, Link =linkaudifono)
  datosgamershark <- rbind(datatmpgamershark,datosgamershark)
}

 write.csv2(datosgamershark,"gamershark.csv")
 
 read.csv2(datosgamershark,"gamershark.csv")


