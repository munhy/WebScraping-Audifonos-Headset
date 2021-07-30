library("rvest")
###############################################################################
############################# AUDIFONOS #######################################
###############################################################################
#####################Variable del sitio web####################################
goldengamers <- read_html("https://goldengamers.cl/collections/audifonos?page=1&sort_by=price-ascending")

##################Asignacion de la data frame########################
datosgoldengamers <- data.frame()

############Realizar un for para ver y abrir los distintas pagina############## 
##########################  del sitio web  ####################################
for (NumeroPagina in 1:3){
  nombreaudifono <- NA
  precioaudifono <- NA
  linkaudifono <- NA
  
  print("================================================================================================")
  print(paste("Navegacion por el numero de pagina:",NumeroPagina))
  urlgoldengamers <- paste("https://goldengamers.cl/collections/audifonos?page=",NumeroPagina,"&sort_by=price-ascending",sep= "")
  print(urlgoldengamers)
  goldengamers <- read_html(urlgoldengamers)
  print("================================================================================================")
  #print(goldengamers)
  
  #################nombre de los audifonos#####################################
  nombgoldengamers <- html_nodes(goldengamers,css =".product-thumb-caption-title")
  nombreaudifono <- html_text(nombgoldengamers)
  print(nombreaudifono)
  
  ############### Precio Actual de los audifinos ###############################               
  preciogoldengamers <- html_nodes(goldengamers,css =".product-thumb-caption-price-current")
  precioaudifono <- html_text(preciogoldengamers)
  if(!is.na(precioaudifono)){
   precioaudifono <- gsub("[$]","",precioaudifono)
   precioaudifono <-gsub("[CLP]","",precioaudifono)
   precioaudifono <- gsub("[.]","",precioaudifono)
   precioaudifono <- as.numeric(precioaudifono)}
   print("===================================================================================================================")
   print(precioaudifono)
   
  ################## Links de los productos ###################################
  Cajaarticulocolum <- html_nodes(goldengamers,css =".col-md-4")
   caja <- html_nodes(Cajaarticulocolum,css =".product-thumb-img-wrap")
   a <- html_nodes(caja,css ="a")
   print(html_attr(a,"href"))
   linkaudifono <- html_attr(a,"href")

  ########################## DATA FRAME ########################################
 datatmpgoldengamers <- data.frame(Nombre =nombreaudifono, Precio =precioaudifono, Link =linkaudifono)
 datosgoldengamers <- rbind(datatmpgoldengamers,datosgoldengamers)
}

############# Para poder pasar los datos a Excel ###############################
write.csv2(datosgoldengamers,"GoldenGamers.csv")

read.csv2(datosgoldengamers,"GoldenGamers.csv")
  








