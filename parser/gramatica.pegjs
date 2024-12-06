// Parser de Gramática PEG 
// Soporta las reglas de sintaxis PEG especificadas

// La regla inicial es la primera regla definida
inicio = _ gramatica:gramatica* _ {}

// Una gramática es una serie de reglas, opcionalmente separadas por punto y coma
gramatica =_ i:terminal _"=" _ (e:expresion  _ cerraduras? _ )+ {}



terminal = [_a-z][_a-z0-9]* {}
      
expresion=  terminal
			/reservadas
            /caracter
            /numeros
            
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
cerraduras = "*" / "+" / "?" 

// Espacio en blanco opcional
_ = [ \t\n\r\n]*{}