Métodos de gran escala
=============

Material del curso Big data para el ITAM


---------
## Notas


### ¿Cómo mantener actualizado mi `fork`?

```
  > git remote -v
```
Este comando debería de mostrar sólo `origin` apuntando a su `fork`. Un `remote` es un repositorio relacionado (comparten historia) en el cual pueden hacer `pull` o `push` ademas de su repositorio original.

Agregamos el repo de la clase

```
  > git remote add itam-ds https://github.com/ITAM-DS/big-data.git
```

Si ejecutan `git remote -v` deberían de ver ahora `2` repos.

Para hacer `pull` a los cambios realizados en el `remote` `itam-ds`

```
  > git pull itam-ds master
```

(Para hacer `pull` de su `fork`, sigue siendo `git pull`)

Si todo sale bien, ahora pueden hacer `push` a su `fork`. Esto mantendrá los cambios sincronizados.
