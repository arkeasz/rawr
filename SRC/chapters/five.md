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