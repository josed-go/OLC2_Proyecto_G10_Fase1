gramatica = _ producciones+ _

producciones = identificador _ (literales)? _ "=" _ opciones _ (t";"t)? 

opciones = union (_ "/" _ union)*

union = expresion (t expresion)*

expresion  = (varios/etiqueta)? t expresiones t ([?+*]/conteo)?

etiqueta = ("@")? t identificador t ":" (varios)?

varios = ("!"/"$"/"@")

expresiones  =  identificador
                / literales "i"?
                / "(" t opciones t ")"
                / corchetes "i"?
                / "."
                / "!."

conteo = "|" parteconteo _ (_ delimitador )? _ "|"

parteconteo = identificador
            / [0-9]? _ ".." _ [0-9]?
			/ [0-9]

delimitador =  "," _ expresion

// Regla principal que analiza corchetes con contenido
corchetes
    = "[" contenido:(rango / contenido)+ "]" {
        return `Entrada válida: [${input}]`;
    }

// Regla para validar un rango como [A-Z]
rango
    = inicio:caracter "-" fin:caracter {
        if (inicio.charCodeAt(0) > fin.charCodeAt(0)) {
            throw new Error(`Rango inválido: [${inicio}-${fin}]`);
        }
        return `${inicio}-${fin}`;
    }

// Regla para caracteres individuales
caracter
    = [a-zA-Z0-9_ ]

// Coincide con cualquier contenido que no incluya "]"
contenido
    = [^[\]]+


literales = 
    "\"" [^"]* "\""
    / "'" [^']* "'"

identificador = [_a-z]i[_a-z0-9]i*

t = [ \t]*

_ = (Comentarios /[ \t\n\r])*


Comentarios = 
    "//" [^\n]* 
    / "/*" (!"*/" .)* "*/"
