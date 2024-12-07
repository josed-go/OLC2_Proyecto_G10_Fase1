import * as monaco from 'https://cdn.jsdelivr.net/npm/monaco-editor@0.50.0/+esm'
import {parse} from './parser/gramatica.js'


const btnAnalizar = document.getElementById('analizar')

const editor = monaco.editor.create(
    document.getElementById('editor'), {
        value:'',
        language: 'java',
        // theme: 'vs-dark',
        theme: 'tema',
        automaticLayout: true
    }
)

btnAnalizar.addEventListener('click', () => {
    const entrada = editor.getValue()
    try{
        const ast = parse(entrada)
        console.log(ast)
        salida.setValue("Analisis Exitoso")
    }catch(e){
        console.error(e)
        salida.setValue("Error: "+e)
    }
    
    

})

const salida = monaco.editor.create(
    document.getElementById('salida'), {
        value:'',
        language: 'java',
        // theme: 'vs-dark',
        readOnly: true,
        automaticLayout: true
    }
)