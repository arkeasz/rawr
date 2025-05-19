install.packages("car")

# Datos
proceso <- c(rep("A", 3), rep("B", 3), rep("C", 3))
longitud <- c(2.05, 2.03, 2.02, 1.98, 1.99, 2.00, 2.07, 2.05, 2.04)
datos <- data.frame(proceso, longitud)

# 1. Verificar normalidad (Shapiro-Wilk)
shapiro_A <- shapiro.test(datos$longitud[datos$proceso == "A"])
shapiro_B <- shapiro.test(datos$longitud[datos$proceso == "B"])
shapiro_C <- shapiro.test(datos$longitud[datos$proceso == "C"])

# 2. Verificar homogeneidad de varianzas (Levene)
library(car)
levene_test <- leveneTest(longitud ~ proceso, data = datos)

# 3. ANOVA (si se cumplen supuestos)
anova_result <- aov(longitud ~ proceso, data = datos)
summary(anova_result)

# 4. Prueba post-hoc (Tukey HSD)
if (levene_test$`Pr(>F)`[1] > 0.05 &&
    shapiro_A$p.value > 0.05 &&
    shapiro_B$p.value > 0.05 &&
    shapiro_C$p.value > 0.05) {
  tukey_result <- TukeyHSD(anova_result)
  print(tukey_result)
} else {
  # Kruskal-Wallis (si no se cumplen supuestos)
  kruskal_result <- kruskal.test(longitud ~ proceso, data = datos)
  print(kruskal_result)
}

#########################################################
