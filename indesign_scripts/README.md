![][waves_top]

<div  align="center">
   <h1>🎴Self Development - Indesign Scripts🎴</h1>

[Home][README_self_development] | [Config][README_config] | [Indesign Scripts][README_indesign_scripts] | [Macros][README_macros] | [Python][README_python] | [Ruby][README_ruby] | [LaTeX][README_tex]

</div>

## Indesign Scripts

General InDesign Scripts primarily designed for use in manga lettering

### [Letterer Buddy][LettererBuddy]

![](https://i.imgur.com/GlA0Mjr.png) ![](https://i.imgur.com/qwmELup.png)

Allows you to load a script in a .txt file and automatically input lines into text frames as they're being created (in a similar vein to Typesetterer). At the moment, it simply takes a text file and reads it line by line, so some prior formatting will be required to make it output properly.

#### Usage

1. Run the script file inside InDesign
1. Select your text file.
1. Create a text frame and shape/place/format as you wish. DO NOT ENTER ANY TEXT as the text frame needs to be empty for this to work.
1. Press escape to exit the text editing function of the text frame. This will set the contents of the text frame to the currently selected item in the script list.

You can choose your starting point by selecting the required line in the script list.

This is an early version of the script, and changes will most likely be coming quicky in order to further flesh it out. It hasn't been tested that much, so I expect some bugs to happen while using it. Please contact me with any issues which may occur while using this script.

### [Pasting Buddy][PastingBuddy]

Awesome tool for lettering comics. It allows you to skip the usual copy-paste process and paste text directly into text frames. Has a few options to help you format the text as you paste it.

### [Bubble Mask][Bubble_Mask]

Removes content inside selected areas of a text frame. Useful to clean speech bubbles.

### [Multi Page Importer][MultiPageImporter]

Allows you to import multiple pages of a PDF into InDesign. Useful for importing manga pages. Has tons of options to help you import the pages exactly as you want.

<!-- URLS -->

[README_self_development]: ../README.md
[README_indesign_scripts]: README.md
[README_macros]: ../macros/README.md
[README_config]: ../config/README.md
[README_python]: ../python/README.md
[README_ruby]: ../ruby/README.md
[README_tex]: ../tex/README.md
[waves_top]: https://raw.githubusercontent.com/v-amorim/v-amorim/main/svg/Top.svg

<!-- URLS -->

[LettererBuddy]: ./lettererbuddy.jsx
[PastingBuddy]: ./.Pasting%20Buddy.jsx
[Bubble_Mask]: ./Bubble_Mask.atn
[MultiPageImporter]: ./MultiPageImporter.jsx
