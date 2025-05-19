# --- Ejercicio 1: Longitud de clavos ---

# Crear los datos
longitudes <- data.frame(
  valor = c(2.05, 2.03, 2.02, 1.98, 1.99, 2.00, 2.07, 2.05, 2.04),
  proceso = factor(rep(c("A","B","C"), each = 3))
)

# Ajustar el modelo ANOVA
anova1 <- aov(valor ~ proceso, data = longitudes)

# Resumen de ANOVA
summary(anova1)

# Diagnósticos básicos de supuestos
par(mfrow = c(1,2))
plot(anova1, which = c(1,2))  # Residuos vs valores ajustados + QQ‐plot

# Post-hoc de Tukey
tukey1 <- TukeyHSD(anova1, "proceso", conf.level = 0.95)
tukey1
plot(tukey1)

# --- Ejercicio 2: Densidad vs. Temperatura ---

# Crear los datos
densidad <- data.frame(
  valor = c(4.5, 7.8, 6.7,
            3.8, 5.6, 9.1,
            7.6, 4.6, 7.6,
            3.5, 3.5, 4.8),
  temperatura = factor(rep(1:4, each = 3))
)

# Ajustar el modelo ANOVA
anova2 <- aov(valor ~ temperatura, data = densidad)

# Resumen de ANOVA
summary(anova2)

# Diagnósticos básicos de supuestos
par(mfrow = c(1,2))
plot(anova2, which = c(1,2))
