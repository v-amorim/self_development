import re

FILENAME = "structure3"

# Read the contents of the HTML file
with open(f"{FILENAME}.html", "r", encoding='utf-8') as f:
    html = f.read()

# Find all divs with contenteditable="false"
pattern = r'<div[^>]+?contenteditable="false"[^>]*?>.*?<\/div>'
divs = re.findall(pattern, html, re.DOTALL)

# Remove unnecessary whitespace and contenteditable attribute from the divs
for i in range(len(divs)):
    div = re.sub(r'\s+contenteditable="false"', '', divs[i])
    div = re.sub(r'\n\s*', ' ', div)
    divs[i] = div

# Create a dictionary to store the graph
graph = {}

# Create a function to add nodes to the graph


def add_node(node_id, parent_id, text):
    if node_id not in graph:
        graph[node_id] = {'text': text, 'children': []}
    if parent_id is not None:
        if parent_id not in graph:
            graph[parent_id] = {'text': '', 'children': []}
        graph[parent_id]['children'].append(node_id)


# Add nodes to the graph
for div in divs:
    node_id = re.search(r'id="(.*?)"', div).group(1)
    parent_id = re.search(r'data-parent="(.*?)"', div)
    parent_id = parent_id.group(1) if parent_id else None
    text = re.sub(r'<[^>]*>', '', div)
    add_node(node_id, parent_id, text)

# Print the graph
print(graph)
