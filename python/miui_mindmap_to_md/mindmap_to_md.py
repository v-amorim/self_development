import tempfile
import shutil
import pyperclip
from bs4 import BeautifulSoup


class HtmlParser:
    def __init__(self, filename):
        self.temp_file = None
        filename = self._get_filename(filename)
        self._parse_html(filename)

    def _get_filename(self, filename):
        filename = f"{filename}.html"
        if pyperclip.paste().count('<div') > 0:
            self.temp_file = tempfile.NamedTemporaryFile(mode='w', delete=False).name
            with open(self.temp_file, "w", encoding='utf-8') as f:
                f.write(pyperclip.paste())
            filename = self.temp_file
        return filename

    def _parse_html(self, filename):
        with open(filename, encoding='utf-8') as f:
            self.soup = BeautifulSoup(f, 'html.parser')
        self.div_dict = {}

    def parse(self):
        self._parse_title_div()
        self._parse_editable_divs()

        return self.div_dict

    def _parse_title_div(self):
        if title_div := self.soup.find('div', {'id': 'title'}):
            title_text = title_div.text.strip()
            self.div_dict['title'] = {
                'text': title_text,
                'children': []
            }

    def _parse_editable_divs(self):
        editable_divs = self.soup.find_all('div', {'id': True, 'data-parent': True, 'class': True})

        for editable_div in editable_divs:
            div_id = editable_div['id']

            if div_id not in self.div_dict:
                div_text = " ".join(editable_div.text.split())
                self.div_dict[div_id] = {
                    'text': div_text,
                    'children': []
                }

            parent_id = editable_div['data-parent']
            if parent_id in self.div_dict:
                self.div_dict[parent_id]['children'].append(div_id)
            else:
                self.div_dict[parent_id] = {
                    'text': '',
                    'children': [div_id]
                }


class MindmapConverter:
    def __init__(self, graph):
        self.graph = graph
        self.temp_file = self.create_temp_file()
        self.title = self.graph['title']['text']

    def dfs(self, node_id, depth=0, is_root=False):
        node = self.graph[node_id]
        text = node['text']
        is_tile = (depth == 0)

        with open(self.temp_file, "a", encoding='utf-8') as f:
            if is_tile:
                f.write(f"# {self.title}\n\n")

            if is_root:
                if node_id == self.graph['root']['children'][0]:
                    f.write(f"## {text}\n\n")
                else:
                    f.write(f"\n## {text}\n\n")
            elif text != '':
                indent = "  " * (depth - 2)
                f.write(f"{indent}- {text}\n")

        for child_id in node['children']:
            self.dfs(child_id, depth + 1, is_root=(node_id == 'root'))

    def create_temp_file(self):
        return tempfile.NamedTemporaryFile(mode='w', delete=False).name

    def convert(self):
        self.dfs('root')
        title_formatted = self.title.replace('/', '.')
        shutil.move(self.temp_file, f"{title_formatted}.md")


if __name__ == '__main__':
    html_parser = HtmlParser('page')
    div_dict = html_parser.parse()
    converter = MindmapConverter(div_dict)
    converter.convert()

    # Print the adjacency list
    # [print(key, ':', value) for key, value in div_dict.items()]
