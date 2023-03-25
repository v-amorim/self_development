import re

INPUT_FILE = "input.html"
OUTPUT_FILE = "output.md"


def main():
    html = read_file(INPUT_FILE)
    divs = find_divs(html)
    remove_attributes_and_whitespace(divs)
    add_tabs_to_children(divs)
    remove_tags(divs)
    markdown = join_divs(divs)
    write_file(OUTPUT_FILE, markdown)


def read_file(filename):
    with open(filename, "r", encoding="utf-8") as f:
        return f.read()


def find_divs(html):
    pattern = r'<div[^>]+?contenteditable="false"[^>]*?>.*?<\/div>'
    return re.findall(pattern, html, re.DOTALL)


def remove_attributes_and_whitespace(divs):
    for i in range(len(divs)):
        div = re.sub(r'\s+contenteditable="false"', '', divs[i])
        div = re.sub(r'\n\s*', ' ', div)
        divs[i] = div


def add_tabs_to_children(divs):
    for i in range(len(divs)):
        parent_match = re.search(r'data-parent="(.*?)"', divs[i])
        id_match = re.search(r'id="(.*?)"', divs[i])
        if parent_match and id_match:
            parent = parent_match[1]
            parent_index = next((j for j in range(len(divs)) if re.search(f'id="{parent}"', divs[j])), None)
            if parent_index is not None:
                depth = get_depth(divs, parent) - 2
                space_size = '\t' * depth
                divs[i] = f'{space_size}- {divs[i]}' + f' [{depth}]'
            else:
                divs[i] = get_header(i, divs[i])


def get_depth(divs, parent_id):
    depth = 1
    curr_id = parent_id
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
    return depth


def get_header(i, div):
    return f'# {div}\n' if i == 0 else f'## {div}\n'


def remove_tags(divs):
    for i in range(len(divs)):
        divs[i] = re.sub(r'<div[^>]+?>', '', divs[i])
        divs[i] = re.sub(r'<\/div>', '', divs[i])


def join_divs(divs):
    markdown = "\n\n".join(divs)
    return re.sub(r'\n(?!(#|\n))', '', markdown)


def write_file(filename, content):
    with open(filename, "w", encoding="utf-8") as f:
        f.write(content)


if __name__ == "__main__":
    main()
