gramatica = producciones (_ producciones)*

producciones = identificador _ "=" _ opciones _ ";" _

opciones = union (_ "/" _ union)*

union = expresion (_ expresion)*

expresion  = expresiones _ [?+*]?

expresiones  = identificador
                    / literales
                    / "(" _ opciones _ ")"
                    / corchetes
                    
// Regla principal que analiza corchetes con contenido
corchetes
  = "[" contenido:rango ("-" rango)* "]" {
      return `Entrada válida: [${input}]`;
    }

// Regla para validar los rangos de contenido
rango
  = contenido:contenido {
      // Extraemos el contenido como un solo rango para validación
      if (contenido.length > 1) {
        const start = contenido[0];
        const end = contenido[contenido.length - 1];
        if (start > end) {
          throw new Error(`Rango inválido: [${contenido}]`);
        }
      }
      return contenido;
    }


// Coincide con cualquier contenido que no incluya "]"
contenido
  = [^[\]]+


literales = 
    "\"" [^"]* "\""
    / "'" [^']* "'"

identificador = [_a-z]i[_a-z0-9]i*

_ = [ \t\n\r]*

