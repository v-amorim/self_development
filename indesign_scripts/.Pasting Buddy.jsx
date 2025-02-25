#targetengine session

// Main Dialog Window
var dialog = new Window("palette", "Pasting Buddy", undefined);
dialog.minimumSize = [300, 150];
dialog.alignChildren = ["center", "top"];
dialog.text = "Pasting Buddy";
dialog.onClose = function() {
    doc.removeEventListener('afterSelectionChanged', selectionChanged);
};

// Tabbed Panel
var tabbedPanel = dialog.add("tabbedpanel");
tabbedPanel.alignment = ["fill", "fill"];
tabbedPanel.margins = 10;

// Tab 1: Pasting Buddy
var pasteTab = tabbedPanel.add("tab", undefined, "Pasting Buddy");
pasteTab.alignment = ["fill", "fill"];

// Text Fields Container
var textContainer = pasteTab.add("group", undefined, "textContainer");
textContainer.orientation = "column";
textContainer.alignment = ["fill", "fill"];
textContainer.alignChildren = ["center", "top"];
textContainer.spacing = 5;

// Text Fields
function createTextField(labelText) {
    var group = textContainer.add("group");
    group.orientation = "column";
    group.alignment = ["fill", "top"];
    group.spacing = 2;
    group.margins = [0, 0, 0, 5];

    var label = group.add("statictext", undefined, labelText);
    label.alignment = ["center", "top"];

    var editText = group.add("edittext", undefined, "", {
        bounds: [0, 0, 280, 25]
    });
    editText.alignment = ["fill", "top"];
    editText.minimumSize.width = 280;
    editText.maximumSize.width = 280;
    editText.margins = [10, 0, 10, 0];
    return editText;
}

var previousPastedTextEdit = createTextField("Previous text:");
var nextPasteTextEdit = createTextField("Next text:");

// Actions Panel
var actionsPanel = pasteTab.add("group");
actionsPanel.orientation = "column";
actionsPanel.alignment = ["fill", "top"];
actionsPanel.spacing = 10;

var buttonGroup = actionsPanel.add("group");
buttonGroup.orientation = "row";
buttonGroup.alignment = ["center", "center"];
buttonGroup.spacing = 10;
buttonGroup.margins = [0, 10, 0, 0];

var pauseState = false;
var pauseButton = buttonGroup.add("button", undefined, "Pause");
pauseButton.minimumSize.width = 100;

var formattingState = false;
var formattingButton = buttonGroup.add("button", undefined, "Paste with formatting");
formattingButton.minimumSize.width = 150;

// Button Events
pauseButton.onClick = function() {
    pauseState = !pauseState;
    nextPasteTextEdit.text = pauseState ? "[PAUSED] " + nextPasteTextEdit.text : nextPasteTextEdit.text.replace(/^\[PAUSED\] /, "");
    this.text = pauseState ? "Resume" : "Pause";
};

formattingButton.onClick = function() {
    formattingState = !formattingState;
    this.text = formattingState ? "Paste without formatting" : "Paste with formatting";
};

// Tab 2: GREP Replace
var grepTab = tabbedPanel.add("tab", undefined, "GREP Replace");
grepTab.alignment = ["fill", "fill"];

var grepContent = grepTab.add("group");
grepContent.orientation = "column";
grepContent.alignChildren = ["center", "top"];
grepContent.spacing = 10;
grepContent.margins = 15;


// GREP Replace Rules Grid
var grepRules = [{
        name: "Double Spaces",
        find: "[ \\t\\n\\f\\v]{2,}",
        replace: " "
    },
    {
        name: "Leading Spaces",
        find: "^[ \\t\\n\\f\\v]+",
        replace: ""
    },
    {
        name: "Trailing Spaces",
        find: "[ \\t\\n\\f\\v]+$",
        replace: ""
    },
    {
        name: "Empty Paragraphs",
        find: "\\r$",
        replace: ""
    },
    {
        name: "Pagina(s)",
        find: ".*P[AÁ]G(INA)?[S]?\\s*\\d{1,2}\\r",
        replace: ""
    },
    {
        name: "Numbering",
        find: "^\\d{1,2}-",
        replace: ""
    },
];

var columns = 2;
var buttonWidth = 150;
var buttonHeight = 25;
var gridGroup = grepContent.add("group");
gridGroup.orientation = "column";
gridGroup.spacing = 5;

for (var i = 0; i < grepRules.length; i += columns) {
    var rowGroup = gridGroup.add("group");
    rowGroup.orientation = "row";
    rowGroup.spacing = 10;

    for (var j = 0; j < columns; j++) {
        if (i + j >= grepRules.length) break;
        var rule = grepRules[i + j];
        var button = rowGroup.add("button", undefined, rule.name);
        button.minimumSize = [buttonWidth, buttonHeight];
        button.rule = rule;
        button.onClick = function() {
            applyGrepReplaceToMasterFrame(this.rule.find, this.rule.replace);
        };
    }
}

// Document and Master Frame
var doc = app.activeDocument;
var master_frame = app.selection[0];

// Initialization
function init() {
    if (master_frame instanceof TextFrame || master_frame instanceof Story) {
        dialog.show();
        app.selection = null;
        doc.addEventListener('afterSelectionChanged', selectionChanged);
    } else {
        alert("Select a text frame before running!");
        exit();
    }
}

// Selection Changed Event Handler
function selectionChanged() {
    if (pauseState) return;

    // Check if master_frame is still valid
    if (!master_frame.isValid) {
        alert("The master text frame has been removed. Closing Pasting Buddy.");
        dialog.close();
        return;
    }

    var sel = doc.selection[0];

    if (sel instanceof InsertionPoint) sel = sel.parent.textContainers[0];
    if (sel instanceof TextFrame || sel instanceof Story) {
        if (sel.contents == '' && master_frame.contents != '') {
            // Ensure master_frame still has paragraphs
            if (master_frame.paragraphs.length === 0) {
                alert("No text left in master frame!");
                return;
            }
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
    // remove '\r' at the end
    app.findGrepPreferences.findWhat = "\r$";
    app.changeGrepPreferences.changeTo = "";
    sel.changeGrep();
    sel.parentStory.changeGrep();
}

// Function to Convert Accented Characters to Unicode Escape Sequences
function convertToUnicodeEscape(str) {
    return str.replace(/[^\x00-\x7F]/g, function(charactere) {
        return "\\u" + ("0000" + charactere.charCodeAt(0).toString(16)).slice(-4);
    });
}

// GREP Replace Function (Applies to the entire story of the master frame)
function applyGrepReplaceToMasterFrame(find, replace) {
    if (master_frame instanceof TextFrame) {
        var story = master_frame.parentStory; // Get the entire story

        // Convert accented characters in the "find" pattern to Unicode escape sequences
        var unicodeFind = convertToUnicodeEscape(find);
        app.findGrepPreferences.findWhat = unicodeFind;
        app.changeGrepPreferences.changeTo = replace;

        // Apply GREP replacement to the entire story
        story.changeGrep();

        // Reset preferences
        app.findGrepPreferences = NothingEnum.nothing;
        app.changeGrepPreferences = NothingEnum.nothing;
    } else {
        alert("Master frame is not a valid text frame.");
    }
}

// Start the script
init();
