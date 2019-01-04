rm(list = ls())#elimina todos los objetos
setwd("workspace")
group23 = read.table("grupo23_datos.txt",
                     header = TRUE,
                     sep = ";",
                     dec = ".")
save(group23, file = "group23.RData")
load("group23.RData")
#apartado 2
dim(group23)
str(group23)
summary(group23)
names(group23)
#apartado 3 descripcion grafica de cadas variables
pie(table(group23$Gender), labels = levels(group23$Gender))
table(group23$Ageyears, row.names = "edad")
barplot(table(group23$Ageyears))
var(group23$Height_cm)
sd(group23$Height_cm)
hist(group23$Height_cm, col = rgb(0, 1, 1, 1 / 4))
var(group23$Armspan_cm)
sd(group23$Armspan_cm)
hist(group23$Armspan_cm, col = rgb(0, 2 / 4, 1, 1 / 4))
#apartado 4.1 relacion entre generos y alturas
group23.Female = group23[group23$Gender == "Female", ]
group23.Male = group23[group23$Gender == "Male", ]
summary(group23.Female$Height_cm)
summary(group23.Male$Height_cm)
p1 <-
  hist(group23.Male$Height_cm,
       probability = TRUE,
       col = rgb(0, 0, 1, 1 / 4))
lines(density(group23.Male$Height_cm))
p2 <-
  hist(group23.Female$Height_cm,
       probability = TRUE,
       col = rgb(1, 0, 0, 1 / 4))
lines(density(group23.Female$Height_cm))
plot(p1, col = rgb(0, 0, 1, 1 / 4))
plot(p2, col = rgb(1, 0, 0, 1 / 4), add = T)
#apartado 4.2 relacion entre edades y alturas
summary(group23[group23$Ageyears == 11, ]$Height_cm)
summary(group23[group23$Ageyears == 12, ]$Height_cm)
summary(group23[group23$Ageyears == 13, ]$Height_cm)
summary(group23[group23$Ageyears == 14, ]$Height_cm)
summary(group23[group23$Ageyears == 15, ]$Height_cm)
summary(group23[group23$Ageyears == 16, ]$Height_cm)
summary(group23[group23$Ageyears == 17, ]$Height_cm)
summary(group23[group23$Ageyears == 18, ]$Height_cm)
boxplot(
  group23[group23$Ageyears == 11, ]$Height_cm,
  group23[group23$Ageyears == 12, ]$Height_cm,
  group23[group23$Ageyears == 13, ]$Height_cm,
  group23[group23$Ageyears == 14, ]$Height_cm,
  group23[group23$Ageyears == 15, ]$Height_cm,
  group23[group23$Ageyears == 16, ]$Height_cm,
  group23[group23$Ageyears == 17, ]$Height_cm,
  group23[group23$Ageyears == 18, ]$Height_cm,
  names = c(11, 12, 13, 14, 15, 16, 17, 18)
)

#apartado 5.1 relacion entre generos y envergaduras
summary(group23.Female$Armspan_cm)
summary(group23.Male$Armspan_cm)
p3 <-
  hist(
    group23.Male$Armspan_cm,
    freq = TRUE,
    breaks = 10,
    col = rgb(0, 0, 1, 1 / 4)
  )
p4 <-
  hist(
    group23.Female$Armspan_cm,
    freq = TRUE,
    breaks = 10,
    col = rgb(1, 0, 0, 1 / 4)
  )
plot(p3, col = rgb(0, 0, 1, 1 / 4))
plot(p4, col = rgb(1, 0, 0, 1 / 4), add = T)

#apartado 5.2 relacion entre edades y envergadura
boxplot(
  group23[group23$Ageyears == 11, ]$Armspan_cm,
  group23[group23$Ageyears == 12, ]$Armspan_cm,
  group23[group23$Ageyears == 13, ]$Armspan_cm,
  group23[group23$Ageyears == 14, ]$Armspan_cm,
  group23[group23$Ageyears == 15, ]$Armspan_cm,
  group23[group23$Ageyears == 16, ]$Armspan_cm,
  group23[group23$Ageyears == 17, ]$Armspan_cm,
  group23[group23$Ageyears == 18, ]$Armspan_cm,
  names = c(11, 12, 13, 14, 15, 16, 17, 18)
)
#apartado 6.1 relacion bicariante entre alturas y envergaduras
cov(group23$Height_cm, group23$Armspan_cm)#covatianza
cor(group23$Height_cm, group23$Armspan_cm)#coeficiente de correlación
plot(group23$Height_cm, group23$Armspan_cm)
abline(lm(Armspan_cm ~ Height_cm, data = group23))#recta de regresion lineal
#cambia la pendiente de la recta en dos generos
lm(Armspan_cm ~ Height_cm, data = group23.Female)
lm(Armspan_cm ~ Height_cm, data = group23.Male)
