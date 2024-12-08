gramatica = producciones (_ producciones)*

producciones = identificador _ "=" _ opciones _ ";" _

opciones = union (_ "/" _ union)*

union = expresion (_ expresion)*

expresion  = expresiones [?+*]?

expresiones  = identificador
                    / literales
                    / "(" _ opciones _ ")"
                    / corchetes
                    
corchetes = "[" contenido ("-"contenido)* "]"

contenido = [^[\]]+

grupo = [a-zA-Z0-9]+ 
alfanumerico = [a-z0-9] 
combinado = [abc0-9ghiA-Z] 

literales = 
    "\"" [^"]* "\""
    / "'" [^']* "'"

identificador = [_a-z]i[_a-z0-9]i*

_ = [ \t\n\r]*
