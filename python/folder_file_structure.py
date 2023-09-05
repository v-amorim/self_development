from __future__ import annotations

import os

import pyperclip


def generate_structure(path, root_folder_name, indent=''):
    # Get the list of items in the directory
    items = os.listdir(path)

    output = []

    for item in items:
        item_path = os.path.join(path, item)

        if item == 'folder_file_structure.py':
            continue

        if os.path.isdir(item_path):
            if item == '__pycache__':
                continue

            output.append(f'{indent}├── {item}')
            # Recursively generate structure for subdirectories
            output.extend(generate_structure(item_path, root_folder_name, f'{indent}│   '))
        elif not item.endswith('.pyc'):
            output.append(f'{indent}└── {item}')

    return output


if __name__ == '__main__':
    current_directory = os.getcwd()
    root_folder_name = os.path.basename(current_directory)
    result = [root_folder_name]
    result.extend(generate_structure(current_directory, root_folder_name))
    clipboard_text = '\n'.join(result)
    pyperclip.copy(clipboard_text)
    print('Folder structure copied to clipboard.')
