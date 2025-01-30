#targetengine session

// Kind regards to Yuri Khristich for helping me solve this: https://stackoverflow.com/a/69066444
var dialog = new Window("palette", "Pasting Buddy", undefined);
dialog.preferredSize.width = 300;
dialog.preferredSize.height = 80;
dialog.text = "Pasting Buddy";
dialog.onClose = function() {
    doc.removeEventListener('afterSelectionChanged', selectionChanged)
}

dialog.add("statictext", undefined, "Previous text:");
var previousPastedTextEdit = dialog.add("edittext");
previousPastedTextEdit.characters = 40;

dialog.add("statictext", undefined, "Next text:");
var nextPasteTextEdit = dialog.add("edittext");
nextPasteTextEdit.text = "";
nextPasteTextEdit.characters = 40;

// ACTIONSPANEL
// ============
var actionsPanel = dialog.add("panel", undefined, undefined, {
    name: "actionsPanel"
});
actionsPanel.text = "Actions";
actionsPanel.orientation = "row";
actionsPanel.alignChildren = ["center", "top"];
actionsPanel.spacing = 10;
actionsPanel.margins = 10;

var pauseState = false;
var pauseButton = actionsPanel.add("button", undefined, undefined, {
    name: "pauseButton"
});
pauseButton.text = "Pause";
pauseButton.onClick = function() {
    pauseState = !pauseState;
    if (pauseState) nextPasteTextEdit.text = "[PAUSED] " + nextPasteTextEdit.text;
    if (!pauseState) nextPasteTextEdit.text = nextPasteTextEdit.text.replace(/^\[PAUSED\] /, "");
    pauseButton.text = pauseState ? "Resume" : "Pause";
};

var formattingState = false;
var formattingButton = actionsPanel.add("button", undefined, undefined, {
    name: "formattingButton"
});
formattingButton.text = "Paste with formatting";
formattingButton.onClick = function() {
    formattingState = !formattingState;
    formattingButton.text = formattingState ? "Paste without formatting" : "Paste with formatting";
};

var removeEmptyLinesButton = actionsPanel.add("button", undefined, undefined, {
    name: "removeEmptyLinesButton"
});
removeEmptyLinesButton.text = "Remove Empty Lines";
removeEmptyLinesButton.onClick = function() {
    removeEmptyLinesFromMasterFrame();
};


var doc = app.activeDocument;
var master_frame = app.selection[0]; // <-- the Text Script frame

function init() {
    if (master_frame instanceof TextFrame || master_frame instanceof Story) {
        dialog.show();
        app.selection = null;
        doc.addEventListener('afterSelectionChanged', selectionChanged);
    } else {
        alert("Please, select a frame with text before run the script!");
        exit();
    }
}

function selectionChanged() {
    if (pauseState) return;

    var sel = doc.selection[0];

    if (sel instanceof InsertionPoint) sel = sel.parent.textContainers[0];
    if (sel instanceof TextFrame || sel instanceof Story) {
        if (sel.contents == '' && master_frame.contents != '') {
            app.select(master_frame.paragraphs[0], SelectionOptions.REPLACE_WITH);
            nextText = master_frame.paragraphs[1] ? master_frame.paragraphs[1].contents : "";
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

        if (master_frame.contents == '') alert("No text to paste anymore!")
    }
}


function removeLineBreaks(sel) {
    // remove '\r' at the end
    app.findGrepPreferences.findWhat = "\r$";
    app.changeGrepPreferences.changeTo = "";
    sel.changeGrep();
    sel.parentStory.changeGrep();
}

function removeEmptyLinesFromMasterFrame() {
    // remove lines with only '\r' from master_frame
    var story = master_frame.parentStory;
    var paragraphs = story.paragraphs;

    for (var i = paragraphs.length - 1; i >= 0; i--) {
        if (paragraphs[i].contents == "\r") {
            paragraphs[i].remove();
        }
    }
}

init();
