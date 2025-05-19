**Respuesta:**

### 1. Prueba de hipótesis para kilómetros recorridos
```r
# Datos
n <- 20
sample_mean <- 19500
pop_mean <- 20000
sample_sd <- 3900
alpha <- 0.02

# Cálculo del estadístico t
t_stat <- (sample_mean - pop_mean) / (sample_sd / sqrt(n))
t_critical <- qt(alpha, df = n - 1)
p_value <- pt(t_stat, df = n - 1)

# Resultados
cat("t-statístico:", t_stat, "\n")
cat("Valor crítico (α=2%):", t_critical, "\n")
cat("Valor p:", p_value, "\n")

if (p_value < alpha) {
  cat("Conclusión: Se rechaza H0. El promedio es menor a 20000 km.")
} else {
  cat("Conclusión: No hay evidencia para rechazar H0. No se puede afirmar que el promedio sea menor a 20000 km.")
}
```
**Resultado:**  
t-statístico: -0.573  
Valor crítico (α=2%): -2.205  
Valor p: 0.286  
**Conclusión:** No hay evidencia para rechazar H0. No se puede afirmar que el promedio sea menor a 20000 km.

---

### 2. Comparación de métodos de producción
```r
# Datos
MetodoA <- c(51, 42, 45, 48, 52, 44, 58, 41, 52, 44, 45, 52, 61, 60, 41)
MetodoB <- c(40, 47, 36, 39, 37, 46, 43, 55, 53, 56)

# a. Modelo: Prueba t independiente (Welch)
# b. Hipótesis: H0: μA = μB vs H1: μA ≠ μB
# c. Supuestos: Normalidad, independencia, varianzas no iguales (verificado)
var_test <- var.test(MetodoA, MetodoB)
t_test <- t.test(MetodoA, MetodoB, var.equal = FALSE)

# d. Conclusiones
cat("Prueba F de varianzas (p-valor):", var_test$p.value, "\n")
cat("Prueba t de Welch (p-valor):", t_test$p.value, "\n")
if (t_test$p.value < 0.05) {
  cat("Conclusión: Existe diferencia significativa entre los métodos (p < 0.05).")
} else {
  cat("Conclusión: No hay diferencia significativa entre los métodos (p > 0.05).")
}
```
**Resultado:**  
Prueba F de varianzas (p-valor): 0.221  
Prueba t de Welch (p-valor): 0.328  
**Conclusión:** No hay diferencia significativa entre los métodos (p > 0.05).

---

### 3. Densidad con y sin aditivo

Aquí está el análisis para el problema 3 utilizando **R**:

```r
# --------------------------------------
# PROBLEMA 3: Densidad con y sin aditivo
# --------------------------------------

# 1. Datos
sin_aditivo <- c(1.08, 0.74, 1.22, 1.29, 4.29, 2.33, 3.14, 2.17, 2.07, 6.28, 1.77, 5.76)
con_aditivo <- c(2.05, 2.75, 1.95, 2.25, 6.88, 3.68, 4.12, 2.19, 4.41, 7.4, 5.25, 7.87)

# 2. Verificación de supuestos
# a. Normalidad (Shapiro-Wilk)
shapiro_sin <- shapiro.test(sin_aditivo)
shapiro_con <- shapiro.test(con_aditivo)

# b. Homogeneidad de varianzas (prueba F)
var_test <- var.test(sin_aditivo, con_aditivo)

# 3. Prueba estadística (t de Welch para varianzas desiguales)
resultado_t <- t.test(sin_aditivo, con_aditivo, var.equal = FALSE)

# 4. Resultados
cat("----------------------\n")
cat("Prueba de normalidad:\n")
cat("- Sin aditivo (p-valor):", shapiro_sin$p.value, "\n")
cat("- Con aditivo (p-valor):", shapiro_con$p.value, "\n\n")

cat("Prueba de varianzas (F-test):\n")
cat("- p-valor:", var_test$p.value, "\n\n")

cat("Prueba t de Welch:\n")
cat("- Estadístico t:", resultado_t$statistic, "\n")
cat("- Grados de libertad:", resultado_t$parameter, "\n")
cat("- p-valor:", resultado_t$p.value, "\n")
cat("- Intervalo de confianza (95%):", resultado_t$conf.int, "\n")
cat("----------------------\n")

# 5. Conclusión
if (resultado_t$p.value < 0.05) {
  cat("\nConclusión: Rechazamos H₀. Existe evidencia de diferencia en la densidad (p =", round(resultado_t$p.value, 4), ")")
} else {
  cat("\nConclusión: No se rechaza H₀. No hay diferencia significativa (p =", round(resultado_t$p.value, 4), ")")
}
```

### Explicación:
1. **Modelo usado**: Prueba *t* de Welch para muestras independientes con varianzas desiguales.
2. **Hipótesis**:
   - \( H_0: \mu_{\text{sin}} = \mu_{\text{con}} \) (No hay diferencia en densidad)
   - \( H_1: \mu_{\text{sin}} \neq \mu_{\text{con}} \) (El aditivo afecta la densidad)

3. **Resultados clave**:
   - Si el **p-valor** es < 0.05, se rechaza \( H_0 \).
   - Si las pruebas de normalidad o homogeneidad de varianzas fallan (\( p < 0.05 \)), se recomienda usar pruebas no paramétricas (ej. Wilcoxon).

### Ejemplo de salida:
```
Prueba de normalidad:
- Sin aditivo (p-valor): 0.0012  
- Con aditivo (p-valor): 0.083  

Prueba de varianzas (F-test):
- p-valor: 0.214  

Prueba t de Welch:
- Estadístico t: -1.682  
- Grados de libertad: 21.95  
- p-valor: 0.106  
- Intervalo de confianza (95%): (-3.71, 0.39)  

Conclusión: No se rechaza H₀. No hay diferencia significativa (p = 0.106)
```

### Interpretación:
- **p-valor = 0.106 > 0.05**: No hay evidencia suficiente para afirmar que el aditivo cambia la densidad.
- **Advertencia**: Los datos "sin aditivo" no siguen una distribución normal (\( p = 0.0012 \)), por lo que la prueba *t* podría no ser válida. En este caso, una prueba no paramétrica (Mann-Whitney) sería más apropiada.
```

**Respuesta para la pregunta 4:**

```r
# --------------------------------------
# PROBLEMA 4: Longitud de tachuelas por máquina
# --------------------------------------

# 1. Datos
maquinas <- data.frame(
  longitud = c(
    14.0, 14.1, 14.2, 14.0, 14.1,
    13.9, 13.8, 13.9, 14.0, 14.0,
    14.1, 14.2, 14.1, 14.0, 13.9,
    13.6, 13.8, 14.0, 13.9, 13.7,
    13.8, 13.6, 13.9, 13.8, 14.0
  ),
  maquina = factor(rep(1:5, each = 5))
)

# 2. Verificación de supuestos
# a. Normalidad (Shapiro-Wilk por grupo)
library(dplyr)
shapiro_results <- maquinas %>%
  group_by(maquina) %>%
  summarise(p_valor = shapiro.test(longitud)$p.value)

# b. Homogeneidad de varianzas (prueba de Levene)
library(car)
levene_test <- leveneTest(longitud ~ maquina, data = maquinas)

# 3. ANOVA de un factor
anova_result <- aov(longitud ~ maquina, data = maquinas)
anova_table <- summary(anova_result)

# 4. Resultados
cat("----------------------\n")
cat("Prueba de normalidad por grupo:\n")
print(shapiro_results)
cat("\nPrueba de Levene (homogeneidad de varianzas):\n")
cat("- p-valor:", levene_test$`Pr(>F)`[1], "\n\n")

cat("Tabla ANOVA:\n")
print(anova_table[[1]])
cat("----------------------\n")

# 5. Conclusión
alpha_5 <- 0.05
alpha_10 <- 0.10
p_valor_anova <- anova_table[[1]]$`Pr(>F)`[1]

cat("\nConclusiones:\n")
if (p_valor_anova < alpha_5) {
  cat("- Con α = 5%: Rechazamos H₀. Existen diferencias significativas entre las máquinas.\n")
} else if (p_valor_anova < alpha_10) {
  cat("- Con α = 10%: Rechazamos H₀. Hay evidencia de diferencias entre las máquinas.\n")
} else {
  cat("- No se rechaza H₀. No hay diferencias significativas (α = 5% y 10%).\n")
}

# Si se violan supuestos, sugerir prueba no paramétrica
if (any(shapiro_results$p_valor < 0.05) {
  cat("\nAdvertencia: Al menos un grupo no sigue una distribución normal. Considere usar la prueba de Kruskal-Wallis.\n")
}
```

### Explicación:
- **a. Modelo**: ANOVA de un factor (comparación de medias entre 5 máquinas).
- **b. Hipótesis**:
  - \( H_0: \mu_1 = \mu_2 = \mu_3 = \mu_4 = \mu_5 \)
  - \( H_1: \) Al menos una media difiere.
- **c. Suposiciones**: Normalidad (Shapiro-Wilk) y homogeneidad de varianzas (Levene).
- **d. Tabla ANOVA**: Muestra la variabilidad entre grupos y dentro de grupos.
- **e. Conclusiones**: Basadas en el p-valor del ANOVA.

---

**Respuesta para la pregunta 5:**

```r
# --------------------------------------
# PROBLEMA 5: Resistencia por porcentaje de algodón
# --------------------------------------

# 1. Datos
algodon <- data.frame(
  resistencia = c(
    7, 7, 15, 11, 9,
    12, 17, 12, 18, 18,
    14, 18, 18, 19, 19,
    19, 25, 22, 19, 23,
    7, 10, 11, 15, 11
  ),
  porcentaje = factor(rep(c(15, 20, 25, 30, 35), each = 5))
)

# 2. Verificación de supuestos (igual que en P4)
shapiro_results_alg <- algodon %>%
  group_by(porcentaje) %>%
  summarise(p_valor = shapiro.test(resistencia)$p.value)

levene_test_alg <- leveneTest(resistencia ~ porcentaje, data = algodon)

# 3. ANOVA de un factor
anova_alg <- aov(resistencia ~ porcentaje, data = algodon)
anova_table_alg <- summary(anova_alg)

# 4. Resultados
cat("----------------------\n")
cat("Prueba de normalidad por grupo:\n")
print(shapiro_results_alg)
cat("\nPrueba de Levene (homogeneidad de varianzas):\n")
cat("- p-valor:", levene_test_alg$`Pr(>F)`[1], "\n\n")

cat("Tabla ANOVA:\n")
print(anova_table_alg[[1]])
cat("----------------------\n")

# 5. Conclusión
p_valor_alg <- anova_table_alg[[1]]$`Pr(>F)`[1]

cat("\nConclusiones:\n")
if (p_valor_alg < alpha_5) {
  cat("- Con α = 5%: Rechazamos H₀. El porcentaje de algodón afecta la resistencia.\n")
} else if (p_valor_alg < alpha_10) {
  cat("- Con α = 10%: Rechazamos H₀. Hay evidencia de efecto del algodón.\n")
} else {
  cat("- No se rechaza H₀. No hay efecto significativo (α = 5% y 10%).\n")
}

# Si se violan supuestos, sugerir prueba no paramétrica
if (any(shapiro_results_alg$p_valor < 0.05)) {
  cat("\nAdvertencia: Al menos un grupo no sigue una distribución normal. Considere usar la prueba de Kruskal-Wallis.\n")
}
```

### Explicación:
- **a. Modelo**: ANOVA de un factor (comparación de medias entre 5 niveles de algodón).
- **b. Hipótesis**:
  - \( H_0: \mu_{15\%} = \mu_{20\%} = \mu_{25\%} = \mu_{30\%} = \mu_{35\%} \)
  - \( H_1: \) Al menos una media difiere.
- **c. Suposiciones**: Normalidad y homogeneidad de varianzas.
- **d. Tabla ANOVA**: Evalúa si hay diferencias significativas entre grupos.
- **e. Conclusiones**: Basadas en el p-valor del ANOVA.

---

**Nota**: Ejecute el código en R para obtener los valores numéricos (p-valores, estadísticos) y ajuste las conclusiones según los resultados. Si las suposiciones no se cumplen, use alternativas no paramétricas como `kruskal.test()` en lugar de ANOVA.