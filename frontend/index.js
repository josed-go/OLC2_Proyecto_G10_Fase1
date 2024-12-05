
import * as monaco from 'https://cdn.jsdelivr.net/npm/monaco-editor@0.50.0/+esm';


let simbolos=[];

let editorCount = 0;
const editors = [];
const editorContainer = document.getElementById('editor-container');
const tabContainer = document.getElementById('tab-container');
const viewerContainer = document.getElementById('viewer-container');
let viewerEditor = null;

const botonEjecutar = document.getElementById('btnEjecutar');




function createEditor() {
    editorCount++;
    const editorId = `editor-${editorCount}`;
    
    // Crear pestaña
    const tab = document.createElement('button');
    tab.className = 'tab';
    tab.textContent = `Editor ${editorCount}`;
    tab.onclick = () => activateEditor(editorId);
    tabContainer.appendChild(tab);

    // Crear contenedor del editor
    const editorDiv = document.createElement('div');
    editorDiv.id = editorId;
    editorDiv.className = 'editor';
    editorContainer.appendChild(editorDiv);

    // Crear instancia del editor Monaco
    const editor = monaco.editor.create(editorDiv, {
        value: '',
        language: 'javascript',
        theme: 'vs-dark'
    });

    editors.push({ id: editorId, editor, tab, fileName: null });
    activateEditor(editorId);
}

function createViewer(content = '') {
// Crear el editor no modificable
const viewerDiv = document.createElement('div');
viewerDiv.id = 'viewer';
viewerContainer.innerHTML = ''; // Limpiar el contenedor
viewerContainer.appendChild(viewerDiv);

viewerEditor = monaco.editor.create(viewerDiv, {
value: content,
language: 'javascript',
theme: 'vs-dark',
readOnly: true, // Hacer el editor solo de lectura
automaticLayout: true // Ajusta automáticamente el tamaño
});

// Asegurarse de que el editor se ajuste al tamaño del contenedor
function resizeEditor() {
viewerEditor.layout();
}

// Llamar a resizeEditor inmediatamente y también cuando cambie el tamaño de la ventana
resizeEditor();
window.addEventListener('resize', resizeEditor);
}

function activateEditor(editorId) {
    editors.forEach(({ id, editor, tab }) => {
        if (id === editorId) {
            tab.classList.add('active');
            document.getElementById(id).classList.add('active');
            editor.layout(); // Asegura que el editor se ajuste correctamente
        } else {
            tab.classList.remove('active');
            document.getElementById(id).classList.remove('active');
        }
    });
}

window.addEditor = createEditor;

window.openFile = async function(event) {
    try {
        const file = event.target.files[0];
        if (!file) return;

        const content = await file.text();
        
        let activeEditor = editors.find(e => document.getElementById(e.id).classList.contains('active'));
        if (!activeEditor) {
            createEditor();
            activeEditor = editors[editors.length - 1];
        }

        activeEditor.editor.setValue(content);
        activeEditor.fileName = file.name;
        activeEditor.tab.textContent = file.name;

        // Actualizar el contenido del visor con el nuevo contenido
        //createViewer(content);
    } catch (error) {
        console.error('Error al abrir el archivo:', error);
    }
};

window.saveFile = function() {
    try {
        const activeEditor = editors.find(e => document.getElementById(e.id).classList.contains('active'));
        if (!activeEditor) return;
        
        const content = activeEditor.editor.getValue();

        // Crear un blob y una URL para descargar el archivo
        const blob = new Blob([content], { type: 'text/plain' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = activeEditor.fileName || 'archivo.oak';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);

        console.log("Archivo guardado correctamente.");
    } catch (error) {
        console.error('Error al guardar el archivo:', error);
    }
};


// Crear el primer editor al cargar la página
createEditor();
createViewer();



///Desde aca no debo borrar nada 
//todo sirve