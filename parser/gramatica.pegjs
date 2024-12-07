gramatica = producciones (_ producciones)*

producciones = identificador _ "=" _ choice _ ";"
  
choice = concatenation (_ "/" _ concatenation)*

concatenation = expression (_ expression)*

expression  = parsingExpression [?+*]?

parsingExpression  = identificador
                    / literales
                    / "(" _ choice _ ")"

literales = 
    ("\"" contenido:[^"]* "\""/"'" contenido:[^"]* "'") { var text = contenido.join(""); 
            text = text.replace(/\\n/g, "\n");
            text = text.replace(/\\\\/g, "\\");
            text = text.replace(/\\\"/g,"\"");
            text = text.replace(/\\r/g, "\r");
            text = text.replace(/\\t/g, "\t");
            text = text.replace(/\\\'/g, "'");
            }

identificador = [_a-z]i[_a-z0-9]i*

_ = [ \t\n\r]*
