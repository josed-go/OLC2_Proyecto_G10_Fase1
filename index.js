import * as monaco from 'https://cdn.jsdelivr.net/npm/monaco-editor@0.50.0/+esm'


const editor = monaco.editor.create(
    document.getElementById('editor'), {
        value:'',
        language: 'java',
        // theme: 'vs-dark',
        theme: 'tema',
        automaticLayout: true
    }
)

const salida = monaco.editor.create(
    document.getElementById('salida'), {
        value:'',
        language: 'java',
        // theme: 'vs-dark',
        readOnly: true,
        automaticLayout: true
    }
)