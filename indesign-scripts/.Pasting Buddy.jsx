#targetengine session

var dialog = new Window("palette", "Pasting Buddy", undefined);
dialog.preferredSize.width = 300;
dialog.preferredSize.height = 50;
dialog.text = "Pasting Buddy";
dialog.onClose = function () { doc.removeEventListener('afterSelectionChanged', selectionChanged) }

dialog.add("statictext", undefined, "Last copied text:");

var textEdit = dialog.add("edittext");
textEdit.text = "";
textEdit.characters = 40;

// ACTIONSPANEL
// ============
var actionsPanel = dialog.add("panel", undefined, undefined, { name: "actionsPanel" });
actionsPanel.text = "Actions";
actionsPanel.orientation = "row";
actionsPanel.alignChildren = ["center", "top"];
actionsPanel.spacing = 10;
actionsPanel.margins = 10;
actionsPanel.preferredSize.width = windowDimensions.width - 30;

var pause = false;
var pauseButton = actionsPanel.add("button", undefined, undefined, { name: "pauseButton" });
pauseButton.text = "Pause";
pauseButton.onClick = function () {
    pause = !pause;
    if (pause) textEdit.text = "[PAUSED] " + textEdit.text;
    if (!pause) textEdit.text = textEdit.text.replace(/^\[PAUSED\] /, "");
    pauseButton.text = pause ? "Resume" : "Pause";
};

var paste_without_formatting = false;
var formattingButton = actionsPanel.add("button", undefined, undefined, { name: "resetScript" });
formattingButton.text = "Paste with formatting";
formattingButton.onClick = function () {
    paste_without_formatting = !paste_without_formatting;
    formattingButton.text = paste_without_formatting ? "Paste without formatting" : "Paste with formatting";
};


// ---

var doc = app.activeDocument;
var master_frame = app.selection[0]; // <-- the Text Script frame

if (master_frame instanceof TextFrame || master_frame instanceof Story) {
    dialog.show();
    app.selection = null;
    doc.addEventListener('afterSelectionChanged', selectionChanged);
} else {
    alert("Please, select a frame with text before run the script!");
    exit();
}

function selectionChanged() {

    if (pause) return;

    var sel = doc.selection[0];

    if (sel instanceof InsertionPoint) sel = sel.parent.textContainers[0];
    if (sel instanceof TextFrame || sel instanceof Story) {

        if (sel.contents == '' && master_frame.contents != '') {

            app.select(master_frame.paragraphs[0], SelectionOptions.REPLACE_WITH);
            textEdit.text = master_frame.paragraphs[0].contents;
            app.cut();
            app.selection = null;
            sel.texts.everyItem().select();
            if (paste_without_formatting) {
                app.pasteWithoutFormatting();
            } else {
                app.paste();
            }
            app.selection = null;

            // remove '\r' at the end
            app.findGrepPreferences.findWhat = "\r$";
            app.changeGrepPreferences.changeTo = "";
            sel.changeGrep();

        }

        if (master_frame.contents == '') alert("No text to paste anymore!")
    }
}