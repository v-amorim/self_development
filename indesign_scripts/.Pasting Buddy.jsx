#targetengine session

// Main Dialog Window
var dialog = new Window("palette", "Pasting Buddy", undefined);
dialog.preferredSize.width = 300;
dialog.preferredSize.height = 80;
dialog.text = "Pasting Buddy";
dialog.onClose = function() {
    doc.removeEventListener('afterSelectionChanged', selectionChanged);
};

// UI Elements
dialog.add("statictext", undefined, "Previous text:");
var previousPastedTextEdit = dialog.add("edittext");
previousPastedTextEdit.characters = 40;

dialog.add("statictext", undefined, "Next text:");
var nextPasteTextEdit = dialog.add("edittext");
nextPasteTextEdit.text = "";
nextPasteTextEdit.characters = 40;

// Actions Panel
var actionsPanel = dialog.add("panel", undefined, undefined, {
    name: "actionsPanel"
});
actionsPanel.text = "Actions";
actionsPanel.orientation = "row";
actionsPanel.alignChildren = ["center", "top"];
actionsPanel.spacing = 10;
actionsPanel.margins = 10;

// Pause Button
var pauseState = false;
var pauseButton = actionsPanel.add("button", undefined, undefined, {
    name: "pauseButton"
});
pauseButton.text = "Pause";
pauseButton.onClick = function() {
    pauseState = !pauseState;
    nextPasteTextEdit.text = pauseState ? "[PAUSED] " + nextPasteTextEdit.text : nextPasteTextEdit.text.replace(/^\[PAUSED\] /, "");
    pauseButton.text = pauseState ? "Resume" : "Pause";
};

// Formatting Button
var formattingState = false;
var formattingButton = actionsPanel.add("button", undefined, undefined, {
    name: "formattingButton"
});
formattingButton.text = "Paste with formatting";
formattingButton.onClick = function() {
    formattingState = !formattingState;
    formattingButton.text = formattingState ? "Paste without formatting" : "Paste with formatting";
};

// Remove Empty Lines Button
var removeEmptyLinesButton = actionsPanel.add("button", undefined, undefined, {
    name: "removeEmptyLinesButton"
});
removeEmptyLinesButton.text = "Remove Empty Lines";
removeEmptyLinesButton.onClick = removeEmptyLinesFromMasterFrame;

// Document and Master Frame
var doc = app.activeDocument;
var master_frame = app.selection[0]; // <-- the Text Script frame

// Initialization
function init() {
    if (master_frame instanceof TextFrame || master_frame instanceof Story) {
        dialog.show();
        app.selection = null;
        doc.addEventListener('afterSelectionChanged', selectionChanged);
    } else {
        alert("Please, select a frame with text before running the script!");
        exit();
    }
}

// Selection Changed Event Handler
function selectionChanged() {
    if (pauseState) return;

    var sel = doc.selection[0];

    if (sel instanceof InsertionPoint) sel = sel.parent.textContainers[0];
    if (sel instanceof TextFrame || sel instanceof Story) {
        if (sel.contents == '' && master_frame.contents != '') {
            app.select(master_frame.paragraphs[0], SelectionOptions.REPLACE_WITH);
            var nextText = master_frame.paragraphs[1] ? master_frame.paragraphs[1].contents : "";
            nextPasteTextEdit.text = nextText;
            app.cut();
            app.selection = null;
            sel.texts.everyItem().select();

            if (formattingState) {
                app.pasteWithoutFormatting();
            } else {
                app.paste();
            }
            previousPastedTextEdit.text = sel.contents;

            app.selection = null;
            removeLineBreaks(sel);
            sel.parentStory.changeGrep();
        }

        if (master_frame.contents == '') alert("No text to paste anymore!");
    }
}

// Remove Line Breaks
function removeLineBreaks(sel) {
    app.findGrepPreferences.findWhat = "\r$";
    app.changeGrepPreferences.changeTo = "";
    sel.changeGrep();
    sel.parentStory.changeGrep();
}

// Remove Empty Lines from Master Frame
function removeEmptyLinesFromMasterFrame() {
    var story = master_frame.parentStory;
    var paragraphs = story.paragraphs;

    for (var i = paragraphs.length - 1; i >= 0; i--) {
        if (paragraphs[i].contents == "\r") {
            paragraphs[i].remove();
        }
    }
}

// Start the script
init();
