import re

# Read the contents of the HTML file
with open("input.html", "r", encoding='utf-8') as f:
    html = f.read()

# Find all divs with contenteditable="false"
pattern = r'<div[^>]+?contenteditable="false"[^>]*?>.*?<\/div>'
divs = re.findall(pattern, html, re.DOTALL)

# Remove unnecessary whitespace and contenteditable attribute from the divs
for i in range(len(divs)):
    div = re.sub(r'\s+contenteditable="false"', '', divs[i])
    div = re.sub(r'\n\s*', ' ', div)
    divs[i] = div

# Delete divs and add bullet points based on data-parent attribute


# Join the divs into a single string and write to a markdown file
markdown = "\n\n".join(divs)
with open("output.md", "w", encoding='utf-8') as f:
    f.write(markdown)
