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

# add tab to the children, based on data-parent and id attribute
for i in range(len(divs)):
    # Extract the parent and id attributes from the div
    parent_match = re.search(r'data-parent="(.*?)"', divs[i])
    id_match = re.search(r'id="(.*?)"', divs[i])
    if parent_match and id_match:
        parent = parent_match[1]
        child_id = id_match[1]
        parent_index = next((j for j in range(len(divs))if re.search(f'id="{parent}"', divs[j])), None)
        if parent_index is not None:
            # Add tabs before the child div based on the depth of the hierarchy
            depth = 1
            curr_id = parent
            while True:
                for k in range(len(divs)):
                    id_match = re.search(r'id="(.*?)"', divs[k])
                    if id_match and id_match[1] == curr_id:
                        if parent_match := re.search(r'data-parent="(.*?)"', divs[k]):
                            curr_id = parent_match[1]
                            depth += 1
                            break
                else:
                    break
            space_size = '' if depth == 2 else '  '
            divs[i] = space_size * (depth - 2) + '- ' + divs[i]

        else:
            # Add ## tag to the root parent
            divs[i] = f'# {divs[i]}\n' if i == 0 else f'## {divs[i]}\n'


# delete div tags, keeping only the text
for i in range(len(divs)):
    divs[i] = re.sub(r'<div[^>]+?>', '', divs[i])
    divs[i] = re.sub(r'<\/div>', '', divs[i])

# Join the divs into a single string and write to a markdown file
markdown = "\n\n".join(divs)
markdown = re.sub(r'\n(?!(#|\n))', '', markdown)  # add this line to remove empty lines in between
with open("output.md", "w", encoding='utf-8') as f:
    f.write(markdown)
