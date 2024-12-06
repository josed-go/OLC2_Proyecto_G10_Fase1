// Parser de Gramática PEG 
// Soporta las reglas de sintaxis PEG especificadas

// La regla inicial es la primera regla definida
inicio = _ gramatica _ {}

// Una gramática es una serie de reglas, opcionalmente separadas por punto y coma
gramatica =_ terminal _"="_ expresion+ 
terminal = [_a-z][_a-z0-9]* {}
      
expresion=  [ \t\r]*  [\n;] _ t:terminal _ "="_ c:(expresion) {return {t,c}}	
            /_ terminal fin 
			/_ reservadas  fin 
            /_ caracter  fin
            /_ numeros  fin
            /_ "("_ expresion+ _")"_ fin
            / _"/"_ expresion  fin

fin=("+"/"*"/"?")?
//reservadas =('"'[_a-z0-9]+'"'/"'"[_a-z0-9]+"'") {}
reservadas = "\"" contenido:[^"]* "\"" { var text = contenido.join(""); 
            text = text.replace(/\\n/g, "\n");
            text = text.replace(/\\\\/g, "\\");
            text = text.replace(/\\\"/g,"\"");
            text = text.replace(/\\r/g, "\r");
            text = text.replace(/\\t/g, "\t");
            text = text.replace(/\\\'/g, "'");
            }
caracter = "'" caracter:[\x00-\x7F] "'" {}
numeros=_ numero:("["n1:[0-9]+"-"n2:[0-9]+"]") {}

// Espacio en blanco opcional
_ = [ \t\n\r\n]*{}