#targetengine session

// Main Dialog Window
var pasteBuddyDialog = new Window("palette", "Pasting Buddy", undefined);
pasteBuddyDialog.minimumSize = [300, 150];
pasteBuddyDialog.alignChildren = ["center", "top"];
pasteBuddyDialog.text = "Pasting Buddy";
pasteBuddyDialog.onClose = function() {
    activeDocument.removeEventListener('afterSelectionChanged', handleSelectionChange);
};

// Tabbed Panel
var tabbedPanel = pasteBuddyDialog.add("tabbedpanel");
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

// Function to Create Text Fields
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

var isPaused = false;
var pauseButton = buttonGroup.add("button", undefined, "Pause");
pauseButton.minimumSize.width = 100;

var isFormattingEnabled = false;
var formattingButton = buttonGroup.add("button", undefined, "Paste with formatting");
formattingButton.minimumSize.width = 150;

// Button Events
pauseButton.onClick = function() {
    isPaused = !isPaused;
    nextPasteTextEdit.text = isPaused ? "[PAUSED] " + nextPasteTextEdit.text : nextPasteTextEdit.text.replace(/^\[PAUSED\] /, "");
    this.text = isPaused ? "Resume" : "Pause";
};

formattingButton.onClick = function() {
    isFormattingEnabled = !isFormattingEnabled;
    this.text = isFormattingEnabled ? "Paste without formatting" : "Paste with formatting";
};

// Tab 2: GREP Replace
var grepTab = tabbedPanel.add("tab", undefined, "GREP Replace");
grepTab.alignment = ["fill", "fill"];

var grepContent = grepTab.add("group");
grepContent.orientation = "column";
grepContent.alignChildren = ["center", "top"];
grepContent.spacing = 10;
grepContent.margins = 15;

// GREP Replace Rules
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
        find: ".*P[AÁ]G(INA)?[S]?\\s*\\d{1,3}\\r",
        replace: ""
    },
    {
        name: "Numbering",
        find: "^\\d{1,3}-",
        replace: ""
    }
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

// Tab 3: Utilities
var utilsTab = tabbedPanel.add("tab", undefined, "Utils");
utilsTab.alignment = ["fill", "fill"];

var utilsContent = utilsTab.add("group");
utilsContent.orientation = "column";
utilsContent.alignChildren = ["center", "top"];
utilsContent.spacing = 10;
utilsContent.margins = 15;

var emptyTextButton = utilsContent.add("button", undefined, "Empty text frames");
emptyTextButton.minimumSize.width = 150;
emptyTextButton.onClick = function() {
    findEmptyTextFrames();
};

var rainbowLayersButton = utilsContent.add("button", undefined, "Rainbow Layers");
rainbowLayersButton.minimumSize.width = 150;
rainbowLayersButton.onClick = function() {
    assignLayerColors();
};

var docSetupButton = utilsContent.add("button", undefined, "Document Setup");
docSetupButton.minimumSize.width = 150;
docSetupButton.onClick = function() {
    setupDocument();
};

var isTransparencyApplied = false;
var transparencyButton = utilsContent.add("button", undefined, "Transparency (100%)");
transparencyButton.minimumSize.width = 150;
transparencyButton.onClick = function() {
    isTransparencyApplied = !isTransparencyApplied;
    applyTransparencyToAllObjects(isTransparencyApplied);
    this.text = isTransparencyApplied ? "Transparency (50%)" : "Transparency (100%)";
};


// Document and Master Frame
var activeDocument = app.activeDocument;
var masterTextFrame = app.selection[0];

// Function to create an empty text frame on the first page with top alignment
function createEmptyTextFrame() {
    var page = activeDocument.pages[0];
    var margin = 10; // Margin from the edge of the page
    var frameWidth = 70;
    var frameHeight = 170;

    // Create a new text frame
    var textFrame = page.textFrames.add({
        geometricBounds: [margin, margin, margin + frameHeight, margin + frameWidth],
        fillColor: "Yellow"
    });

    // Ensure the text frame is selected
    app.selection = textFrame;

    // Set vertical justification to top alignment
    textFrame.textFramePreferences.verticalJustification = VerticalJustification.TOP_ALIGN;

    // Ensure the text frame is not linked to any other frame
    textFrame.previousTextFrame = null;
    textFrame.nextTextFrame = null;

    return textFrame;
}

// Function to prompt the user to select a .txt or .docx file and place it in the text frame
function placeTextFile(textFrame) {
    // Prompt the user to select a file
    var file = File.openDialog("Select a .txt or .docx file to place in the text frame", "*.txt;*.docx", false);

    if (file != null) {
        // Place the file into the text frame
        textFrame.place(file);
        alert("File placed successfully!");
    } else {
        alert("No file selected. The text frame will remain empty.");
    }
}

// Initialization
function initializeScript() {
    if (app.selection.length === 0 || !(app.selection[0] instanceof TextFrame || app.selection[0] instanceof Story)) {
        // If no text frame is selected, create a new one
        masterTextFrame = createEmptyTextFrame();
        alert("No text frame selected. Created a new text frame on the first page with top alignment.");

        // Ask the user to select a .txt or .docx file and place it in the text frame
        placeTextFile(masterTextFrame);
    } else {
        masterTextFrame = app.selection[0];
    }

    if (masterTextFrame instanceof TextFrame || masterTextFrame instanceof Story) {
        pasteBuddyDialog.show();
        app.selection = null;
        activeDocument.addEventListener('afterSelectionChanged', handleSelectionChange);
    } else {
        alert("Select a text frame before running!");
        exit();
    }
}

// Selection Changed Event Handler
function handleSelectionChange() {
    if (isPaused) return;

    if (!masterTextFrame.isValid) {
        alert("The master text frame has been removed. Closing Pasting Buddy.");
        pasteBuddyDialog.close();
        return;
    }

    var selectedItem = activeDocument.selection[0];

    if (selectedItem instanceof InsertionPoint) selectedItem = selectedItem.parent.textContainers[0];
    if (selectedItem instanceof TextFrame || selectedItem instanceof Story) {
        if (selectedItem.contents == '' && masterTextFrame.contents != '') {
            if (masterTextFrame.paragraphs.length === 0) {
                alert("No text left in master frame!");
                return;
            }

            app.select(masterTextFrame.paragraphs[0], SelectionOptions.REPLACE_WITH);
            var nextText = "";
            if (masterTextFrame.paragraphs.length > 1) {
                nextText = masterTextFrame.paragraphs[1].contents;
            } else if (masterTextFrame.paragraphs.length === 1) {
                nextText = masterTextFrame.paragraphs[0].contents;
            }
            nextPasteTextEdit.text = nextText;
            app.cut();
            app.selection = null;
            selectedItem.texts.everyItem().select();

            if (isFormattingEnabled) {
                app.pasteWithoutFormatting();
            } else {
                app.paste();
            }
            previousPastedTextEdit.text = selectedItem.contents;

            app.selection = null;
            removeLineBreaks(selectedItem);
            selectedItem.parentStory.changeGrep();
        }

        if (masterTextFrame.contents == '') alert("No text to paste anymore!");
    }
}

// Remove Line Breaks
function removeLineBreaks(selectedItem) {
    app.findGrepPreferences.findWhat = "\r$";
    app.changeGrepPreferences.changeTo = "";
    selectedItem.changeGrep();
    selectedItem.parentStory.changeGrep();
}

// Function to Convert Accented Characters to Unicode Escape Sequences
function convertToUnicodeEscape(str) {
    return str.replace(/[^\x00-\x7F]/g, function(letter) {
        return "\\u" + ("0000" + letter.charCodeAt(0).toString(16)).slice(-4);
    });
}

// GREP Replace Function
function applyGrepReplaceToMasterFrame(find, replace) {
    if (masterTextFrame instanceof TextFrame) {
        var story = masterTextFrame.parentStory;

        var unicodeFind = convertToUnicodeEscape(find);
        app.findGrepPreferences.findWhat = unicodeFind;
        app.changeGrepPreferences.changeTo = replace;

        story.changeGrep();

        app.findGrepPreferences = NothingEnum.nothing;
        app.changeGrepPreferences = NothingEnum.nothing;
    } else {
        alert("Master frame is not a valid text frame.");
    }
}

// Assign Rainbow Colors to Layers
// https://github.com/saraoswald/Manga-Scripts
function assignLayerColors() {
    var layers = activeDocument.layers;

    function getRGB(index, totalLayers) {
        var position = index > 0 ? index / (totalLayers - 1) : index;
        return [red(position) * 250, green(position) * 250, blue(position) * 250];
    }

    function curve(x, xOffset) {
        return -16 * Math.pow(x - xOffset, 2) + 1;
    }

    function red(x) {
        if (x < 0.25) return 1;
        if (x >= 0.25 && x <= 0.5) return curve(x, 0.25);
        if (x >= 0.75) return curve(x, 1);
        return 0;
    }

    function green(x) {
        if (x <= 0.25) return curve(x, 0.25);
        if (x >= 0.25 && x <= 0.5) return 1;
        if (x >= 0.5 && x <= 0.75) return curve(x, 0.5);
        return 0;
    }

    function blue(x) {
        if (x >= 0.5 && x <= 0.75) return curve(x, 0.75);
        if (x > 0.75) return 1;
        return 0;
    }

    for (var i = 0; i < layers.length; i++) {
        layers[i].layerColor = getRGB(i, layers.length);
    }
}

// Find Empty Text Frames
// https://github.com/papatangosierra/Manga-Scripts-for-Indesign
function findEmptyTextFrames() {
    for (var i = 0; i < activeDocument.pages.length; i++) {
        var page = activeDocument.pages[i];
        for (var j = 0; j < page.textFrames.length; j++) {
            var frame = page.textFrames[j];
            if (frame.contents === '' && !frame.overflows) {
                app.selection = frame;
                alert('Empty text frame found on page ' + page.name + '.');
                return true;
            }
        }
    }
    alert('No empty text frames found.');
    return false;
}

// Document Setup Function
function setupDocument() {
    // Set the measurement units to millimeters
    app.scriptPreferences.measurementUnit = MeasurementUnits.MILLIMETERS;

    // Set the page width and height
    var pageWidth = 170;
    var pageHeight = 260;
    activeDocument.documentPreferences.pageWidth = pageWidth;
    activeDocument.documentPreferences.pageHeight = pageHeight;

    // Set vertical justification to Center for all new text frames
    var textFramePrefs = activeDocument.textFramePreferences;
    textFramePrefs.verticalJustification = VerticalJustification.CENTER_ALIGN;
    alert("Document set to " + pageWidth + "mm x " + pageHeight + "mm" + "\n" + "Set Alignment to Center.");
}

// Function to apply or remove transparency based on the toggle state
// https://www.reddit.com/r/indesign/comments/1g804g8/comment/lt07rbb
function applyTransparencyToAllObjects(applyTransparency) {
    var doc = app.activeDocument;
    var layers = doc.layers;
    var mainTextFrameLayer = masterTextFrame.itemLayer;

    for (var i = 0; i < layers.length; i++) {
        var layer = layers[i];
        if (layer === mainTextFrameLayer) continue;
        var pageItems = layer.allPageItems;

        for (var j = 0; j < pageItems.length; j++) {
            var obj = pageItems[j];

            if (
                obj instanceof Rectangle ||
                obj instanceof Oval ||
                obj instanceof Polygon ||
                obj instanceof GraphicLine ||
                obj instanceof TextFrame
            ) {
                obj.transparencySettings.blendingSettings.opacity = applyTransparency ? 50 : 100;
            }
        }
    }

    // Alert the user about the current state
    alert(applyTransparency ? "50% transparency applied to all objects." : "Transparency removed (100% opacity restored).");
}

// Start the script
initializeScript();
