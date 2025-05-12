# ejercicio 1
# if (!require(writexl)) {
#   install.packages("writexl")
#   library(writexl)
# }

# datos <- data.frame(
#   logaritmo = c("comercial", "comercial", "comercial", "al vacio", "al vacio", "al vacio", "mezcla", "mezcla", "mezcla", "co2", "co2", "co2")
#   categoria = c(7.66, 6.98, 7.8, 5.26, 5.44, 5.8, 7.41, 7.33, 7.04, 3.51, 2.91, 3.66)
# )
# write_xlsx(datos, "./bacteria.xlsx")


if (!require(readxl)) {
 install.packages("readxl")
 library(readxl)
}

data <- read_xlsx("./scripts/data/bacteria.xlsx")
comercial <- subset(data, categoria == "comercial")
al_vacio <- subset(data, categoria == "al vacio")
mezcla <- subset(data, categoria == "mezcla")
co2 <- subset(data, categoria == "co2")

# shapiro test
shapiro.test(comercial$logaritmo)
shapiro.test(al_vacio$logaritmo)
shapiro.test(mezcla$logaritmo)
shapiro.test(co2$logaritmo)

# anova test
aov(logaritmo ~ categoria, data)
