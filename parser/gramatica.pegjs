gramatica = _ producciones (_ producciones)*

producciones = identificador _ "=" _ opciones _ ";" _
            / identificador _ "=" _ opciones _

opciones = union (_ "/" _ union)*

union = expresion (_ expresion)*

expresion  = ("&"/"!"/"$" / etiqueta)? _ expresiones _ [?+*]?

etiqueta = ("@")? _ identificador _ ":"

expresiones  =  identificador
                / literales "i"?
                / "(" _ opciones _ ")"
                / corchetes "i"?
                / "."
                / "!."
// Regla principal que analiza corchetes con contenido
corchetes
    = "[" contenido:(rango / caracter)+ "]" {
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

_ = (Comentarios /[ \t\n\r])*


Comentarios = 
    "//" [^\n]* 
    / "/*" (!"*/" .)* "*/"
