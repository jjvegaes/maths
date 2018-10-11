#primera parte
  ###1
      ##a
        #x=longitud de tornillos
        #x~N(20,sqrt(0.25))
        #pd = probabilidad de ser defectuoso
        #pd=P(x<19 â© x>21) = P(x<19)+p(x>21) = p(x<19)*2
          pd=pnorm(19,20,sqrt(0.25))*2
      ##b
        #x=numero de tornillos defectuosos
        #x~Bin(15,pd)
        #P(x<=2)
          pbinom(2,size=15,prob=pd)#pd obtiene en el apartado a
  ###2
      #x = numero de articulo selecionado hasta encontrar primer defectuoso
      #x~Ge(0.1)
        #P(x=5) = 0.1*(1-0.1)^4=0.06561
          dgeom(4,0.1)
  ###3
      #x = volumen de ventas
      #x~U(38,120)
        #P(x>100)
          punif(100,38,120,lower.tail = F)
  ###4
      #x=vida de circuitos
      #x~Exp(1/8)
      ##a
        #P(3<x<12)=P(x<12)-P(x<3)
          pexp(12,1/8) - pexp(3,1/8)
      ##b
        #Puesto que la distribuciÃ³n exponencial no tiene memoria
        #P(x>25|x>10)=P(x>15)
          pexp(15,1/8,lower.tail = F)
  ###5
      #x=numero de pedidos
      #x~Bin(5,0.4)
      ##a
        #P(x=4)
          dbinom(4,5,0.4)
      ##b
        #P(x>=2)=P(x>1)
          pbinom(1,5,0.4,lower.tail = F)
      ##c
        #P(1<=x<=3)=P(x=1)+P(x=2)+P(x=3)=P(x<=30)-P(x<1)
          pbinom(3,5,0.4)-pbinom(0,5,0.4)
  ###6
      #x=numero de accidentes
      #x~Po(3)
      ##a
        #P(x=0)
          dpois(0,3)
      ##b
        #P(x<5)=P(x<=4)
          ppois(4,3)
      ##c
        #P(x>3)
          ppois(3,3,lower.tail = F)
      ##d
        #P(X=3)
          dpois(3,3)
  ###7
      #x=duracion de laser
      #x~N(7000,600)
      ##a
        #P(x<5000)
          pnorm(5000,7000,600)
      ##b
        #P(x<Z)=0.95
          qnorm(0.05,7000,600)
      ##c
        #x=numero de laseres que sigan funcionando despues de 7000h
        #probabilidad de siga funcionado cada una es 0.5
        #x~Bin(3,0.5)
          dbinom(3,3,0.5)
  ###8
      #x=tiempo que gasta en una sesion
      #x~exp(1/36)
      ##a
        #P(x<30)
          pexp(30,1/36)
      ##b
        #Puesto que la distribuciÃ³n exponencial no tiene memoria
        #P(x>1.5*60|x>0.5*30)=P(X>60)
          pexp(60,1/36,lower.tail = F)
      ##c
        #P(x<R)=0.9
          qexp(0.9,1/36)
  ###9
      #x=numero de empresas con suspension de pagos
      ##a
        #X~Po(6.8/4)
        #P(x=0)
          dpois(0,6.8/4)
      ##b
        #x~Po(6.8)
        #P(x>=2)=P(x>1)
          ppois(1,6.8,lower.tail = F)

#segunda parte
  ###1
          setwd('C:/Users/vitam/OneDrive/Documents/universidad/Estadistica/R/practica2')
          grupo_data <- read.table('grupo23_datos.txt',header = TRUE, sep = ';')
          Height <-split(grupo_data$Height_cm,grupo_data$Gender)
          attach(Height)
  ###2
    #parece que distribuye normalmente
    #Los puntos parecen caer alrededor de una línea recta
          hist(Female)
          qqnorm(Female)
          qqline(Female)
          hist(Male)
          qqnorm(Male)
          qqline(Male)   
  ###3
    #P(left<X<right)=confianza
    #left=media_muestral-t*s/sqrt(n), right=media_muestral+t*s/sqrt(n)
    #t~t(1-(1-confianza)/2,n-1)
    confianza=0.95
      #chica
      s_female=sd(Female)
      error_f <- qt(1-(1-confianza)/2,length(Female)-1)*s_female/sqrt(length(Female))
      interv_f<-c(mean(Female)-error_f,mean(Female)+error_f)
      #chico
      s_male=sd(Male)
      error_m <- qt(1-(1-confianza)/2,length(Male)-1)*s_male/sqrt(length(Male))
      interv_m<-c(mean(Male)-error_m,mean(Male)+error_m)
  ###4
      #h0:mu<=170
      #h1:mu>170
      #No hay evidencia para rechazar h0, por que p-valor es mayor que 0.1
      t.test(Male,alternative = "greater", mu=170, conf.level = confianza)
  ###5
      #h0:mu<=160
      #h1:mu>160
      #No hay evidencia suficiente para rechazar h0
      t.test(Female,alternative = "greater", mu=160, conf.level = confianza)

  
        