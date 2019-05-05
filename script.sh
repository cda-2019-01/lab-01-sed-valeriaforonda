# Escriba su código aquí
sed 's%/%-%g' data.csv > out.1 #Aquí se reemplazan todos los / por - para que no dificulte el trabajo con este caracter
sed 's/,/./g' out.1 > out.2 #Aquí se cambia la separación decimal que era coma por el punto
sed 's/;/,/g' out.2 > out.3 #Aquí se reemplazan los punto y comas por comas
sed 's/\([0-9][0-9]\)-\([0-9][0-9]\)-\([0-9][0-9]\),/20\3-\2-\1,/' out.3 > out.4 #Aquí se invierte el orden del día-mes-año por año-mes-día y se le agregan los primeros dos dígitos al año (En este punto se asume que todos los años son de 2.000)
sed 's/,,/,\\N,/g' out.4 > out.5 #Aquí se reemplazan los espacios vacíos (que no son los de la última columna) por \N
sed -e 's/.$/,/' out.5 > out.6 #Aquí le agrego una coma al final de cada línea, con el fin de poder identificar a cuáles líneas les falta el valor de la cuarta columna
sed 's/,,/,\\N,/g' out.6 > out.7 #Aquí se reemplazan las celdas vacías, es decir, que tienen dos comas juntas, por el \N, con la intención de que todas las líneas queden con una coma al final
sed -e  's/.$//' out.7 > out.8 #Aquí se elimina el último elemento de cada fila, es decir, la coma
grep -v \N out.8 > final #Aquí se filtran las líneas que no contienen \N, es decir, si una fila no contiene \N es porque no tiene campos nulos 
rm out.* #Elimino todos los archivo que no son el definitivo que necesito
