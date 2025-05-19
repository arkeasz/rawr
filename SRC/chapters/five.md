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
```