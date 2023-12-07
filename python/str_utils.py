from __future__ import annotations

import time

CONTROL_SEQUENCES = {
    'UP': '\033[A',
    'ERASE_LINE': '\033[K',
    'RESET': '\033[0m',
}


def update_in_loop(content_generator, iterations, delay=0.1):
    for iteration in range(iterations):
        content = content_generator(iteration)
        print(f'{CONTROL_SEQUENCES["UP"]}{CONTROL_SEQUENCES["ERASE_LINE"]}{content}')
        time.sleep(delay)

    print(CONTROL_SEQUENCES['RESET'], end='')  # Reset to the default state after the loop


def loading_percentage_content(iteration):
    return f'Loading: {iteration}%'


# Example usage:
update_in_loop(loading_percentage_content, iterations=11)
print('HI')
