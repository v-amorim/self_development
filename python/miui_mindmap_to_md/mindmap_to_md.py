import tempfile
import shutil
from bs4 import BeautifulSoup


class HtmlParser:
    def __init__(self, filename):
        with open(f'{filename}.html', encoding='utf-8') as f:
            self.soup = BeautifulSoup(f, 'html.parser')
        self.div_dict = {}

    def parse(self):
        if title_div := self.soup.find('div', {'id': 'title'}):
            title_text = title_div.text.strip()
            self.div_dict['title'] = {'text': title_text, 'children': []}

        editable_divs = self.soup.find_all('div', {'id': True, 'data-parent': True, 'class': True})
        for editable_div in editable_divs:
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

        return self.div_dict


class MindmapConverter:
    def __init__(self, graph):
        self.graph = graph
        self.temp_file = self.create_temp_file()
        self.title = self.graph['title']['text']

    def dfs(self, node_id, depth=0, is_root=False, is_title=True):
        node = self.graph[node_id]
        text = node['text']
        with open(self.temp_file, "a", encoding='utf-8') as f:
            if is_title:
                f.write(f"# {self.title}\n\n")
            if is_root:
                if node_id == self.graph['root']['children'][0]:
                    f.write(f"## {text}\n\n")
                if node_id in self.graph['root']['children'][1:]:
                    f.write(f"\n## {text}\n\n")
            elif text != '':
                indent = "  " * (depth - 2)
                f.write(f"{indent}- {text}\n")
        for child_id in node['children']:
            self.dfs(child_id, depth + 1, is_root=(node_id == 'root'), is_title=False)

    def create_temp_file(self):
        return tempfile.NamedTemporaryFile(mode='w', delete=False).name

    def convert(self):
        self.dfs('root')
        shutil.move(self.temp_file, f"{self.title}.md")


if __name__ == '__main__':
    html_parser = HtmlParser('page')
    div_dict = html_parser.parse()
    converter = MindmapConverter(div_dict)
    converter.convert()

    # Print the adjacency list
    # [print(key, ':', value) for key, value in div_dict.items()]
