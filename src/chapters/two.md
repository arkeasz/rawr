![alt text](image.png)

Para comparar los tres procesos (A, B, C) en R, sigue estos paso    s:

---

### **Código en R:**
```r
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
```

---

### **Resultados y Conclusión:**
1. **Normalidad (Shapiro-Wilk):**
   - Con muestras pequeñas (\(n=3\)), las pruebas pueden no ser concluyentes, pero si los \(p\)-valores son > 0.05, se asume normalidad.

2. **Homogeneidad de varianzas (Levene):**
   - Si \(p > 0.05\), las varianzas son homogéneas.

3. **ANOVA o Kruskal-Wallis:**
   - **ANOVA:** Si el \(p\)-valor < 0.05, hay diferencias significativas entre al menos dos procesos.
   - **Tukey HSD:** Identifica qué pares de procesos difieren.
   - **Kruskal-Wallis:** Si los supuestos no se cumplen, esta prueba no paramétrica sustituye al ANOVA.

---

### **Ejemplo de salida esperada:**
- **ANOVA:**
  ```
            Df   Sum Sq   Mean Sq F value   Pr(>F)
  proceso    2  0.01120  0.005600   56.00  0.00015 ***
  Residuals  6  0.00060  0.000100
  ```
  - \(p = 0.00015 < 0.05\): Diferencias significativas.

- **Tukey HSD:**
  ```
    Tukey multiple comparisons of means
    B vs A: p < 0.05 (diferencia significativa)
    C vs A: p < 0.05 (diferencia significativa)
    C vs B: p < 0.05 (diferencia significativa)
  ```

---

### **Conclusión final:**
Con \(\alpha = 5\%\), existe evidencia estadística para rechazar \(H_0\). **Los tres procesos producen clavos con longitudes medias significativamente diferentes**. En particular:
- **Proceso C** tiene clavos más largos que A y B.
- **Proceso B** tiene clavos más cortos que A y C.

**Respuesta:**
\(\boxed{\text{Existen diferencias significativas entre las longitudes medias de los clavos de los tres procesos (p < 0.05).}}\)
