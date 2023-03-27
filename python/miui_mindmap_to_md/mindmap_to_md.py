import re
import tempfile
import shutil
from bs4 import BeautifulSoup


class HTMLMindmaptoMDConverter:
    def __init__(self, filename):
        self.filename = filename
        self.html = self.read_file()
        self.divs = self.get_divs()
        self.graph = {}
        self.temp_file = self.create_temp_file()

    def read_file(self):
        with open(f"{self.filename}.html", "r", encoding='utf-8') as f:
            return f.read()

    def get_divs(self):
        pattern = r'<div[^>]+?contenteditable="false"[^>]*?>.*?<\/div>'
        return re.findall(pattern, self.html, re.DOTALL)

    def clean_div(self, div):
        div = re.sub(r'\s+contenteditable="false"', '', div)
        div = re.sub(r'\n\s*', ' ', div)
        return div

    def add_node(self, node_id, parent_id, text):
        if node_id not in self.graph:
            self.graph[node_id] = {'text': text, 'children': []}
        if parent_id is not None:
            if parent_id not in self.graph:
                self.graph[parent_id] = {'text': '', 'children': []}
            self.graph[parent_id]['children'].append(node_id)

    def dfs(self, node_id, depth=0, is_root=False):
        node = self.graph[node_id]
        text = node['text']
        with open(self.temp_file, "a", encoding='utf-8') as f:
            if is_root:
                if node_id == self.graph['root']['children'][0]:
                    f.write(f"# {text}\n\n")
                if node_id in self.graph['root']['children'][1:]:
                    f.write(f"\n# {text}\n\n")
            elif text != '':
                indent = "  " * (depth - 2)
                f.write(f"{indent}- {text}\n")
        for child_id in node['children']:
            self.dfs(child_id, depth + 1, is_root=(node_id == 'root'))

    def create_temp_file(self):
        return tempfile.NamedTemporaryFile(mode='w', delete=False).name

    def convert(self):
        for div in self.divs:
            node_id = re.search(r'id="(.*?)"', div)[1]
            parent_id = re.search(r'data-parent="(.*?)"', div)
            parent_id = parent_id[1] if parent_id else None
            text = re.sub(r'<[^>]*>', '', self.clean_div(div))
            text = text.strip()
            self.add_node(node_id, parent_id, text)

        self.dfs('root')
        shutil.move(self.temp_file, f"{self.filename}.md")


class HtmlParser:
    def __init__(self, filename):
        with open(f'{filename}.html', encoding='utf-8') as f:
            self.soup = BeautifulSoup(f, 'html.parser')
        self.div_dict = {}

    def parse(self):
        if title_div := self.soup.find('div', {'id': 'title'}):
            title_text = title_div.text.strip()
            self.div_dict['title'] = {'text': title_text, 'children': []}

        editable_divs = self.soup.find_all(
            'div', {'id': True, 'data-parent': True, 'class': True, 'contenteditable': True})
        for editable_div in editable_divs:
            # Remove unnecessary spaces and linebreaks
            text = " ".join(editable_div.text.split())
            div_id = editable_div['id']
            div_text = text
            div_children = []
            self.div_dict[div_id] = {'text': div_text, 'children': div_children}

            parent_id = editable_div['data-parent']
            if parent_id in self.div_dict:
                self.div_dict[parent_id]['children'].append(div_id)
            else:
                self.div_dict[parent_id] = {'text': '', 'children': [div_id]}


if __name__ == '__main__':
    parser = HtmlParser('page')
    parser.parse()
    converter = HTMLMindmaptoMDConverter('page')
    converter.convert()

    # Print the adjacency list
    [print(key, ':', value) for key, value in parser.div_dict.items()]
