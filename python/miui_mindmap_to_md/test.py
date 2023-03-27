from bs4 import BeautifulSoup


class HtmlParser:
    def __init__(self, filename):
        with open(filename, encoding='utf-8') as f:
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


parser = HtmlParser('page.html')
parser.parse()

# Print the adjacency list
[print(key, ':', value) for key, value in parser.div_dict.items()]
